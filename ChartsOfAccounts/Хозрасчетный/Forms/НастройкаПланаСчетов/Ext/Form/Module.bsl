#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбновитьПредставленияНастроек();
	
	Элементы.УчетЗатрат.Видимость = ПланыСчетов.Хозрасчетный.ДоступнаНастройкаУчетаЗатратПоПодразделениям();
	
	Элементы.УчетРасходов.Видимость = УчетнаяПолитика.ПоддерживаетсяУчетПоЭлементамЗатрат();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеНастройкиПланаСчетов" Тогда
		ОбновитьПредставленияНастроек();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура УчетДвиженияДенежныхСредствНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетДвиженияДенежныхСредств",, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УчетСуммНДСПоПриобретеннымЦенностямНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетСуммНДСПоПриобретеннымЦенностям",, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УчетЗапасовНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетЗапасов",, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УчетТоваровВРозницеНажатие(Элемент, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетТоваровВРознице",, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УчетРасчетовСПерсоналомНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетРасчетовСПерсоналом",, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УчетЗатратНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетЗатрат",, ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура УчетРасходовНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ПланСчетов.Хозрасчетный.Форма.УчетРасходов",, ЭтаФорма);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьПредставленияНастроек()
	
	ПараметрыУчета = ОбщегоНазначенияБП.ОпределитьПараметрыУчета();
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ПараметрыУчета);
	
	// Учет движения денежных средств.
	МассивПредставленийНастроек = Новый Массив;
	МассивПредставленийНастроек.Добавить(НСтр("ru='По расчетным счетам'"));
	Если Константы.ИспользоватьСтатьиДвиженияДенежныхСредств.Получить() Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='статьям движения денежных средств'"));
	КонецЕсли;
	УчетДвиженияДенежныхСредств = ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек);
	
	// Учет сумм НДС по приобретенным ценностям.
	МассивПредставленийНастроек = Новый Массив;
	МассивПредставленийНастроек.Добавить(НСтр("ru='По контрагентам'"));
	МассивПредставленийНастроек.Добавить(НСтр("ru='счетам-фактурам полученным'"));
	Если ВестиУчетНДСПоСпособам Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='способам учета'"));
	КонецЕсли;
	УчетСуммНДСПоПриобретеннымЦенностям = ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек);
		
	// Учет запасов.
	МассивПредставленийНастроек = Новый Массив;
	МассивПредставленийНастроек.Добавить(НСтр("ru='По номенклатуре'"));
	Если ВестиПартионныйУчет Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='партиям'"));
	КонецЕсли;
	Если СкладскойУчет = 1 Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='складам (по количеству)'"));
	ИначеЕсли СкладскойУчет = 2 Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='складам (по количеству и сумме)'"));
	КонецЕсли;
	УчетЗапасов = ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек);
	
	// Учет товаров в рознице.
	МассивПредставленийНастроек = Новый Массив;
	МассивПредставленийНастроек.Добавить(НСтр("ru='По складам'"));
	Если ИспользоватьОборотнуюНоменклатуру Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='номенклатуре (обороты)'"));
	КонецЕсли;
	Если РазделятьПоСтавкамНДС Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='ставкам НДС'"));
	КонецЕсли;
	УчетТоваровВРознице = ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек);
	
	// Учет расчетов с персоналом.
	УчетРасчетовСПерсоналом = ?(ВестиУчетПоРаботникам,
		НСтр("ru='По каждому работнику'"),
		НСтр("ru='Сводно по всем работникам'"));
	
	// Учет затрат.
	УчетЗатрат = ?(Константы.ВестиУчетЗатратПоПодразделениям.Получить(),
		НСтр("ru='По каждому подразделению'"),
		НСтр("ru='Сводно, по организации в целом'"));
		
	// Учет расходов.
	МассивПредставленийНастроек = Новый Массив;
	МассивПредставленийНастроек.Добавить(НСтр("ru='По номенклатурным группам'"));
	Если УчитыватьРасходыПоЭлементамЗатрат Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='элементам затрат'"));
	КонецЕсли;
	Если УчитыватьРасходыПоСтатьямЗатрат Тогда
		МассивПредставленийНастроек.Добавить(НСтр("ru='статьям затрат'"));
	КонецЕсли;
	УчетРасходов = ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек);	
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьЛитературноеОписаниеМассиваНастроек(МассивПредставленийНастроек)
	
	Результат = "";
	
	Для каждого Элемент Из МассивПредставленийНастроек Цикл
		
		Если НЕ ПустаяСтрока(Результат) Тогда
		
			Если МассивПредставленийНастроек.Найти(Элемент) = МассивПредставленийНастроек.ВГраница() Тогда
				Результат = Результат + НСтр("ru=' и '");
			Иначе
				Результат = Результат + НСтр("ru=', '");
			КонецЕсли;
			
		КонецЕсли;
		
		Результат = Результат + Элемент;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти



