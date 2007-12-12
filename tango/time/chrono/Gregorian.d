/*******************************************************************************

        copyright:      Copyright (c) 2005 John Chapman. All rights reserved

        license:        BSD style: $(LICENSE)

        version:        Mid 2005: Initial release
                        Apr 2007: reshaped                        

        author:         John Chapman, Kris

******************************************************************************/

module tango.time.chrono.Gregorian;

private import tango.time.chrono.Calendar;


/**
 * $(ANCHOR _GregorianCalendar)
 * Represents the Gregorian calendar.
*/
class GregorianCalendar : Calendar 
{
        // import baseclass toTime()
        alias Calendar.toTime toTime;

        /// static shared instance
        public static GregorianCalendar generic;

        enum Type 
        {
                Localized = 1,               /// Refers to the localized version of the Gregorian calendar.
                USEnglish = 2,               /// Refers to the US English version of the Gregorian calendar.
                MiddleEastFrench = 9,        /// Refers to the Middle East French version of the Gregorian calendar.
                Arabic = 10,                 /// Refers to the _Arabic version of the Gregorian calendar.
                TransliteratedEnglish = 11,  /// Refers to the transliterated English version of the Gregorian calendar.
                TransliteratedFrench = 12    /// Refers to the transliterated French version of the Gregorian calendar.
        }

        private Type type_;                 

        /**
        * Represents the current era.
        */
        enum {AD_ERA = 1, MAX_YEAR = 9999};

