module 0x107dcf9b0cfbb5d4c0534f3a335f7632f46004bd56b4cc9f1cc1a3556bde68cb::rand_attack {
    public entry fun attack_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(get_rand_num(arg0, 2) == 1, 1001);
    }

    fun get_rand_num(arg0: &0x2::clock::Clock, arg1: u32) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % (arg1 as u64) + 1) as u8)
    }

    // decompiled from Move bytecode v6
}

