module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::roulette {
    struct ROULETTE has drop {
        dummy_field: bool,
    }

    struct HistoricalSpin has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        bet_type: u8,
        target: u8,
        slot: u8,
        won: bool,
        payout: u64,
    }

    public fun bet_type_black() : u8 {
        3
    }

    public fun bet_type_high() : u8 {
        4
    }

    public fun bet_type_low() : u8 {
        5
    }

    public fun bet_type_red() : u8 {
        2
    }

    public fun bet_type_straight() : u8 {
        1
    }

    fun check_win(arg0: u8, arg1: u8, arg2: u8) : bool {
        arg0 == 1 && arg2 == arg1 || arg0 == 2 && is_red(arg2) || arg0 == 3 && is_black(arg2) || arg0 == 4 && arg2 >= 19 && arg2 <= 36 || arg0 == 5 && arg2 >= 1 && arg2 <= 18
    }

    public fun game_type_id() : u64 {
        4
    }

    fun init(arg0: ROULETTE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration>(0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::register_game<ROULETTE>(arg0, 4, b"roulette", 9730, 3600000000000, arg1));
    }

    public fun is_black(arg0: u8) : bool {
        arg0 != 0 && !is_red(arg0)
    }

    public fun is_red(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 14) {
            true
        } else if (arg0 == 16) {
            true
        } else if (arg0 == 18) {
            true
        } else if (arg0 == 19) {
            true
        } else if (arg0 == 21) {
            true
        } else if (arg0 == 23) {
            true
        } else if (arg0 == 25) {
            true
        } else if (arg0 == 27) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 32) {
            true
        } else if (arg0 == 34) {
            true
        } else {
            arg0 == 36
        }
    }

    fun payout_for(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0 * 360000 / 10000
        } else {
            arg0 * 20000 / 10000
        }
    }

    entry fun place_bet<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration, arg2: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::house_lp::HouseLP<T0>, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<T0>, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 >= 10000000 && v0 <= 100000000000, 911);
        validate_bet(arg5, arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let (v2, v3) = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::open_round_with_lp<T0>(arg0, arg1, arg2, arg4, v0 * 360000 / 10000, v1, arg7);
        let v4 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::new_generator(arg3, arg7);
        let v5 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(&mut v4, 0, 36);
        let v6 = check_win(arg5, arg6, v5);
        let v7 = if (v6) {
            payout_for(v0, arg5)
        } else {
            0
        };
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::settle_round<T0>(arg0, arg1, v2, v3, v7, arg7);
        let v8 = HistoricalSpin{
            id       : 0x2::object::new(arg7),
            player   : v1,
            bet      : v0,
            bet_type : arg5,
            target   : arg6,
            slot     : v5,
            won      : v6,
            payout   : v7,
        };
        0x2::transfer::transfer<HistoricalSpin>(v8, v1);
    }

    public fun spin_bet(arg0: &HistoricalSpin) : u64 {
        arg0.bet
    }

    public fun spin_bet_type(arg0: &HistoricalSpin) : u8 {
        arg0.bet_type
    }

    public fun spin_payout(arg0: &HistoricalSpin) : u64 {
        arg0.payout
    }

    public fun spin_player(arg0: &HistoricalSpin) : address {
        arg0.player
    }

    public fun spin_slot(arg0: &HistoricalSpin) : u8 {
        arg0.slot
    }

    public fun spin_target(arg0: &HistoricalSpin) : u8 {
        arg0.target
    }

    public fun spin_won(arg0: &HistoricalSpin) : bool {
        arg0.won
    }

    public fun theoretical_rtp_bps() : u64 {
        9730
    }

    fun validate_bet(arg0: u8, arg1: u8) {
        if (arg0 == 1) {
            assert!(arg1 <= 36, 913);
        } else {
            let v0 = if (arg0 == 2) {
                true
            } else if (arg0 == 3) {
                true
            } else if (arg0 == 4) {
                true
            } else {
                arg0 == 5
            };
            assert!(v0, 912);
            assert!(arg1 == 0, 913);
        };
    }

    // decompiled from Move bytecode v7
}

