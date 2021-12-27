﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПередЗаписью(Отказ)

	Если ПланыСчетов.Хозрасчетный.ПропущенаБизнесЛогикаПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если Предопределенный 
		И Родитель <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "Родитель") Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Нельзя изменять подчиненность предопределенных счетов!'"), ЭтотОбъект, "Родитель", , Отказ);
	КонецЕсли;
	
	Порядок = ПолучитьПорядокКода();

	Если НЕ ЗначениеЗаполнено(КодБыстрогоВыбора) Тогда
		КодБыстрогоВыбора = СокрЛП(СтрЗаменить(Код, ".", ""));
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	СчетаРасчетов = Новый Массив(3);
	СчетаРасчетов[0] = ПланыСчетов.Хозрасчетный.РасчетыСПоставщикамиИПодрядчиками;
	СчетаРасчетов[1] = ПланыСчетов.Хозрасчетный.РасчетыСПокупателямиИЗаказчиками;
	СчетаРасчетов[2] = ПланыСчетов.Хозрасчетный.РасчетыСРазнымиДебиторамиИКредиторами;
	СчетаРасчетов = БухгалтерскийУчет.СформироватьМассивСубсчетов(СчетаРасчетов);
	
	СчетаИсключения = ПланыСчетов.Хозрасчетный.ПолучитьСчетаИсключения();
	СчетаИсключения.Добавить(ПланыСчетов.Хозрасчетный.РасчетыСРазнымиДебиторамиИКредиторами);
	СчетаРасчетов = ОбщегоНазначенияКлиентСервер.РазностьМассивов(СчетаРасчетов, СчетаИсключения);
	
	Если СчетаРасчетов.Найти(Ссылка) <> Неопределено
	   И ВидыСубконто.Найти(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.Договоры) <> Неопределено Тогда // это счет расчетов
	   
	    ВидСубконтоДокументыРасчетов =
			ВидыСубконто.Найти(ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.ДокументыРасчетовСКонтрагентами);
		
		Если ВидСубконтоДокументыРасчетов = Неопределено Тогда
				
			ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения("Список", "Корректность",,, НСтр("ru = 'Виды субконто'"),
				НСтр("ru = 'На счетах расчетов с контрагентами обязательно наличие субконто ""Документы расчетов с контрагентом"".'"));
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "ВидыСубконто", "Объект", Отказ);
			
		Иначе
			
			Если ВидСубконтоДокументыРасчетов.ТолькоОбороты Тогда
				ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения("Список", "Корректность",,, НСтр("ru = 'Виды субконто'"),
					НСтр("ru = 'Субконто ""Документы расчетов с контрагентом"" не может быть оборотным.'"));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "ВидыСубконто", "Объект", Отказ);
			КонецЕсли;
			Если НЕ ВидСубконтоДокументыРасчетов.Суммовой Тогда
				ТекстСообщения = ОбщегоНазначенияКлиентСервер.ТекстОшибкиЗаполнения("Список", "Корректность",,, НСтр("ru = 'Виды субконто'"),
					НСтр("ru = 'Субконто ""Документы расчетов с контрагентом"" обязательно должен быть суммовым.'"));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, ЭтотОбъект, "ВидыСубконто", "Объект", Отказ);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НастроитьПоКоду(СохранятьЗаполненныйКодБыстрогоВыбора = Ложь) Экспорт 

	Если Не ЗначениеЗаполнено(Код) Тогда 
		Возврат; 
	КонецЕсли; 

	Порядок = ПолучитьПорядокКода(); 

	Если Не СохранятьЗаполненныйКодБыстрогоВыбора 
		Или Не ЗначениеЗаполнено(КодБыстрогоВыбора) Тогда 
		КодБыстрогоВыбора = СокрЛП(СтрЗаменить(Код, ".", "")); 
	КонецЕсли; 

КонецПроцедуры

#КонецЕсли