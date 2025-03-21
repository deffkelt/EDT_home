// @strict-types
#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПолучитьИтоги(Команда)
	ПолучитьИтогиНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПолучитьИтогиНаСервере()

	Результат = РассчитатьИтоги(НачалоПериода, ОкончаниеПериода);
	Продажи.Загрузить(Результат);

КонецПроцедуры

// Рассчитать итоги
// 
// Параметры:
//  НачалоПериода - Дата - Начало периода
//  ОкончаниеПериода - Дата - Окончание периода
// 
// Возвращаемое значение:
//  ТаблицаЗначений:
//  * Покупатель - СправочникСсылка.Контрагенты
//  * Товар - СправочникСсылка.Товары
//  * Количество - Число
//  * Сумма - Число
Функция РассчитатьИтоги(НачалоПериода, ОкончаниеПериода)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПродажиОбороты.Покупатель,
	|	ПродажиОбороты.Товар,
	|	ПродажиОбороты.КоличествоОборот КАК Количество,
	|	ПродажиОбороты.СуммаОборот КАК Сумма
	|ИЗ
	|	РегистрНакопления.Продажи.Обороты(&НачалоПериода, &ОкончаниеПериода,,) КАК ПродажиОбороты";

	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("ОкончаниеПериода", ОкончаниеПериода);
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();

	Возврат РезультатЗапроса;

КонецФункции

#КонецОбласти