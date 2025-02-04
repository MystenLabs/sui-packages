module 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u128 {
    struct OptionU128 has copy, drop, store {
        is_none: bool,
        v: u128,
    }

    public fun borrow(arg0: &OptionU128) : u128 {
        assert!(!arg0.is_none, 0);
        arg0.v
    }

    public fun borrow_mut(arg0: &mut OptionU128) : &mut u128 {
        assert!(!arg0.is_none, 0);
        &mut arg0.v
    }

    public fun contains(arg0: &OptionU128, arg1: u128) : bool {
        if (arg0.is_none) {
            return false
        };
        arg0.v == arg1
    }

    public fun is_none(arg0: &OptionU128) : bool {
        arg0.is_none
    }

    public fun is_some(arg0: &OptionU128) : bool {
        !arg0.is_none
    }

    public fun is_some_and_eq(arg0: &OptionU128, arg1: u128) : bool {
        !arg0.is_none && arg0.v == arg1
    }

    public fun is_some_and_lte(arg0: &OptionU128, arg1: u128) : bool {
        !arg0.is_none && arg0.v <= arg1
    }

    public fun none() : OptionU128 {
        OptionU128{
            is_none : true,
            v       : 0,
        }
    }

    public fun some(arg0: u128) : OptionU128 {
        OptionU128{
            is_none : false,
            v       : arg0,
        }
    }

    public fun swap_or_fill(arg0: &mut OptionU128, arg1: u128) {
        arg0.is_none = false;
        arg0.v = arg1;
    }

    // decompiled from Move bytecode v6
}

