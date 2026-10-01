module 0x5c3eb5acb972b9b414839191690e64f52e613575254d17b280f6dbcdc6a40196::keno_v1 {
    struct KenoV1 has drop {
        dummy_field: bool,
    }

    struct KenoConfig has key {
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
        picks_mask: u64,
        risk: u8,
        num_picks: u64,
        max_multiplier_h: u64,
        num_rounds: u64,
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
        draws: vector<u8>,
        hits: vector<u8>,
        stakes: vector<u64>,
        payouts: vector<u64>,
        rounds_settled: u64,
        total_staked: u64,
        returned_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
    }

    struct KenoBatchSettled has copy, drop {
        player: address,
        asset_type: u8,
        risk: u8,
        picks_mask: u64,
        num_picks: u64,
        num_rounds: u64,
        budget: u64,
        draws: vector<u8>,
        hits: vector<u8>,
        stakes: vector<u64>,
        payouts: vector<u64>,
        rounds_settled: u64,
        total_staked: u64,
        returned_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
        burned_amount: u64,
        reserve_amount: u64,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut KenoConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 9);
        assert_valid_limits(arg1.min_bet, arg1.max_bet);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id : 0x2::object::id<KenoConfig>(arg1),
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
    }

    entry fun bet_game_credits_keno_v1(arg0: &KenoConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<KenoV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, arg7, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = 0x2::tx_context::sender(arg19);
        let v2 = KenoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<KenoV1>(v2, arg1, arg4, v1, arg7, arg6);
        let v3 = draw_numbers(arg5, arg10, arg19);
        let (v4, v5) = settle_game_credits_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v3, arg6, arg19);
        let v6 = v4;
        emit_keno_batch_settled(v1, 2, &v0, &v6, v5, 0);
    }

    entry fun bet_rflh_keno_v1(arg0: &KenoConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<KenoV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg7), arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v1 = draw_numbers(arg5, arg10, arg19);
        let v2 = 0x2::tx_context::sender(arg19);
        let (v3, v4, v5) = settle_rflh_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v1, arg6, arg19);
        let v6 = v3;
        emit_keno_batch_settled(v2, 1, &v0, &v6, v4, v5);
    }

    public fun board_size() : u64 {
        40
    }

    fun build_batch_plan(arg0: &KenoConfig, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: bool) : BatchPlan {
        assert!(arg3 >= 1 && arg3 <= 100, 14);
        assert!(arg2 <= 3, 12);
        assert!(arg1 != 0, 13);
        assert!(arg1 < 1099511627776, 13);
        let v0 = popcount_board(arg1);
        assert!(v0 <= 10, 13);
        let v1 = vector[0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 190, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 310, 1040, 0, 0, 0, 0, 0, 0, 0, 0, 80, 180, 500, 2250, 0, 0, 0, 0, 0, 0, 0, 25, 140, 410, 1650, 3600, 0, 0, 0, 0, 0, 0, 0, 100, 368, 700, 1650, 4000, 0, 0, 0, 0, 0, 0, 47, 300, 450, 1400, 3100, 6000, 0, 0, 0, 0, 0, 0, 220, 400, 1300, 2200, 5500, 7000, 0, 0, 0, 0, 0, 155, 300, 800, 1500, 4400, 6000, 8500, 0, 0, 0, 0, 140, 225, 450, 800, 1700, 5000, 8000, 10000, 70, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 380, 0, 0, 0, 0, 0, 0, 0, 0, 0, 110, 138, 2600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220, 790, 9000, 0, 0, 0, 0, 0, 0, 0, 0, 150, 420, 1300, 30000, 0, 0, 0, 0, 0, 0, 0, 110, 200, 620, 10000, 70000, 0, 0, 0, 0, 0, 0, 110, 160, 350, 1500, 22500, 70000, 0, 0, 0, 0, 0, 110, 150, 200, 550, 3900, 10000, 80000, 0, 0, 0, 0, 110, 130, 170, 250, 750, 5000, 25000, 100000, 0, 0, 0, 110, 120, 130, 180, 350, 1300, 5000, 25000, 100000, 40, 275, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 180, 510, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 280, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 170, 1000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 140, 400, 1400, 39000, 0, 0, 0, 0, 0, 0, 0, 0, 300, 900, 18000, 71000, 0, 0, 0, 0, 0, 0, 0, 200, 700, 3000, 40000, 80000, 0, 0, 0, 0, 0, 0, 200, 400, 1100, 6700, 40000, 90000, 0, 0, 0, 0, 0, 200, 250, 500, 1500, 10000, 50000, 100000, 0, 0, 0, 0, 160, 200, 400, 700, 2600, 10000, 50000, 100000, 0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 25900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 450, 4800, 45000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1100, 35000, 71000, 0, 0, 0, 0, 0, 0, 0, 0, 700, 9000, 40000, 80000, 0, 0, 0, 0, 0, 0, 0, 500, 2000, 27000, 60000, 90000, 0, 0, 0, 0, 0, 0, 400, 1100, 5600, 50000, 80000, 100000, 0, 0, 0, 0, 0, 350, 800, 1300, 6300, 50000, 80000, 100000];
        let v2 = *0x1::vector::borrow<u64>(&v1, paytable_index(arg2, v0, v0));
        assert!(v2 > 0, 11);
        let v3 = (((1000000000000000 as u128) * (100 as u128) / (v2 as u128)) as u64);
        let v4 = if (v3 < arg0.max_bet) {
            v3
        } else {
            arg0.max_bet
        };
        assert!(arg4 >= arg0.min_bet && arg4 <= v4, 2);
        assert!(arg5 >= arg4, 15);
        assert!(arg5 <= checked_mul_u64(arg3, v4), 15);
        assert!(arg7 <= 1000000, 16);
        assert!(arg9 <= 1000000, 16);
        assert!(!arg6 || arg7 == 0, 16);
        assert!(!arg8 || arg9 == 0, 16);
        assert!(arg10 <= 100000000000000000, 17);
        assert!(arg11 <= 100000000000000000, 17);
        BatchPlan{
            picks_mask        : arg1,
            risk              : arg2,
            num_picks         : v0,
            max_multiplier_h  : v2,
            num_rounds        : arg3,
            base_stake        : arg4,
            stake_cap         : v4,
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

    public fun config_version(arg0: &KenoConfig) : u64 {
        arg0.config_version
    }

    fun draw_numbers(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 40) {
                0x1::vector::push_back<u64>(&mut v3, v4);
                v4 = v4 + 1;
            };
            let v5 = 0;
            while (v5 < 10) {
                0x1::vector::swap<u64>(&mut v3, v5, 0x2::random::generate_u64_in_range(&mut v0, v5, 40 - 1));
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&v3, v5) + 1);
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun draws_per_round() : u64 {
        10
    }

    fun emit_keno_batch_settled(arg0: address, arg1: u8, arg2: &BatchPlan, arg3: &BatchOutcome, arg4: u64, arg5: u64) {
        let v0 = KenoBatchSettled{
            player         : arg0,
            asset_type     : arg1,
            risk           : arg2.risk,
            picks_mask     : arg2.picks_mask,
            num_picks      : arg2.num_picks,
            num_rounds     : arg2.num_rounds,
            budget         : arg3.budget,
            draws          : arg3.draws,
            hits           : arg3.hits,
            stakes         : arg3.stakes,
            payouts        : arg3.payouts,
            rounds_settled : arg3.rounds_settled,
            total_staked   : arg3.total_staked,
            returned_stake : arg3.returned_stake,
            losing_stake   : arg3.losing_stake,
            total_paid     : arg3.total_paid,
            total_profit   : arg3.total_profit,
            refund         : arg3.refund,
            burned_amount  : arg4,
            reserve_amount : arg5,
        };
        0x2::event::emit<KenoBatchSettled>(v0);
    }

    fun grow_stake(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * ((10000 + arg1) as u128) / 10000) as u64);
        let v1 = ((18446744073709551616 + (arg2 as u128) - (v0 as u128) - 1 >> 64) as u64);
        v0 * v1 + arg2 * (1 - v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KenoConfig{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_bet                 : 100000000,
            max_bet                 : 1000000000000,
            limit_updates_renounced : false,
        };
        0x2::transfer::share_object<KenoConfig>(v0);
    }

    public fun limit_updates_renounced(arg0: &KenoConfig) : bool {
        arg0.limit_updates_renounced
    }

    public fun max_bet(arg0: &KenoConfig) : u64 {
        arg0.max_bet
    }

    public fun max_keno_bet_ceiling() : u64 {
        1000000000000
    }

    public fun max_keno_rounds() : u64 {
        100
    }

    public fun max_keno_win() : u64 {
        1000000000000000
    }

    public fun max_picks() : u64 {
        10
    }

    public fun max_risk() : u8 {
        3
    }

    public fun min_bet(arg0: &KenoConfig) : u64 {
        arg0.min_bet
    }

    public fun min_keno_bet_floor() : u64 {
        10000000
    }

    public fun multiplier_denominator() : u64 {
        100
    }

    public(friend) fun outcome_budget(arg0: &BatchOutcome) : u64 {
        arg0.budget
    }

    public(friend) fun outcome_draws(arg0: &BatchOutcome) : vector<u8> {
        arg0.draws
    }

    public(friend) fun outcome_hits(arg0: &BatchOutcome) : vector<u8> {
        arg0.hits
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

    public(friend) fun outcome_returned_stake(arg0: &BatchOutcome) : u64 {
        arg0.returned_stake
    }

    public(friend) fun outcome_rounds_settled(arg0: &BatchOutcome) : u64 {
        arg0.rounds_settled
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

    fun paytable_index(arg0: u8, arg1: u64, arg2: u64) : u64 {
        (arg0 as u64) * 110 + (arg1 - 1) * 11 + arg2
    }

    public fun paytable_multiplier(arg0: u8, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= 3, 12);
        assert!(arg1 >= 1 && arg1 <= 10, 13);
        assert!(arg2 <= arg1, 13);
        let v0 = vector[0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 190, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 310, 1040, 0, 0, 0, 0, 0, 0, 0, 0, 80, 180, 500, 2250, 0, 0, 0, 0, 0, 0, 0, 25, 140, 410, 1650, 3600, 0, 0, 0, 0, 0, 0, 0, 100, 368, 700, 1650, 4000, 0, 0, 0, 0, 0, 0, 47, 300, 450, 1400, 3100, 6000, 0, 0, 0, 0, 0, 0, 220, 400, 1300, 2200, 5500, 7000, 0, 0, 0, 0, 0, 155, 300, 800, 1500, 4400, 6000, 8500, 0, 0, 0, 0, 140, 225, 450, 800, 1700, 5000, 8000, 10000, 70, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 380, 0, 0, 0, 0, 0, 0, 0, 0, 0, 110, 138, 2600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220, 790, 9000, 0, 0, 0, 0, 0, 0, 0, 0, 150, 420, 1300, 30000, 0, 0, 0, 0, 0, 0, 0, 110, 200, 620, 10000, 70000, 0, 0, 0, 0, 0, 0, 110, 160, 350, 1500, 22500, 70000, 0, 0, 0, 0, 0, 110, 150, 200, 550, 3900, 10000, 80000, 0, 0, 0, 0, 110, 130, 170, 250, 750, 5000, 25000, 100000, 0, 0, 0, 110, 120, 130, 180, 350, 1300, 5000, 25000, 100000, 40, 275, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 180, 510, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 280, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 170, 1000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 140, 400, 1400, 39000, 0, 0, 0, 0, 0, 0, 0, 0, 300, 900, 18000, 71000, 0, 0, 0, 0, 0, 0, 0, 200, 700, 3000, 40000, 80000, 0, 0, 0, 0, 0, 0, 200, 400, 1100, 6700, 40000, 90000, 0, 0, 0, 0, 0, 200, 250, 500, 1500, 10000, 50000, 100000, 0, 0, 0, 0, 160, 200, 400, 700, 2600, 10000, 50000, 100000, 0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 25900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 450, 4800, 45000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1100, 35000, 71000, 0, 0, 0, 0, 0, 0, 0, 0, 700, 9000, 40000, 80000, 0, 0, 0, 0, 0, 0, 0, 500, 2000, 27000, 60000, 90000, 0, 0, 0, 0, 0, 0, 400, 1100, 5600, 50000, 80000, 100000, 0, 0, 0, 0, 0, 350, 800, 1300, 6300, 50000, 80000, 100000];
        *0x1::vector::borrow<u64>(&v0, paytable_index(arg0, arg1, arg2))
    }

    fun popcount_board(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 40) {
            v0 = v0 + (arg0 >> v1 & 1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun risk_classic() : u8 {
        0
    }

    public fun risk_high() : u8 {
        3
    }

    public fun risk_low() : u8 {
        1
    }

    public fun risk_medium() : u8 {
        2
    }

    fun run_batch(arg0: &BatchPlan, arg1: u64, arg2: &vector<u64>) : BatchOutcome {
        assert!(0x1::vector::length<u64>(arg2) == arg0.num_rounds * 10, 18);
        let v0 = vector[0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 190, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 310, 1040, 0, 0, 0, 0, 0, 0, 0, 0, 80, 180, 500, 2250, 0, 0, 0, 0, 0, 0, 0, 25, 140, 410, 1650, 3600, 0, 0, 0, 0, 0, 0, 0, 100, 368, 700, 1650, 4000, 0, 0, 0, 0, 0, 0, 47, 300, 450, 1400, 3100, 6000, 0, 0, 0, 0, 0, 0, 220, 400, 1300, 2200, 5500, 7000, 0, 0, 0, 0, 0, 155, 300, 800, 1500, 4400, 6000, 8500, 0, 0, 0, 0, 140, 225, 450, 800, 1700, 5000, 8000, 10000, 70, 185, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 380, 0, 0, 0, 0, 0, 0, 0, 0, 0, 110, 138, 2600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220, 790, 9000, 0, 0, 0, 0, 0, 0, 0, 0, 150, 420, 1300, 30000, 0, 0, 0, 0, 0, 0, 0, 110, 200, 620, 10000, 70000, 0, 0, 0, 0, 0, 0, 110, 160, 350, 1500, 22500, 70000, 0, 0, 0, 0, 0, 110, 150, 200, 550, 3900, 10000, 80000, 0, 0, 0, 0, 110, 130, 170, 250, 750, 5000, 25000, 100000, 0, 0, 0, 110, 120, 130, 180, 350, 1300, 5000, 25000, 100000, 40, 275, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 180, 510, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 280, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 170, 1000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 140, 400, 1400, 39000, 0, 0, 0, 0, 0, 0, 0, 0, 300, 900, 18000, 71000, 0, 0, 0, 0, 0, 0, 0, 200, 700, 3000, 40000, 80000, 0, 0, 0, 0, 0, 0, 200, 400, 1100, 6700, 40000, 90000, 0, 0, 0, 0, 0, 200, 250, 500, 1500, 10000, 50000, 100000, 0, 0, 0, 0, 160, 200, 400, 700, 2600, 10000, 50000, 100000, 0, 396, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 25900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 450, 4800, 45000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1100, 35000, 71000, 0, 0, 0, 0, 0, 0, 0, 0, 700, 9000, 40000, 80000, 0, 0, 0, 0, 0, 0, 0, 500, 2000, 27000, 60000, 90000, 0, 0, 0, 0, 0, 0, 400, 1100, 5600, 50000, 80000, 100000, 0, 0, 0, 0, 0, 350, 800, 1300, 6300, 50000, 80000, 100000];
        let v1 = if (arg0.on_win_reset) {
            1
        } else {
            0
        };
        let v2 = if (arg0.on_loss_reset) {
            1
        } else {
            0
        };
        let v3 = if (arg0.stop_on_first_win) {
            1
        } else {
            0
        };
        let v4 = 1;
        let v5 = arg1;
        let v6 = arg0.base_stake;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = b"";
        let v12 = b"";
        let v13 = vector[];
        let v14 = vector[];
        let v15 = 0;
        while (v15 < arg0.num_rounds) {
            let v16 = 0;
            let v17 = 0;
            let v18 = 0;
            while (v18 < 10) {
                let v19 = *0x1::vector::borrow<u64>(arg2, v15 * 10 + v18);
                assert!(v19 >= 1 && v19 <= 40, 18);
                let v20 = ((v19 - 1) as u8);
                let v21 = 1 << v20;
                assert!(v16 & v21 == 0, 18);
                v16 = v16 | v21;
                v17 = v17 + (arg0.picks_mask >> v20 & 1);
                0x1::vector::push_back<u8>(&mut v11, (v19 as u8));
                v18 = v18 + 1;
            };
            let v22 = v4 * (1 - ((18446744073709551616 + (v6 as u128) - (v5 as u128) - 1 >> 64) as u64));
            let v23 = v22 * v6;
            v5 = v5 - v23;
            let v24 = v7 + v23;
            v7 = v24;
            let v25 = *0x1::vector::borrow<u64>(&v0, paytable_index(arg0.risk, arg0.num_picks, v17));
            let v26 = ((18446744073709551616 + (v25 as u128) - 0 - 1 >> 64) as u64) * v22;
            let v27 = (((v23 as u128) * (v25 as u128) / (100 as u128)) as u64);
            let v28 = ((18446744073709551616 + (v23 as u128) - (v27 as u128) - 1 >> 64) as u64);
            v8 = v8 + v28 * v27 + (1 - v28) * v23;
            let v29 = v9 + v27;
            v9 = v29;
            v10 = v10 + v22;
            v4 = v22 * (1 - ((18446744073709551616 + (arg0.stop_profit as u128) - 0 - 1 >> 64) as u64) * (1 - ((18446744073709551616 + ((v24 + arg0.stop_profit) as u128) - (v29 as u128) - 1 >> 64) as u64))) * (1 - ((18446744073709551616 + (arg0.stop_loss as u128) - 0 - 1 >> 64) as u64) * (1 - ((18446744073709551616 + ((v29 + arg0.stop_loss) as u128) - (v24 as u128) - 1 >> 64) as u64))) * (1 - v3 * v26);
            let v30 = v26 * (v1 * arg0.base_stake + (1 - v1) * grow_stake(v6, arg0.on_win_bps, arg0.stake_cap)) + (v22 - v26) * (v2 * arg0.base_stake + (1 - v2) * grow_stake(v6, arg0.on_loss_bps, arg0.stake_cap));
            let v31 = (1 - v22) * v6;
            v6 = v30 + v31;
            0x1::vector::push_back<u8>(&mut v12, (v17 as u8));
            0x1::vector::push_back<u64>(&mut v13, v23);
            0x1::vector::push_back<u64>(&mut v14, v27);
            v15 = v15 + 1;
        };
        assert!(v9 >= v8, 11);
        assert!(v5 == arg1 - v7, 11);
        BatchOutcome{
            budget         : arg1,
            draws          : v11,
            hits           : v12,
            stakes         : v13,
            payouts        : v14,
            rounds_settled : v10,
            total_staked   : v7,
            returned_stake : v8,
            losing_stake   : v7 - v8,
            total_paid     : v9,
            total_profit   : v9 - v8,
            refund         : v5,
        }
    }

    fun settle_game_credits_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg4: &BatchPlan, arg5: u64, arg6: &vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<KenoV1>(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = KenoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<KenoV1>(v1, arg0, arg3, v0, arg5, arg7);
        let v2 = run_batch(arg4, arg5, arg6);
        let v3 = v2.losing_stake;
        let v4 = KenoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::debit_loss<KenoV1>(v4, arg0, arg3, v0, v3, arg7);
        let v5 = KenoV1{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<KenoV1>(v5, arg0, arg1, arg2, v2.total_profit, arg8), v0);
        (v2, v3)
    }

    fun settle_rflh_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &BatchPlan, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<KenoV1>(arg0);
        let v0 = run_batch(arg4, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5), arg6);
        let v1 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg1);
        let v2 = KenoV1{dummy_field: false};
        let (v3, v4) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve::split_rflh_loss(v0.losing_stake, v1);
        let v5 = KenoV1{dummy_field: false};
        let v6 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<KenoV1>(v5, arg0, arg1, arg2, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v3, arg8));
        assert!(v6 == v3, 11);
        let v7 = KenoV1{dummy_field: false};
        let (v8, v9) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::route_game_reserve_contribution<KenoV1>(v7, arg0, arg3, arg2, v1, 0x2::coin::into_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v4, arg8)), arg7);
        let v10 = KenoV1{dummy_field: false};
        let v11 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<KenoV1>(v10, arg0, arg1, arg2, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v9, arg8));
        assert!(v11 == v4 - v8, 11);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(v0.refund, v0.returned_stake), 11);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<KenoV1>(v2, arg0, arg1, arg2, v0.total_profit, arg8));
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(checked_add_u64(v0.refund, v0.returned_stake), v0.total_profit), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(arg5, 0x2::tx_context::sender(arg8));
        (v0, v6 + v11, v8)
    }

    public fun update_limits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut KenoConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 8);
        assert_valid_limits(arg2, arg3);
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitsUpdated{
            config_id        : 0x2::object::id<KenoConfig>(arg1),
            admin            : 0x2::tx_context::sender(arg4),
            previous_min_bet : arg1.min_bet,
            previous_max_bet : arg1.max_bet,
            new_min_bet      : arg2,
            new_max_bet      : arg3,
            config_version   : arg1.config_version,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

