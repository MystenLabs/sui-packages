module 0x11dc53b6019107425011a713ba37b4fb6c7cb4f1925c17a213a1c5056040c8ba::random {
    public(friend) fun get_lucky_number(arg0: &0x2::random::Random, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u32_in_range(&mut v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

