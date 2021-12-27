﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПодготовитьФормуНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_НаборКонстант" 
		И Источник = "ИспользоватьСтатьиДвиженияДенежныхСредств" Тогда
		ПодготовитьФормуНаСервере();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВключитьВыключитьУчетПоСтатьямДДС(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТекущаяСтраница", "ГруппаБанкКасса");
	ОткрытьФорму("Обработка.ФункциональностьПрограммы.Форма.ФормаФункциональностьПрограммы",
		ПараметрыФормы, 
		ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПодготовитьФормуНаСервере()

	ИспользоватьСтатьиДвиженияДенежныхСредств = Константы.ИспользоватьСтатьиДвиженияДенежныхСредств.Получить();
	
	УправлениеФормой(ЭтотОбъект);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Если Форма.ИспользоватьСтатьиДвиженияДенежныхСредств Тогда
		Форма.Элементы.ВключитьВыключитьУчетПоСтатьямДДС.Заголовок = НСтр("ru='Выключить'");
	Иначе
		Форма.Элементы.ВключитьВыключитьУчетПоСтатьямДДС.Заголовок = НСтр("ru='Включить'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВедетсяУчетНФО()

	Возврат ПолучитьФункциональнуюОпцию("ВедетсяУчетНФО");

КонецФункции

#КонецОбласти
