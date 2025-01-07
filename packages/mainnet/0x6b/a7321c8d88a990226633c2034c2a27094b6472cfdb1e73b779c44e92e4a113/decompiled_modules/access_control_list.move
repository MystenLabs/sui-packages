module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::access_control_list {
    public fun add_role(arg0: &mut u16, arg1: u8) {
        assert!(arg1 < 16, 0);
        *arg0 = *arg0 | 1 << arg1;
    }

    public fun and_merge(arg0: &mut u16, arg1: &u16) {
        *arg0 = *arg0 & *arg1;
    }

    public fun has_role(arg0: &u16, arg1: u8) : bool {
        if (arg1 >= 16) {
            return false
        };
        *arg0 & 1 << arg1 > 0
    }

    public fun or_merge(arg0: &mut u16, arg1: &u16) {
        *arg0 = *arg0 | *arg1;
    }

    public fun remove_role(arg0: &mut u16, arg1: u8) {
        assert!(arg1 < 16, 0);
        *arg0 = *arg0 - (1 << arg1);
    }

    // decompiled from Move bytecode v6
}

