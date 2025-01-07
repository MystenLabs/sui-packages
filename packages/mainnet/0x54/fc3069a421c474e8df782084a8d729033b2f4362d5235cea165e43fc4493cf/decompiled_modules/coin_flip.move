module 0x54fc3069a421c474e8df782084a8d729033b2f4362d5235cea165e43fc4493cf::coin_flip {
    struct CoinFlipResult has copy, drop {
        result: u8,
    }

    fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    entry fun flip(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = arithmetic_is_less_than(0x2::random::generate_u8_in_range(&mut v0, 1, 100), 50, 100);
        let v2 = v1 * 1 + (1 - v1) * 2;
        let v3 = CoinFlipResult{result: v2};
        0x2::event::emit<CoinFlipResult>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

