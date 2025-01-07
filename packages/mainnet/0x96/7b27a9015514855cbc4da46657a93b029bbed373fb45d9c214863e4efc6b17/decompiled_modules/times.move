module 0x967b27a9015514855cbc4da46657a93b029bbed373fb45d9c214863e4efc6b17::times {
    public fun days(arg0: u64) : u64 {
        86400 * arg0
    }

    public fun days_in_milliseconds(arg0: u64) : u64 {
        86400000 * arg0
    }

    public fun hours(arg0: u64) : u64 {
        3600 * arg0
    }

    public fun hours_in_milliseconds(arg0: u64) : u64 {
        3600000 * arg0
    }

    public fun minutes(arg0: u64) : u64 {
        60 * arg0
    }

    public fun minutes_in_milliseconds(arg0: u64) : u64 {
        60000 * arg0
    }

    public fun seconds(arg0: u64) : u64 {
        1 * arg0
    }

    public fun seconds_in_milliseconds(arg0: u64) : u64 {
        1000 * arg0
    }

    public fun weeks(arg0: u64) : u64 {
        604800 * arg0
    }

    public fun weeks_in_milliseconds(arg0: u64) : u64 {
        604800000 * arg0
    }

    // decompiled from Move bytecode v6
}