        private static final int[] DaysToMonthCommon = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365];

        private static final int[] DaysToMonthLeap   = [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366];

        /**
        * create a generic instance of this calendar
        */
        static this()
        {       
                generic = new GregorianCalendar;
        }

        /**
        * Initializes an instance of the GregorianCalendar class using the specified GregorianTypes value. If no value is 
        * specified, the default is Gregorian.Types.Localized.
        */
        this (Type type = Type.Localized) 
        {
                type_ = type;
        }

        /**
        * Overridden. Returns a Time value set to the specified date and time in the specified _era.
        * Params:
        *   year = An integer representing the _year.
        *   month = An integer representing the _month.
        *   day = An integer representing the _day.
        *   hour = An integer representing the _hour.
        *   minute = An integer representing the _minute.
        *   second = An integer representing the _second.
        *   millisecond = An integer representing the _millisecond.
        *   era = An integer representing the _era.
        * Returns: A Time set to the specified date and time.
        */
        override Time toTime (int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
        {
                return Time (getDateTicks(year, month, day) + getTimeTicks(hour, minute, second)) + TimeSpan.millis(millisecond);
        }

        /**
        * Overridden. Returns the day of the week in the specified Time.
        * Params: time = A Time value.
        * Returns: A DayOfWeek value representing the day of the week of time.
        */
        override DayOfWeek getDayOfWeek(Time time) 
        {
                return cast(DayOfWeek)((time.ticks / TimeSpan.TicksPerDay + 1) % 7);
        }

        /**
        * Overridden. Returns the day of the month in the specified Time.
        * Params: time = A Time value.
        * Returns: An integer representing the day of the month of time.
        */
        override int getDayOfMonth(Time time) 
        {
                return extractPart(time.ticks, DatePart.Day);
        }

        /**
        * Overridden. Returns the day of the year in the specified Time.
        * Params: time = A Time value.
        * Returns: An integer representing the day of the year of time.
        */
        override int getDayOfYear(Time time) 
        {
                return extractPart(time.ticks, DatePart.DayOfYear);
        }

        /**
        * Overridden. Returns the month in the specified Time.
        * Params: time = A Time value.
        * Returns: An integer representing the month in time.
        */
        override int getMonth(Time time) 
        {
                return extractPart(time.ticks, DatePart.Month);
        }

        /**
        * Overridden. Returns the year in the specified Time.
        * Params: time = A Time value.
        * Returns: An integer representing the year in time.
        */
        override int getYear(Time time) 
        {
                return extractPart(time.ticks, DatePart.Year);
        }

        /**
        * Overridden. Returns the era in the specified Time.
        * Params: time = A Time value.
        * Returns: An integer representing the ear in time.
        */
        override int getEra(Time time) 
        {
                return AD_ERA;
        }

        /**
        * Overridden. Returns the number of days in the specified _year and _month of the specified _era.
        * Params:
        *   year = An integer representing the _year.
        *   month = An integer representing the _month.
        *   era = An integer representing the _era.
        * Returns: The number of days in the specified _year and _month of the specified _era.
        */
        override int getDaysInMonth(int year, int month, int era) 
        {
                int[] monthDays = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? DaysToMonthLeap : DaysToMonthCommon;
                return monthDays[month] - monthDays[month - 1];
        }

        /**
        * Overridden. Returns the number of days in the specified _year of the specified _era.
        * Params:
        *   year = An integer representing the _year.
        *   era = An integer representing the _era.
        * Returns: The number of days in the specified _year in the specified _era.
        */
        override int getDaysInYear(int year, int era) 
        {
                return isLeapYear(year, era) ? 366 : 365;
        }

        /**
        * Overridden. Returns the number of months in the specified _year of the specified _era.
        * Params:
        *   year = An integer representing the _year.
        *   era = An integer representing the _era.
        * Returns: The number of months in the specified _year in the specified _era.
        */
        override int getMonthsInYear(int year, int era) 
        {
                return 12;
        }

        /**
        * Overridden. Indicates whether the specified _year in the specified _era is a leap _year.
        * Params: year = An integer representing the _year.
        * Params: era = An integer representing the _era.
        * Returns: true is the specified _year is a leap _year; otherwise, false.
        */
        override bool isLeapYear(int year, int era) 
        {
                return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        }

        /**
        * $(I Property.) Retrieves the GregorianTypes value indicating the language version of the GregorianCalendar.
        * Returns: The Gregorian.Type value indicating the language version of the GregorianCalendar.
        */
        Type calendarType() 
        {
                return type_;
        }

        /**
        * $(I Property.) Overridden. Retrieves the list of eras in the current calendar.
        * Returns: An integer array representing the eras in the current calendar.
        */
        override int[] eras() 
        {       
                int[] tmp = [AD_ERA];
                return tmp.dup;
        }

        /**
        * $(I Property.) Overridden. Retrieves the identifier associated with the current calendar.
        * Returns: An integer representing the identifier of the current calendar.
        */
        override int id() 
        {
                return cast(int) type_;
        }

        override void split(Time time, ref int year, ref int month, ref int day, ref int dayOfYear, ref DayOfWeek dayOfWeek, ref int era)
        {
            splitDate(time.ticks, year, month, day, dayOfYear);
            era = AD_ERA;
            dayOfWeek = getDayOfWeek(time);
        }

        package static void splitDate (long ticks, ref int year, ref int month, ref int day, ref int dayOfYear) 
        {
                int numDays = cast(int)(ticks / TimeSpan.TicksPerDay);
                int whole400Years = numDays / cast(int) TimeSpan.DaysPer400Years;
                numDays -= whole400Years * cast(int) TimeSpan.DaysPer400Years;
                int whole100Years = numDays / cast(int) TimeSpan.DaysPer100Years;
                if (whole100Years == 4)
                    whole100Years = 3;

                numDays -= whole100Years * cast(int) TimeSpan.DaysPer100Years;
                int whole4Years = numDays / cast(int) TimeSpan.DaysPer4Years;
                numDays -= whole4Years * cast(int) TimeSpan.DaysPer4Years;
                int wholeYears = numDays / cast(int) TimeSpan.DaysPerYear;
                if (wholeYears == 4)
                    wholeYears = 3;

                year = whole400Years * 400 + whole100Years * 100 + whole4Years * 4 + wholeYears + 1;
                numDays -= wholeYears * TimeSpan.DaysPerYear;
                dayOfYear = numDays + 1;

                int[] monthDays = (wholeYears == 3 && (whole4Years != 24 || whole100Years == 3)) ? DaysToMonthLeap : DaysToMonthCommon;
                month = numDays >> 5 + 1;
                while (numDays >= monthDays[month])
                       month++;

                day = numDays - monthDays[month - 1] + 1;
        }

        package static int extractPart (long ticks, DatePart part) 
        {
                int year, month, day, dayOfYear;

                splitDate(ticks, year, month, day, dayOfYear);

                if (part is DatePart.Year)
                    return year;

                if (part is DatePart.Month)
                    return month;

                if (part is DatePart.DayOfYear)
                    return dayOfYear;

                return day;
        }

        package long getDateTicks (int year, int month, int day) 
        {
                int[] monthDays = isLeapYear(year, AD_ERA) ? DaysToMonthLeap : DaysToMonthCommon;
                year--;
                return (year * 365 + year / 4 - year / 100 + year / 400 + monthDays[month - 1] + day - 1) * TimeSpan.TicksPerDay;
        }
}