module 0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373::rand_attack {
    public entry fun attack_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(get_rand_num(arg0, 2) == 1, 1001);
    }

    fun get_rand_num(arg0: &0x2::clock::Clock, arg1: u32) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % (arg1 as u64) + 1) as u8)
    }

    // decompiled from Move bytecode v6
}

