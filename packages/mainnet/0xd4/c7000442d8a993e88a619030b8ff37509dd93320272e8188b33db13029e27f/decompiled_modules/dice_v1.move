module 0xd4c7000442d8a993e88a619030b8ff37509dd93320272e8188b33db13029e27f::dice_v1 {
    struct DiceV1 has drop {
        dummy_field: bool,
    }

    struct DiceConfig has key {
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

    struct BatchPlan has copy, drop {
        mode: u8,
        targets: vector<u64>,
        winning_cells: u64,
        lo1: u64,
        hi1: u64,
        lo2: u64,
        hi2: u64,
        num_rolls: u64,
        base_stake: u64,
        stake_cap: u64,
        on_win_reset: bool,
        on_win_bps: u64,
        on_loss_reset: bool,
        on_loss_bps: u64,
        stop_profit: u64,
        stop_loss: u64,
        stop_on_first_win: bool,
    }

    struct BatchOutcome has copy, drop {
        budget: u64,
        rolls: vector<u16>,
        stakes: vector<u64>,
        payouts: vector<u64>,
        rolls_settled: u64,
        total_staked: u64,
        winning_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
    }

    struct DiceBatchSettled has copy, drop {
        player: address,
        asset_type: u8,
        mode: u8,
        targets: vector<u64>,
        winning_cells: u64,
        num_rolls: u64,
        budget: u64,
        rolls: vector<u16>,
        stakes: vector<u64>,
        payouts: vector<u64>,
        rolls_settled: u64,
        total_staked: u64,
        winning_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
        burned_amount: u64,
        reserve_amount: u64,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut DiceConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 9);
        assert_valid_limits(arg1.min_bet, arg1.max_bet);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id : 0x2::object::id<DiceConfig>(arg1),
            admin     : 0x2::tx_context::sender(arg2),
            min_bet   : arg1.min_bet,
            max_bet   : arg1.max_bet,
        };
        0x2::event::emit<LimitUpdatesRenounced>(v0);
    }

    fun assert_valid_limits(arg0: u64, arg1: u64) {
        assert!(arg0 >= 10000000, 10);
        assert!(arg0 <= arg1, 10);
        assert!(arg1 <= 1000000000000, 10);
        assert!(arg0 <= (((1000000000000000 as u128) * (1 as u128) / (9900 as u128)) as u64), 10);
    }

    fun batch_windows(arg0: u8, arg1: &vector<u64>) : (u64, u64, u64, u64) {
        if (arg0 == 1) {
            (0, *0x1::vector::borrow<u64>(arg1, 0) + 1, 0, 0)
        } else {
            let (v4, v5, v6, v7) = if (arg0 == 2) {
                (10000 + 1, 0, 0, *0x1::vector::borrow<u64>(arg1, 0) + 1)
            } else {
                let (v8, v9, v10, v11) = if (arg0 == 3) {
                    (*0x1::vector::borrow<u64>(arg1, 0) + 1, *0x1::vector::borrow<u64>(arg1, 1) + 1, 0, 0)
                } else if (arg0 == 4) {
                    (0, *0x1::vector::borrow<u64>(arg1, 0) + 1, *0x1::vector::borrow<u64>(arg1, 1) + 1, 10000 + 1)
                } else {
                    (*0x1::vector::borrow<u64>(arg1, 0) + 1, *0x1::vector::borrow<u64>(arg1, 1) + 1, *0x1::vector::borrow<u64>(arg1, 2) + 1, *0x1::vector::borrow<u64>(arg1, 3) + 1)
                };
                (v9, v10, v11, v8)
            };
            (v7, v4, v5, v6)
        }
    }

    entry fun bet_game_credits_dice_v1(arg0: &DiceConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: u64, arg8: u8, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<DiceV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, arg7, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = 0x2::tx_context::sender(arg19);
        let v2 = DiceV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<DiceV1>(v2, arg1, arg4, v1, arg7, arg6);
        let v3 = draw_rolls(arg5, arg10, arg19);
        let (v4, v5) = settle_game_credits_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v3, arg6, arg19);
        let v6 = v4;
        emit_dice_batch_settled(v1, 2, &v0, &v6, v5, 0);
    }

    entry fun bet_rflh_dice_v1(arg0: &DiceConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg8: u8, arg9: vector<u64>, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<DiceV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg7), arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = draw_rolls(arg5, arg10, arg19);
        let v2 = 0x2::tx_context::sender(arg19);
        let (v3, v4, v5) = settle_rflh_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v1, arg6, arg19);
        let v6 = v3;
        emit_dice_batch_settled(v2, 1, &v0, &v6, v4, v5);
    }

    fun build_batch_plan(arg0: &DiceConfig, arg1: u8, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: bool) : BatchPlan {
        assert!(arg3 >= 1 && arg3 <= 100, 14);
        let v0 = validate_targets_and_count_winning_cells(arg1, &arg2);
        let (v1, v2, v3, v4) = batch_windows(arg1, &arg2);
        let v5 = (((1000000000000000 as u128) * (v0 as u128) / (9900 as u128)) as u64);
        let v6 = if (v5 < arg0.max_bet) {
            v5
        } else {
            arg0.max_bet
        };
        assert!(arg4 >= arg0.min_bet && arg4 <= v6, 2);
        assert!(arg5 >= arg4, 15);
        assert!(arg5 <= checked_mul_u64(arg3, v6), 15);
        assert!(arg7 <= 1000000, 16);
        assert!(arg9 <= 1000000, 16);
        assert!(!arg6 || arg7 == 0, 16);
        assert!(!arg8 || arg9 == 0, 16);
        assert!(arg10 <= 100000000000000000, 17);
        assert!(arg11 <= 100000000000000000, 17);
        BatchPlan{
            mode              : arg1,
            targets           : arg2,
            winning_cells     : v0,
            lo1               : v1,
            hi1               : v2,
            lo2               : v3,
            hi2               : v4,
            num_rolls         : arg3,
            base_stake        : arg4,
            stake_cap         : v6,
            on_win_reset      : arg6,
            on_win_bps        : arg7,
            on_loss_reset     : arg8,
            on_loss_bps       : arg9,
            stop_profit       : arg10,
            stop_loss         : arg11,
            stop_on_first_win : arg12,
        }
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

    public fun config_version(arg0: &DiceConfig) : u64 {
        arg0.config_version
    }

    fun draw_rolls(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<u64>(&mut v1, 0x2::random::generate_u64_in_range(&mut v0, 0, 9999));
            v2 = v2 + 1;
        };
        v1
    }

    fun emit_dice_batch_settled(arg0: address, arg1: u8, arg2: &BatchPlan, arg3: &BatchOutcome, arg4: u64, arg5: u64) {
        let v0 = DiceBatchSettled{
            player         : arg0,
            asset_type     : arg1,
            mode           : arg2.mode,
            targets        : arg2.targets,
            winning_cells  : arg2.winning_cells,
            num_rolls      : arg2.num_rolls,
            budget         : arg3.budget,
            rolls          : arg3.rolls,
            stakes         : arg3.stakes,
            payouts        : arg3.payouts,
            rolls_settled  : arg3.rolls_settled,
            total_staked   : arg3.total_staked,
            winning_stake  : arg3.winning_stake,
            losing_stake   : arg3.losing_stake,
            total_paid     : arg3.total_paid,
            total_profit   : arg3.total_profit,
            refund         : arg3.refund,
            burned_amount  : arg4,
            reserve_amount : arg5,
        };
        0x2::event::emit<DiceBatchSettled>(v0);
    }

    fun grow_stake(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * ((10000 + arg1) as u128) / 10000) as u64);
        let v1 = ((18446744073709551616 + (arg2 as u128) - (v0 as u128) - 1 >> 64) as u64);
        v0 * v1 + arg2 * (1 - v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiceConfig{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_bet                 : 100000000,
            max_bet                 : 100000000000,
            limit_updates_renounced : false,
        };
        0x2::transfer::share_object<DiceConfig>(v0);
    }

    public fun limit_updates_renounced(arg0: &DiceConfig) : bool {
        arg0.limit_updates_renounced
    }

    public fun max_bet(arg0: &DiceConfig) : u64 {
        arg0.max_bet
    }

    public fun max_dice_bet_ceiling() : u64 {
        1000000000000
    }

    public fun max_dice_rolls() : u64 {
        100
    }

    public fun max_dice_win() : u64 {
        1000000000000000
    }

    public fun max_winning_cells() : u64 {
        9800
    }

    public fun min_bet(arg0: &DiceConfig) : u64 {
        arg0.min_bet
    }

    public fun min_dice_bet_floor() : u64 {
        10000000
    }

    public fun min_winning_cells() : u64 {
        1
    }

    public(friend) fun outcome_budget(arg0: &BatchOutcome) : u64 {
        arg0.budget
    }

    public(friend) fun outcome_losing_stake(arg0: &BatchOutcome) : u64 {
        arg0.losing_stake
    }

    public(friend) fun outcome_payouts(arg0: &BatchOutcome) : vector<u64> {
        arg0.payouts
    }

    public(friend) fun outcome_refund(arg0: &BatchOutcome) : u64 {
        arg0.refund
    }

    public(friend) fun outcome_rolls(arg0: &BatchOutcome) : vector<u16> {
        arg0.rolls
    }

    public(friend) fun outcome_rolls_settled(arg0: &BatchOutcome) : u64 {
        arg0.rolls_settled
    }

    public(friend) fun outcome_stakes(arg0: &BatchOutcome) : vector<u64> {
        arg0.stakes
    }

    public(friend) fun outcome_total_paid(arg0: &BatchOutcome) : u64 {
        arg0.total_paid
    }

    public(friend) fun outcome_total_profit(arg0: &BatchOutcome) : u64 {
        arg0.total_profit
    }

    public(friend) fun outcome_total_staked(arg0: &BatchOutcome) : u64 {
        arg0.total_staked
    }

    public(friend) fun outcome_winning_stake(arg0: &BatchOutcome) : u64 {
        arg0.winning_stake
    }

    public fun payout_numerator() : u64 {
        9900
    }

    fun run_batch(arg0: &BatchPlan, arg1: u64, arg2: &vector<u64>) : BatchOutcome {
        assert!(0x1::vector::length<u64>(arg2) == arg0.num_rolls, 18);
        let v0 = if (arg0.on_win_reset) {
            1
        } else {
            0
        };
        let v1 = if (arg0.on_loss_reset) {
            1
        } else {
            0
        };
        let v2 = if (arg0.stop_on_first_win) {
            1
        } else {
            0
        };
        let v3 = 1;
        let v4 = arg1;
        let v5 = arg0.base_stake;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = 0;
        while (v13 < arg0.num_rolls) {
            let v14 = *0x1::vector::borrow<u64>(arg2, v13);
            assert!(v14 <= 9999, 18);
            let v15 = v14 + 1;
            let v16 = v3 * (1 - ((18446744073709551616 + (v5 as u128) - (v4 as u128) - 1 >> 64) as u64));
            let v17 = v16 * v5;
            v4 = v4 - v17;
            let v18 = v6 + v17;
            v6 = v18;
            let v19 = (((18446744073709551616 + (v15 as u128) - (arg0.lo1 as u128) - 1 >> 64) as u64) * ((18446744073709551616 + (arg0.hi1 as u128) - (v15 as u128) - 1 >> 64) as u64) + ((18446744073709551616 + (v15 as u128) - (arg0.lo2 as u128) - 1 >> 64) as u64) * ((18446744073709551616 + (arg0.hi2 as u128) - (v15 as u128) - 1 >> 64) as u64)) * v16;
            let v20 = (((v17 as u128) * (9900 as u128) / (arg0.winning_cells as u128)) as u64) * v19;
            v7 = v7 + v19 * v17;
            let v21 = v8 + v20;
            v8 = v21;
            v9 = v9 + v16;
            v3 = v16 * (1 - ((18446744073709551616 + (arg0.stop_profit as u128) - 0 - 1 >> 64) as u64) * (1 - ((18446744073709551616 + ((v18 + arg0.stop_profit) as u128) - (v21 as u128) - 1 >> 64) as u64))) * (1 - ((18446744073709551616 + (arg0.stop_loss as u128) - 0 - 1 >> 64) as u64) * (1 - ((18446744073709551616 + ((v21 + arg0.stop_loss) as u128) - (v18 as u128) - 1 >> 64) as u64))) * (1 - v2 * v19);
            let v22 = v19 * (v0 * arg0.base_stake + (1 - v0) * grow_stake(v5, arg0.on_win_bps, arg0.stake_cap)) + (v16 - v19) * (v1 * arg0.base_stake + (1 - v1) * grow_stake(v5, arg0.on_loss_bps, arg0.stake_cap));
            let v23 = (1 - v16) * v5;
            v5 = v22 + v23;
            0x1::vector::push_back<u16>(&mut v10, (v14 as u16));
            0x1::vector::push_back<u64>(&mut v11, v17);
            0x1::vector::push_back<u64>(&mut v12, v20);
            v13 = v13 + 1;
        };
        assert!(v8 >= v7, 11);
        assert!(v4 == arg1 - v6, 11);
        BatchOutcome{
            budget        : arg1,
            rolls         : v10,
            stakes        : v11,
            payouts       : v12,
            rolls_settled : v9,
            total_staked  : v6,
            winning_stake : v7,
            losing_stake  : v6 - v7,
            total_paid    : v8,
            total_profit  : v8 - v7,
            refund        : v4,
        }
    }

    fun settle_game_credits_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg4: &BatchPlan, arg5: u64, arg6: &vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<DiceV1>(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = DiceV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<DiceV1>(v1, arg0, arg3, v0, arg5, arg7);
        let v2 = run_batch(arg4, arg5, arg6);
        let v3 = v2.losing_stake;
        let v4 = DiceV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::debit_loss<DiceV1>(v4, arg0, arg3, v0, v3, arg7);
        let v5 = DiceV1{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<DiceV1>(v5, arg0, arg1, arg2, v2.total_profit, arg8), v0);
        (v2, v3)
    }

    fun settle_rflh_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &BatchPlan, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<DiceV1>(arg0);
        let v0 = run_batch(arg4, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5), arg6);
        let v1 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg1);
        let v2 = DiceV1{dummy_field: false};
        let (v3, v4) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve::split_rflh_loss(v0.losing_stake, v1);
        let v5 = DiceV1{dummy_field: false};
        let v6 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<DiceV1>(v5, arg0, arg1, arg2, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v3, arg8));
        assert!(v6 == v3, 11);
        let v7 = DiceV1{dummy_field: false};
        let (v8, v9) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::route_game_reserve_contribution<DiceV1>(v7, arg0, arg3, arg2, v1, 0x2::coin::into_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v4, arg8)), arg7);
        let v10 = DiceV1{dummy_field: false};
        let v11 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<DiceV1>(v10, arg0, arg1, arg2, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v9, arg8));
        assert!(v11 == v4 - v8, 11);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(v0.refund, v0.winning_stake), 11);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<DiceV1>(v2, arg0, arg1, arg2, v0.total_profit, arg8));
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(checked_add_u64(v0.refund, v0.winning_stake), v0.total_profit), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(arg5, 0x2::tx_context::sender(arg8));
        (v0, v6 + v11, v8)
    }

    public fun update_limits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut DiceConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 8);
        assert_valid_limits(arg2, arg3);
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitsUpdated{
            config_id        : 0x2::object::id<DiceConfig>(arg1),
            admin            : 0x2::tx_context::sender(arg4),
            previous_min_bet : arg1.min_bet,
            previous_max_bet : arg1.max_bet,
            new_min_bet      : arg2,
            new_max_bet      : arg3,
            config_version   : arg1.config_version,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    fun validate_targets_and_count_winning_cells(arg0: u8, arg1: &vector<u64>) : u64 {
        assert!(0x1::vector::length<u64>(arg1) == 4, 13);
        let v0 = *0x1::vector::borrow<u64>(arg1, 0);
        let v1 = *0x1::vector::borrow<u64>(arg1, 1);
        let v2 = *0x1::vector::borrow<u64>(arg1, 2);
        let v3 = *0x1::vector::borrow<u64>(arg1, 3);
        let v4 = if (arg0 == 1) {
            assert!(v0 >= 1 && v0 <= 9999, 13);
            let v5 = if (v1 == 0) {
                if (v2 == 0) {
                    v3 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 13);
            v0
        } else if (arg0 == 2) {
            assert!(v0 <= 9999 - 1, 13);
            let v6 = if (v1 == 0) {
                if (v2 == 0) {
                    v3 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v6, 13);
            9999 - v0
        } else if (arg0 == 3) {
            assert!(v1 <= 9999, 13);
            assert!(v0 < v1 && v1 - v0 >= 2, 13);
            assert!(v2 == 0 && v3 == 0, 13);
            v1 - v0 - 1
        } else if (arg0 == 4) {
            assert!(v1 <= 9999 - 1, 13);
            assert!(v0 >= 1 && v0 < v1, 13);
            assert!(v2 == 0 && v3 == 0, 13);
            v0 + 9999 - v1
        } else {
            assert!(arg0 == 5, 12);
            assert!(v3 <= 9999, 13);
            assert!(v0 < v1 && v1 - v0 >= 2, 13);
            assert!(v1 <= v2, 13);
            assert!(v2 < v3 && v3 - v2 >= 2, 13);
            v1 - v0 - 1 + v3 - v2 - 1
        };
        assert!(v4 >= 1 && v4 <= 9800, 13);
        v4
    }

    // decompiled from Move bytecode v7
}

