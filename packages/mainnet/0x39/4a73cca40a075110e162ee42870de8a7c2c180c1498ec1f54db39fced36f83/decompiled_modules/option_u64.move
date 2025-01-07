module 0x394a73cca40a075110e162ee42870de8a7c2c180c1498ec1f54db39fced36f83::option_u64 {
    struct OptionU64 has copy, drop, store {
        is_none: bool,
        value: u64,
    }

    public fun borrow(arg0: &OptionU64) : u64 {
        assert!(!arg0.is_none, 0);
        arg0.value
    }

    public fun borrow_mut(arg0: &mut OptionU64) : &mut u64 {
        assert!(!arg0.is_none, 0);
        &mut arg0.value
    }

    public fun contains(arg0: &OptionU64, arg1: u64) : bool {
        !arg0.is_none && arg0.value == arg1
    }

    public fun is_none(arg0: &OptionU64) : bool {
        arg0.is_none
    }

    public fun is_some(arg0: &OptionU64) : bool {
        !arg0.is_none
    }

    public fun is_some_and_lte(arg0: &OptionU64, arg1: u64) : bool {
        !arg0.is_none && arg0.value <= arg1
    }

    public fun none() : OptionU64 {
        OptionU64{
            is_none : true,
            value   : 0,
        }
    }

    public fun some(arg0: u64) : OptionU64 {
        OptionU64{
            is_none : false,
            value   : arg0,
        }
    }

    public fun swap_or_fill(arg0: &mut OptionU64, arg1: u64) {
        arg0.is_none = false;
        arg0.value = arg1;
    }

    // decompiled from Move bytecode v6
}

