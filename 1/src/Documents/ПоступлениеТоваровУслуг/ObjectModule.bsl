
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.ЗадолженностьПоставщикам.Записывать = Истина;
	Движения.Затраты.Записывать = Истина;
	Движения.ОстаткиТоваров.Записывать = Истина;

	Для Каждого ТекСтрокаТовары Из Товары Цикл
		
		Движение = Движения.Затраты.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
		
		Движение = Движения.ОстаткиТоваров.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
		Движение.Количество = ТекСтрокаТовары.Количество;
		
	КонецЦикла;

	Для Каждого ТекСтрокаУслуги Из Услуги Цикл
		Движение = Движения.Затраты.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаУслуги.Номенклатура;
		Движение.Сумма = ТекСтрокаУслуги.Сумма;
	КонецЦикла;
 
	Движение = Движения.ЗадолженностьПоставщикам.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Договор = Договор;
	Движение.Сумма = СуммаДокумента;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
