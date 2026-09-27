module 0x360cd8d3c178d6f8876647de2e5843339f3af825368b4c832a2fd3ce3e52b34b::roulette_v1 {
    struct RouletteV1 has drop {
        dummy_field: bool,
    }

    struct RouletteConfig has key {
        id: 0x2::object::UID,
        config_version: u64,
        min_bet: u64,
        max_bet: u64,
        limit_updates_renounced: bool,
    }

    struct LimitUpdatesRenounced has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        min_bet: u64,
        max_bet: u64,
    }

    struct LimitsUpdated has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        previous_min_bet: u64,
        previous_max_bet: u64,
        new_min_bet: u64,
        new_max_bet: u64,
        config_version: u64,
    }

    struct BetLeg has copy, drop, store {
        bet_type: u8,
        selection_a: u8,
        selection_b: u8,
        stake_amount: u64,
    }

    struct Evaluation has copy, drop, store {
        total_stake: u64,
        winning_stake: u64,
        losing_stake: u64,
        total_profit: u64,
    }

    struct RouletteBetSettled has copy, drop {
        player: address,
        asset_type: u8,
        spin_result: u8,
        total_stake: u64,
        winning_stake: u64,
        losing_stake: u64,
        total_profit: u64,
        burned_amount: u64,
        reserve_amount: u64,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut RouletteConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 9);
        assert_valid_limits(arg1.min_bet, arg1.max_bet);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id : 0x2::object::id<RouletteConfig>(arg1),
            admin     : 0x2::tx_context::sender(arg2),
            min_bet   : arg1.min_bet,
            max_bet   : arg1.max_bet,
        };
        0x2::event::emit<LimitUpdatesRenounced>(v0);
    }

    fun are_split_adjacent(arg0: u8, arg1: u8) : bool {
        let v0 = if (arg0 == arg1) {
            true
        } else if (!is_valid_number(arg0)) {
            true
        } else {
            !is_valid_number(arg1)
        };
        if (v0) {
            false
        } else if (arg0 == 0) {
            arg1 >= 1 && arg1 <= 3
        } else if (arg1 == 0) {
            arg0 >= 1 && arg0 <= 3
        } else {
            let v2 = roulette_grid_col(arg0);
            let v3 = roulette_grid_col(arg1);
            let v4 = roulette_grid_row(arg0);
            let v5 = roulette_grid_row(arg1);
            let v6 = if (v2 > v3) {
                v2 - v3
            } else {
                v3 - v2
            };
            let v7 = if (v4 > v5) {
                v4 - v5
            } else {
                v5 - v4
            };
            v6 + v7 == 1
        }
    }

    fun assert_valid_limits(arg0: u64, arg1: u64) {
        assert!(arg0 >= 10000000, 10);
        assert!(arg0 <= arg1, 10);
        assert!(arg1 <= 25000000000000, 10);
    }

    public(friend) fun bet_covers_number(arg0: &BetLeg, arg1: u8) : bool {
        covers_flag(arg0, arg1) == 1
    }

    entry fun bet_game_credits_roulette_v1(arg0: &RouletteConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RouletteV1>(arg1);
        let v0 = build_public_bet_legs(arg7, arg8, arg9, arg10);
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = RouletteV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<RouletteV1>(v2, arg1, arg4, v1, validate_public_roulette_legs(arg0, &v0), arg6);
        let v3 = spin_result_from_random(arg5, arg11);
        let (v4, v5) = settle_game_credits_legs(arg0, arg1, arg2, arg3, arg4, v0, v3, arg6, arg11);
        let v6 = v4;
        emit_roulette_bet_settled(v1, 2, v3, &v6, v5, 0);
    }

    entry fun bet_rflh_roulette_v1(arg0: &RouletteConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RouletteV1>(arg1);
        let v0 = build_public_bet_legs(arg8, arg9, arg10, arg11);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg7) == validate_public_roulette_legs(arg0, &v0), 2);
        let v1 = spin_result_from_random(arg5, arg12);
        let v2 = 0x2::tx_context::sender(arg12);
        let (v3, v4, v5) = settle_rflh_legs(arg0, arg1, arg2, arg3, arg4, v0, arg7, v1, arg6, arg12);
        let v6 = v3;
        emit_roulette_bet_settled(v2, 1, v1, &v6, v4, v5);
    }

    public fun bet_type_black() : u8 {
        3
    }

    public fun bet_type_column() : u8 {
        9
    }

    public fun bet_type_corner() : u8 {
        12
    }

    public fun bet_type_dozen() : u8 {
        8
    }

    public fun bet_type_even() : u8 {
        4
    }

    public fun bet_type_first_four() : u8 {
        15
    }

    public fun bet_type_high() : u8 {
        7
    }

    public fun bet_type_low() : u8 {
        6
    }

    public fun bet_type_odd() : u8 {
        5
    }

    public fun bet_type_red() : u8 {
        2
    }

    public fun bet_type_six_line() : u8 {
        13
    }

    public fun bet_type_split() : u8 {
        10
    }

    public fun bet_type_straight_up() : u8 {
        1
    }

    public fun bet_type_street() : u8 {
        11
    }

    public fun bet_type_trio() : u8 {
        14
    }

    fun build_public_bet_legs(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u64>) : vector<BetLeg> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = if (v0 == 0x1::vector::length<u8>(&arg1)) {
            if (v0 == 0x1::vector::length<u8>(&arg2)) {
                v0 == 0x1::vector::length<u64>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        assert!(v0 > 0 && v0 <= 32, 7);
        let v2 = 0x1::vector::empty<BetLeg>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = BetLeg{
                bet_type     : *0x1::vector::borrow<u8>(&arg0, v3),
                selection_a  : *0x1::vector::borrow<u8>(&arg1, v3),
                selection_b  : *0x1::vector::borrow<u8>(&arg2, v3),
                stake_amount : *0x1::vector::borrow<u64>(&arg3, v3),
            };
            0x1::vector::push_back<BetLeg>(&mut v2, v4);
            v3 = v3 + 1;
        };
        v2
    }

    fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 6);
        (v0 as u64)
    }

    fun checked_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 6);
        (v0 as u64)
    }

    fun column_mask(arg0: u8) : u64 {
        let v0 = 0;
        while (arg0 <= 36) {
            v0 = v0 | 1 << arg0;
            arg0 = arg0 + 3;
        };
        v0
    }

    public fun config_version(arg0: &RouletteConfig) : u64 {
        arg0.config_version
    }

    public(friend) fun covered_mask(arg0: &BetLeg) : u64 {
        validate_bet_leg(arg0);
        let v0 = arg0.bet_type;
        let v1 = arg0.selection_a;
        if (v0 == 1) {
            1 << v1
        } else if (v0 == 2) {
            91447186090
        } else if (v0 == 3) {
            45991767380
        } else if (v0 == 4) {
            91625968980
        } else if (v0 == 5) {
            45812984490
        } else if (v0 == 6) {
            524286
        } else if (v0 == 7) {
            137438429184
        } else if (v0 == 8) {
            4095 << dozen_start(v1)
        } else if (v0 == 9) {
            column_mask(v1)
        } else if (v0 == 10) {
            1 << v1 | 1 << arg0.selection_b
        } else if (v0 == 11) {
            7 << v1
        } else if (v0 == 12) {
            1 << v1 | 1 << v1 + 1 | 1 << v1 + 3 | 1 << v1 + 4
        } else if (v0 == 13) {
            63 << v1
        } else if (v0 == 14) {
            if (v1 == 1) {
                7
            } else {
                13
            }
        } else if (v0 == 15) {
            15
        } else {
            0
        }
    }

    public(friend) fun covers_flag(arg0: &BetLeg, arg1: u8) : u64 {
        validate_spin_result(arg1);
        covered_mask(arg0) >> arg1 & 1
    }

    fun dozen_start(arg0: u8) : u8 {
        (arg0 - 1) * 12 + 1
    }

    fun emit_roulette_bet_settled(arg0: address, arg1: u8, arg2: u8, arg3: &Evaluation, arg4: u64, arg5: u64) {
        0x2::event::emit<RouletteBetSettled>(new_roulette_bet_settled_event(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public(friend) fun evaluate_legs(arg0: &vector<BetLeg>, arg1: u8) : Evaluation {
        validate_spin_result(arg1);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<BetLeg>(arg0)) {
            let v5 = 0x1::vector::borrow<BetLeg>(arg0, v4);
            validate_bet_leg(v5);
            let v6 = v5.stake_amount;
            let v7 = covers_flag(v5, arg1);
            v0 = checked_add_u64(v0, v6);
            v1 = checked_add_u64(v1, v6 * v7);
            v2 = checked_add_u64(v2, v6 * (1 - v7));
            v3 = checked_add_u64(v3, profit_for_leg(v5) * v7);
            v4 = v4 + 1;
        };
        Evaluation{
            total_stake   : v0,
            winning_stake : v1,
            losing_stake  : v2,
            total_profit  : v3,
        }
    }

    public(friend) fun evaluation_losing_stake(arg0: &Evaluation) : u64 {
        arg0.losing_stake
    }

    public(friend) fun evaluation_total_profit(arg0: &Evaluation) : u64 {
        arg0.total_profit
    }

    public(friend) fun evaluation_total_stake(arg0: &Evaluation) : u64 {
        arg0.total_stake
    }

    public(friend) fun evaluation_winning_stake(arg0: &Evaluation) : u64 {
        arg0.winning_stake
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouletteConfig{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_bet                 : 1000000000,
            max_bet                 : 2000000000000,
            limit_updates_renounced : false,
        };
        0x2::transfer::share_object<RouletteConfig>(v0);
    }

    fun is_valid_corner_start(arg0: u8) : bool {
        if (arg0 >= 1) {
            if (arg0 <= 32) {
                arg0 % 3 != 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_valid_number(arg0: u8) : bool {
        arg0 <= 36
    }

    fun is_valid_selection(arg0: &BetLeg) : bool {
        let v0 = arg0.bet_type;
        let v1 = arg0.selection_a;
        if (v0 == 1) {
            v1 <= 36 && arg0.selection_b == 0
        } else {
            let v3 = if (v0 == 2) {
                true
            } else if (v0 == 3) {
                true
            } else if (v0 == 4) {
                true
            } else if (v0 == 5) {
                true
            } else if (v0 == 6) {
                true
            } else if (v0 == 7) {
                true
            } else {
                v0 == 15
            };
            if (v3) {
                v1 == 0 && arg0.selection_b == 0
            } else if (v0 == 8 || v0 == 9) {
                if (v1 >= 1) {
                    if (v1 <= 3) {
                        arg0.selection_b == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                v0 == 10 && is_valid_split(v1, arg0.selection_b) || v0 == 11 && is_valid_street_start(v1) && arg0.selection_b == 0 || v0 == 12 && is_valid_corner_start(v1) && arg0.selection_b == 0 || v0 == 13 && is_valid_six_line_start(v1) && arg0.selection_b == 0 || v0 == 14 && (v1 == 1 || v1 == 2) && arg0.selection_b == 0
            }
        }
    }

    fun is_valid_six_line_start(arg0: u8) : bool {
        if (arg0 >= 1) {
            if (arg0 <= 31) {
                arg0 % 3 == 1
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_valid_split(arg0: u8, arg1: u8) : bool {
        are_split_adjacent(arg0, arg1)
    }

    fun is_valid_street_start(arg0: u8) : bool {
        if (arg0 >= 1) {
            if (arg0 <= 34) {
                arg0 % 3 == 1
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun limit_updates_renounced(arg0: &RouletteConfig) : bool {
        arg0.limit_updates_renounced
    }

    public fun max_bet(arg0: &RouletteConfig) : u64 {
        arg0.max_bet
    }

    public fun max_roulette_legs() : u64 {
        32
    }

    public fun min_bet(arg0: &RouletteConfig) : u64 {
        arg0.min_bet
    }

    public fun new_bet_leg(arg0: u8, arg1: u8, arg2: u8, arg3: u64) : BetLeg {
        BetLeg{
            bet_type     : arg0,
            selection_a  : arg1,
            selection_b  : arg2,
            stake_amount : arg3,
        }
    }

    fun new_roulette_bet_settled_event(arg0: address, arg1: u8, arg2: u8, arg3: &Evaluation, arg4: u64, arg5: u64) : RouletteBetSettled {
        RouletteBetSettled{
            player         : arg0,
            asset_type     : arg1,
            spin_result    : arg2,
            total_stake    : arg3.total_stake,
            winning_stake  : arg3.winning_stake,
            losing_stake   : arg3.losing_stake,
            total_profit   : arg3.total_profit,
            burned_amount  : arg4,
            reserve_amount : arg5,
        }
    }

    public(friend) fun payout_multiplier(arg0: &BetLeg) : u64 {
        validate_bet_leg(arg0);
        let v0 = arg0.bet_type;
        if (v0 == 1) {
            35
        } else if (v0 == 10) {
            17
        } else if (v0 == 11 || v0 == 14) {
            11
        } else if (v0 == 12 || v0 == 15) {
            8
        } else if (v0 == 13) {
            5
        } else if (v0 == 8 || v0 == 9) {
            2
        } else {
            1
        }
    }

    public(friend) fun profit_for_leg(arg0: &BetLeg) : u64 {
        checked_mul_u64(arg0.stake_amount, payout_multiplier(arg0))
    }

    fun roulette_grid_col(arg0: u8) : u8 {
        (arg0 - 1) / 3
    }

    fun roulette_grid_row(arg0: u8) : u8 {
        (arg0 - 1) % 3
    }

    public(friend) fun settle_game_credits_legs(arg0: &RouletteConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: vector<BetLeg>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (Evaluation, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RouletteV1>(arg1);
        let v0 = evaluate_legs(&arg5, arg6);
        let v1 = v0.total_stake;
        assert!(v1 >= arg0.min_bet && v1 <= arg0.max_bet, 2);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = RouletteV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<RouletteV1>(v3, arg1, arg4, v2, v1, arg7);
        let v4 = v0.losing_stake;
        let v5 = RouletteV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::debit_loss<RouletteV1>(v5, arg1, arg4, v2, v4, arg7);
        let v6 = RouletteV1{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<RouletteV1>(v6, arg1, arg2, arg3, v0.total_profit, arg8), v2);
        (v0, v4)
    }

    public(friend) fun settle_rflh_legs(arg0: &RouletteConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: vector<BetLeg>, arg6: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (Evaluation, u64, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<RouletteV1>(arg1);
        let v0 = evaluate_legs(&arg5, arg7);
        let v1 = v0.total_stake;
        assert!(v1 >= arg0.min_bet && v1 <= arg0.max_bet, 2);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg6) == v1, 2);
        let v2 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg2);
        let v3 = RouletteV1{dummy_field: false};
        let (v4, v5) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve::split_rflh_loss(v0.losing_stake, v2);
        let v6 = RouletteV1{dummy_field: false};
        let v7 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<RouletteV1>(v6, arg1, arg2, arg3, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg6, v4, arg9));
        assert!(v7 == v4, 3);
        let v8 = RouletteV1{dummy_field: false};
        let (v9, v10) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::route_game_reserve_contribution<RouletteV1>(v8, arg1, arg4, arg3, v2, 0x2::coin::into_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg6, v5, arg9)), arg8);
        let v11 = RouletteV1{dummy_field: false};
        let v12 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<RouletteV1>(v11, arg1, arg2, arg3, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v10, arg9));
        assert!(v12 == v5 - v9, 4);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg6) == v0.winning_stake, 11);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg6, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<RouletteV1>(v3, arg1, arg2, arg3, v0.total_profit, arg9));
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg6) == checked_add_u64(v0.winning_stake, v0.total_profit), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(arg6, 0x2::tx_context::sender(arg9));
        (v0, v7 + v12, v9)
    }

    fun spin_result_from_random(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        (0x2::random::generate_u64_in_range(&mut v0, 0, 36) as u8)
    }

    public(friend) fun total_stake(arg0: &vector<BetLeg>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<BetLeg>(arg0)) {
            let v2 = 0x1::vector::borrow<BetLeg>(arg0, v1);
            validate_bet_leg(v2);
            v0 = checked_add_u64(v0, v2.stake_amount);
            v1 = v1 + 1;
        };
        v0
    }

    public fun trio_0_1_2() : u8 {
        1
    }

    public fun trio_0_2_3() : u8 {
        2
    }

    public fun update_limits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut RouletteConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 8);
        assert_valid_limits(arg2, arg3);
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitsUpdated{
            config_id        : 0x2::object::id<RouletteConfig>(arg1),
            admin            : 0x2::tx_context::sender(arg4),
            previous_min_bet : arg1.min_bet,
            previous_max_bet : arg1.max_bet,
            new_min_bet      : arg2,
            new_max_bet      : arg3,
            config_version   : arg1.config_version,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public(friend) fun validate_bet_leg(arg0: &BetLeg) {
        assert!(arg0.stake_amount > 0, 2);
        assert!(is_valid_selection(arg0), 5);
    }

    fun validate_public_roulette_legs(arg0: &RouletteConfig, arg1: &vector<BetLeg>) : u64 {
        let v0 = 0x1::vector::length<BetLeg>(arg1);
        assert!(v0 > 0 && v0 <= 32, 7);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<BetLeg>(arg1, v2);
            validate_bet_leg(v3);
            assert!(v3.stake_amount >= arg0.min_bet, 2);
            v1 = checked_add_u64(v1, v3.stake_amount);
            v2 = v2 + 1;
        };
        assert!(v1 <= arg0.max_bet, 2);
        v1
    }

    public(friend) fun validate_spin_result(arg0: u8) {
        assert!(arg0 <= 36, 4);
    }

    // decompiled from Move bytecode v7
}

