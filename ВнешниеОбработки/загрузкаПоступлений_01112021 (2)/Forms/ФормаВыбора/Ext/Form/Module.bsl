
&НаКлиенте
Процедура Выбрать(Команда)

	АдресПередаваемыхПараметров = ПоместитьЗначенияВХралищие();
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Адрес",АдресПередаваемыхПараметров);
	
	Закрыть(СтруктураПараметров);

КонецПроцедуры
&НаСервере
Функция ПоместитьЗначенияВХралищие()
	
	Перем СтруктураПараметров;
		для каждого стрФ из ЭтаФорма.Элементы.СписокРеализаций.ВыделенныеСтроки цикл
		стр= Объект.ТабличнаяЧасть.Добавить();
		стр.РеализацияТоваровИУслуг = стрф;
	КонецЦикла;	
	СтруктураПараметров = Новый Структура;
	
	СтруктураПараметров.Вставить("ТабличнаяЧасть",Объект.ТабличнаяЧасть.Выгрузить());
	
	Адрес = ПоместитьВоВременноеХранилище(СтруктураПараметров,Новый УникальныйИдентификатор);
	Возврат Адрес; 
	
КонецФункции
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СтруктураПараметров = ПолучитьИзВременногоХранилища(Параметры.Адрес);
		
	Объект.ТабличнаяЧасть.Загрузить(СтруктураПараметров.ТабличнаяЧасть);

КонецПроцедуры
