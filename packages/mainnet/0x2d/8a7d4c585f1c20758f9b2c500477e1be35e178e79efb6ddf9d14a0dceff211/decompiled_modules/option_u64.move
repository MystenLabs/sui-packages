module 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64 {
    struct OptionU64 has copy, drop, store {
        is_none: bool,
        v: u64,
    }

    public fun borrow(arg0: &OptionU64) : u64 {
        assert!(!arg0.is_none, 0);
        arg0.v
    }

    public fun borrow_mut(arg0: &mut OptionU64) : &mut u64 {
        assert!(!arg0.is_none, 0);
        &mut arg0.v
    }

    public fun contains(arg0: &OptionU64, arg1: u64) : bool {
        !arg0.is_none && arg0.v == arg1
    }

    public fun is_none(arg0: &OptionU64) : bool {
        arg0.is_none
    }

    public fun is_some(arg0: &OptionU64) : bool {
        !arg0.is_none
    }

    public fun is_some_and_lte(arg0: &OptionU64, arg1: u64) : bool {
        !arg0.is_none && arg0.v <= arg1
    }

    public fun none() : OptionU64 {
        OptionU64{
            is_none : true,
            v       : 0,
        }
    }

    public fun some(arg0: u64) : OptionU64 {
        OptionU64{
            is_none : false,
            v       : arg0,
        }
    }

    public fun swap_or_fill(arg0: &mut OptionU64, arg1: u64) {
        arg0.is_none = false;
        arg0.v = arg1;
    }

    // decompiled from Move bytecode v6
}

