module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::dice {
    struct DICE has drop {
        dummy_field: bool,
    }

    struct HistoricalRoll has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        bet_type: u8,
        target: u8,
        die: u8,
        won: bool,
        payout: u64,
    }

    public fun bet_type_high() : u8 {
        1
    }

    public fun bet_type_low() : u8 {
        2
    }

    public fun bet_type_number() : u8 {
        3
    }

    fun check_win(arg0: u8, arg1: u8, arg2: u8) : bool {
        arg0 == 1 && arg2 >= 4 || arg0 == 2 && arg2 <= 3 || arg0 == 3 && arg2 == arg1
    }

    public fun game_type_id() : u64 {
        3
    }

    fun init(arg0: DICE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration>(0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::register_game<DICE>(arg0, 3, b"dice", 9950, 5970000000000, arg1));
    }

    fun payout_for(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 3) {
            arg0 * 59700 / 10000
        } else {
            arg0 * 19900 / 10000
        }
    }

    entry fun place_bet<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::registry::GameRegistration, arg2: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::house_lp::HouseLP<T0>, arg3: &0x2::random::Random, arg4: 0x2::coin::Coin<T0>, arg5: u8, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 >= 10000000 && v0 <= 1000000000000, 901);
        assert!(v0 > 0, 902);
        validate_bet(arg5, arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        let (v2, v3) = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::open_round_with_lp<T0>(arg0, arg1, arg2, arg4, v0 * 59700 / 10000, v1, arg7);
        let v4 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::new_generator(arg3, arg7);
        let v5 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(&mut v4, 1, 6);
        let v6 = check_win(arg5, arg6, v5);
        let v7 = if (v6) {
            payout_for(v0, arg5)
        } else {
            0
        };
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::lifecycle::settle_round<T0>(arg0, arg1, v2, v3, v7, arg7);
        let v8 = HistoricalRoll{
            id       : 0x2::object::new(arg7),
            player   : v1,
            bet      : v0,
            bet_type : arg5,
            target   : arg6,
            die      : v5,
            won      : v6,
            payout   : v7,
        };
        0x2::transfer::transfer<HistoricalRoll>(v8, v1);
    }

    public fun roll_bet(arg0: &HistoricalRoll) : u64 {
        arg0.bet
    }

    public fun roll_bet_type(arg0: &HistoricalRoll) : u8 {
        arg0.bet_type
    }

    public fun roll_die(arg0: &HistoricalRoll) : u8 {
        arg0.die
    }

    public fun roll_payout(arg0: &HistoricalRoll) : u64 {
        arg0.payout
    }

    public fun roll_player(arg0: &HistoricalRoll) : address {
        arg0.player
    }

    public fun roll_target(arg0: &HistoricalRoll) : u8 {
        arg0.target
    }

    public fun roll_won(arg0: &HistoricalRoll) : bool {
        arg0.won
    }

    public fun theoretical_rtp_bps() : u64 {
        9950
    }

    fun validate_bet(arg0: u8, arg1: u8) {
        if (arg0 == 1 || arg0 == 2) {
            assert!(arg1 == 0, 904);
        } else {
            assert!(arg0 == 3, 903);
            assert!(arg1 >= 1 && arg1 <= 6, 904);
        };
    }

    // decompiled from Move bytecode v7
}

