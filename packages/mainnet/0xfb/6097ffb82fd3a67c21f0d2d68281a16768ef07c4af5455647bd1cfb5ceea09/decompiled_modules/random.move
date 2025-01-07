module 0xfb6097ffb82fd3a67c21f0d2d68281a16768ef07c4af5455647bd1cfb5ceea09::random {
    public(friend) fun get_lucky_number(arg0: &0x2::random::Random, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u32_in_range(&mut v0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

