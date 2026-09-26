module 0x7e17a8d6c068ccdfb7e8a0c222da363d9c9dcf9fcda97befa3352a7b54ff2f29::blast_fun_timelock {
    struct Timelocked<T0: copy + drop + store> has copy, drop, store {
        before: T0,
        after: T0,
        at_ms: u64,
        delay_ms: u64,
    }

    public fun delay_ms<T0: copy + drop + store>(arg0: &Timelocked<T0>) : u64 {
        arg0.delay_ms
    }

    public fun new<T0: copy + drop + store>(arg0: T0, arg1: u64) : Timelocked<T0> {
        assert!(arg1 > 0 && arg1 <= 315360000000, 13835058239965822978);
        Timelocked<T0>{
            before   : arg0,
            after    : arg0,
            at_ms    : 0,
            delay_ms : arg1,
        }
    }

    public fun schedule<T0: copy + drop + store>(arg0: &mut Timelocked<T0>, arg1: T0, arg2: &0x2::clock::Clock) {
        arg0.before = value<T0>(arg0, arg2);
        arg0.after = arg1;
        arg0.at_ms = 0x2::clock::timestamp_ms(arg2) + arg0.delay_ms;
    }

    public fun scheduled<T0: copy + drop + store>(arg0: &Timelocked<T0>) : T0 {
        arg0.after
    }

    public fun scheduled_at_ms<T0: copy + drop + store>(arg0: &Timelocked<T0>) : u64 {
        arg0.at_ms
    }

    public fun value<T0: copy + drop + store>(arg0: &Timelocked<T0>, arg1: &0x2::clock::Clock) : T0 {
        if (0x2::clock::timestamp_ms(arg1) >= arg0.at_ms) {
            arg0.after
        } else {
            arg0.before
        }
    }

    // decompiled from Move bytecode v7
}

