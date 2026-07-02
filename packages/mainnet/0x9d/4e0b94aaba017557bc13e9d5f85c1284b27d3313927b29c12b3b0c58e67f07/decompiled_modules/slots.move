module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::slots {
    struct SLOTS has drop {
        dummy_field: bool,
    }

    struct HistoricalSpin has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        reel1: u8,
        reel2: u8,
        reel3: u8,
        payout: u64,
        pay_code: u8,
    }

    public fun game_type_id() : u64 {
        5
    }

    fun init(arg0: SLOTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration>(0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::register_game<SLOTS>(arg0, 5, b"slots", 9609, 2000000000000, arg1));
    }

    public fun pay_code_lose() : u8 {
        0
    }

    public fun pay_code_three_of_a_kind(arg0: u8) : u8 {
        arg0 + 2
    }

    public fun pay_code_two_cherry() : u8 {
        1
    }

    fun score_spin(arg0: u64, arg1: u8, arg2: u8, arg3: u8) : (u64, u8) {
        if (arg1 == arg2 && arg2 == arg3) {
            (arg0 * three_of_a_kind_multiplier(arg1), pay_code_three_of_a_kind(arg1))
        } else if (two_cherries(arg1, arg2, arg3)) {
            (arg0 * 1, pay_code_two_cherry())
        } else {
            (0, pay_code_lose())
        }
    }

    entry fun spin<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration, arg2: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::house_lp::HouseLP<T0>, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 >= 10000000 && v0 <= 10000000000, 921);
        let v1 = 0x2::tx_context::sender(arg5);
        let (v2, v3) = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::open_round_with_lp<T0>(arg0, arg1, arg2, arg4, v0 * 200, v1, arg5);
        let v4 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::new_generator(arg3, arg5);
        let v5 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(&mut v4, 0, 7);
        let v6 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(&mut v4, 0, 7);
        let v7 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(&mut v4, 0, 7);
        let (v8, v9) = score_spin(v0, v5, v6, v7);
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::settle_round<T0>(arg0, arg1, v2, v3, v8, arg5);
        let v10 = HistoricalSpin{
            id       : 0x2::object::new(arg5),
            player   : v1,
            bet      : v0,
            reel1    : v5,
            reel2    : v6,
            reel3    : v7,
            payout   : v8,
            pay_code : v9,
        };
        0x2::transfer::transfer<HistoricalSpin>(v10, v1);
    }

    public fun spin_bet(arg0: &HistoricalSpin) : u64 {
        arg0.bet
    }

    public fun spin_pay_code(arg0: &HistoricalSpin) : u8 {
        arg0.pay_code
    }

    public fun spin_payout(arg0: &HistoricalSpin) : u64 {
        arg0.payout
    }

    public fun spin_player(arg0: &HistoricalSpin) : address {
        arg0.player
    }

    public fun spin_reels(arg0: &HistoricalSpin) : (u8, u8, u8) {
        (arg0.reel1, arg0.reel2, arg0.reel3)
    }

    public fun theoretical_rtp_bps() : u64 {
        9609
    }

    fun three_of_a_kind_multiplier(arg0: u8) : u64 {
        if (arg0 == 7) {
            200
        } else if (arg0 == 6) {
            100
        } else if (arg0 == 5) {
            70
        } else if (arg0 == 4) {
            40
        } else if (arg0 == 3) {
            25
        } else if (arg0 == 2) {
            16
        } else if (arg0 == 1) {
            12
        } else if (arg0 == 0) {
            8
        } else {
            0
        }
    }

    fun two_cherries(arg0: u8, arg1: u8, arg2: u8) : bool {
        let v0 = if (arg0 == 0) {
            if (arg1 == 0) {
                arg2 != 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            true
        } else {
            let v2 = if (arg0 == 0) {
                if (arg1 != 0) {
                    arg2 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                true
            } else if (arg0 != 0) {
                if (arg1 == 0) {
                    arg2 == 0
                } else {
                    false
                }
            } else {
                false
            }
        }
    }

    // decompiled from Move bytecode v7
}

