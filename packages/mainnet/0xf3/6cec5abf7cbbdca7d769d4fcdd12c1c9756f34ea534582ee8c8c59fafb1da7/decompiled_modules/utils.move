module 0xf36cec5abf7cbbdca7d769d4fcdd12c1c9756f34ea534582ee8c8c59fafb1da7::utils {
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

    public(friend) fun set_bit(arg0: u256, arg1: u8) : u256 {
        arg0 | 1 << arg1
    }

    // decompiled from Move bytecode v6
}

