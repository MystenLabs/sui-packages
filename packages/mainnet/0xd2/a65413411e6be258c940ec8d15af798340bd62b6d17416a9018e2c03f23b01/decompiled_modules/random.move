module 0xd2a65413411e6be258c940ec8d15af798340bd62b6d17416a9018e2c03f23b01::random {
    public(friend) fun get_lucky_number(arg0: &0x2::random::Random, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u32_in_range(&mut v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

