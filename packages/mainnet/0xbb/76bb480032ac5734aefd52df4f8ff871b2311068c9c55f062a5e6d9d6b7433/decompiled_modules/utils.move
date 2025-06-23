module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::utils {
    public(friend) fun clear_bit(arg0: u256, arg1: u8) : u256 {
        let v0 = 1 << arg1;
        (arg0 | v0) ^ v0
    }

    public(friend) fun get_bit(arg0: u256, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public(friend) fun get_type_name_string<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    public(friend) fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        if (18446744073709551615 - arg0 < arg1) {
            return 18446744073709551615
        };
        arg0 + arg1
    }

    public(friend) fun set_bit(arg0: u256, arg1: u8) : u256 {
        arg0 | 1 << arg1
    }

    // decompiled from Move bytecode v6
}

