module 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::game {
    struct LoseEvent has copy, drop {
        amount: u64,
        user: address,
    }

    public fun end_game(arg0: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg1: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::is_playing(arg0), 0);
        let (v0, v1, v2) = 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::get_info(arg0);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg0, v0, v1, false, v2);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::disburse_bonus(arg1, v2, arg2);
    }

    entry fun next_position(arg0: u8, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg4: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::is_playing(arg3), 0);
        let v0 = if (arg0 > 0) {
            if (arg0 <= 6) {
                if (arg1 >= 0) {
                    arg1 <= 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let (v1, v2) = rand_nums(arg2, arg5);
        if (arg1 != v1 && arg1 != v2) {
            peace_move(arg0, arg1, arg3, arg4, arg5);
            return
        };
        if (arg1 == v1) {
            up_move(arg0, arg1, arg3, arg4, arg5);
            return
        };
        let v3 = LoseEvent{
            amount : 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::get_award(arg3),
            user   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LoseEvent>(v3);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg3, arg0, arg1, false, 0);
    }

    entry fun next_position2(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg5: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::is_playing(arg4), 0);
        let v0 = if (arg0 > 0) {
            if (arg0 <= 6) {
                if (arg1 >= 0) {
                    arg1 <= 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = if (arg2 >= 0) {
            if (arg2 <= 2) {
                if (arg3 >= 0) {
                    if (arg3 <= 2) {
                        arg2 != arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        if (arg1 != arg3 && arg1 != arg2) {
            peace_move(arg0, arg1, arg4, arg5, arg6);
            return
        };
        if (arg1 == arg3) {
            up_move(arg0, arg1, arg4, arg5, arg6);
            return
        };
        let v2 = LoseEvent{
            amount : 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::get_award(arg4),
            user   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<LoseEvent>(v2);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg4, arg0, arg1, false, 0);
    }

    fun peace_move(arg0: u8, arg1: u8, arg2: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg3: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0 == 6;
        let v1 = 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::get_award(arg2);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg2, arg0, arg1, !v0, v1);
        if (v0) {
            0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::disburse_bonus(arg3, v1, arg4);
        };
    }

    fun rand_nums(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : (u8, u8) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 0, 2);
        (v1, (v1 + 0x2::random::generate_u8_in_range(&mut v0, 1, 2)) % 3)
    }

    public fun start_game(arg0: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg1: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::pay_ticket(arg1, arg2);
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg0, 0, 0, true, 0);
    }

    fun up_move(arg0: u8, arg1: u8, arg2: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::BlackSquidJumpingNFT, arg3: &mut 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::Pool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0 == 6;
        let v1 = if (arg0 <= 3) {
            300000000
        } else if (arg0 <= 5) {
            600000000
        } else {
            2000000000
        };
        let v2 = 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::get_award(arg2) + v1;
        0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft::update(arg2, arg0, arg1, !v0, v2);
        if (v0) {
            0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::pool::disburse_bonus(arg3, v2, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

