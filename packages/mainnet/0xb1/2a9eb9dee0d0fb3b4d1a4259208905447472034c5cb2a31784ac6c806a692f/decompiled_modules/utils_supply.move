module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils_supply {
    struct Supply has drop, store {
        max: u64,
        current: u64,
    }

    public fun assert_zero(arg0: &Supply) {
        assert!(arg0.current == 0, 3);
    }

    public fun decrease_maximum(arg0: &mut Supply, arg1: u64) {
        assert!(arg0.max - arg1 > arg0.current, 2);
        arg0.max = arg0.max - arg1;
    }

    public fun decrement(arg0: &mut Supply, arg1: u64) {
        arg0.current = arg0.current - arg1;
    }

    public fun get_current(arg0: &Supply) : u64 {
        arg0.current
    }

    public fun get_max(arg0: &Supply) : u64 {
        arg0.max
    }

    public fun get_remaining(arg0: &Supply) : u64 {
        arg0.max - arg0.current
    }

    public fun increase_maximum(arg0: &mut Supply, arg1: u64) {
        arg0.max = arg0.max + arg1;
    }

    public fun increment(arg0: &mut Supply, arg1: u64) {
        assert!(arg0.current + arg1 <= arg0.max, 1);
        arg0.current = arg0.current + arg1;
    }

    public fun merge(arg0: &mut Supply, arg1: Supply) {
        let Supply {
            max     : v0,
            current : v1,
        } = arg1;
        increase_maximum(arg0, v0);
        increment(arg0, v1);
    }

    public fun new(arg0: u64) : Supply {
        Supply{
            max     : arg0,
            current : 0,
        }
    }

    public fun split(arg0: &mut Supply, arg1: u64) : Supply {
        decrease_maximum(arg0, arg1);
        new(arg1)
    }

    // decompiled from Move bytecode v6
}

