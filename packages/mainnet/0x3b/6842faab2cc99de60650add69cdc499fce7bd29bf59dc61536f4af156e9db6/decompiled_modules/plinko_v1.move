module 0x3b6842faab2cc99de60650add69cdc499fce7bd29bf59dc61536f4af156e9db6::plinko_v1 {
    struct PlinkoV1 has drop {
        dummy_field: bool,
    }

    struct PlinkoConfig has key {
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
        risk: u8,
        rows: u8,
        max_multiplier_h: u64,
        num_balls: u64,
        stake: u64,
        stake_cap: u64,
        total_stake: u64,
    }

    struct BatchOutcome has copy, drop {
        budget: u64,
        paths: vector<u16>,
        buckets: vector<u8>,
        payouts: vector<u64>,
        total_staked: u64,
        returned_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
    }

    struct PlinkoBatchSettled has copy, drop {
        player: address,
        asset_type: u8,
        risk: u8,
        rows: u8,
        num_balls: u64,
        stake: u64,
        budget: u64,
        paths: vector<u16>,
        buckets: vector<u8>,
        payouts: vector<u64>,
        total_staked: u64,
        returned_stake: u64,
        losing_stake: u64,
        total_paid: u64,
        total_profit: u64,
        refund: u64,
        burned_amount: u64,
        reserve_amount: u64,
    }

    public fun admin_renounce_limit_updates(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut PlinkoConfig, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 9);
        assert_valid_limits(arg1.min_bet, arg1.max_bet);
        arg1.limit_updates_renounced = true;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitUpdatesRenounced{
            config_id : 0x2::object::id<PlinkoConfig>(arg1),
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
        let v0 = vector[560, 210, 110, 100, 50, 100, 110, 210, 560, 0, 0, 0, 0, 0, 0, 0, 0, 560, 200, 160, 100, 70, 70, 100, 160, 200, 560, 0, 0, 0, 0, 0, 0, 0, 890, 300, 140, 110, 100, 50, 100, 110, 140, 300, 890, 0, 0, 0, 0, 0, 0, 840, 300, 190, 130, 100, 70, 70, 100, 130, 190, 300, 840, 0, 0, 0, 0, 0, 1000, 300, 160, 140, 110, 100, 50, 100, 110, 140, 160, 300, 1000, 0, 0, 0, 0, 810, 400, 300, 190, 120, 90, 70, 70, 90, 120, 190, 300, 400, 810, 0, 0, 0, 710, 400, 190, 140, 130, 110, 100, 50, 100, 110, 130, 140, 190, 400, 710, 0, 0, 1500, 800, 300, 200, 150, 110, 100, 70, 70, 100, 110, 150, 200, 300, 800, 1500, 0, 1600, 900, 200, 140, 140, 120, 110, 100, 50, 100, 110, 120, 140, 140, 200, 900, 1600, 1300, 300, 130, 70, 40, 70, 130, 300, 1300, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 400, 170, 90, 50, 50, 90, 170, 400, 1800, 0, 0, 0, 0, 0, 0, 0, 2200, 500, 200, 140, 60, 40, 60, 140, 200, 500, 2200, 0, 0, 0, 0, 0, 0, 2400, 600, 300, 180, 70, 50, 50, 70, 180, 300, 600, 2400, 0, 0, 0, 0, 0, 3300, 1100, 400, 200, 110, 60, 30, 60, 110, 200, 400, 1100, 3300, 0, 0, 0, 0, 4300, 1300, 600, 300, 130, 70, 40, 40, 70, 130, 300, 600, 1300, 4300, 0, 0, 0, 5800, 1500, 700, 400, 190, 100, 50, 20, 50, 100, 190, 400, 700, 1500, 5800, 0, 0, 8800, 1800, 1100, 500, 300, 130, 50, 30, 30, 50, 130, 300, 500, 1100, 1800, 8800, 0, 11000, 4100, 1000, 500, 300, 150, 100, 50, 30, 50, 100, 150, 300, 500, 1000, 4100, 11000, 2900, 400, 150, 30, 20, 30, 150, 400, 2900, 0, 0, 0, 0, 0, 0, 0, 0, 4300, 700, 200, 60, 20, 20, 60, 200, 700, 4300, 0, 0, 0, 0, 0, 0, 0, 7600, 1000, 300, 90, 30, 20, 30, 90, 300, 1000, 7600, 0, 0, 0, 0, 0, 0, 12000, 1400, 520, 140, 40, 20, 20, 40, 140, 520, 1400, 12000, 0, 0, 0, 0, 0, 17000, 2400, 810, 200, 70, 20, 20, 20, 70, 200, 810, 2400, 17000, 0, 0, 0, 0, 26000, 3700, 1100, 400, 100, 20, 20, 20, 20, 100, 400, 1100, 3700, 26000, 0, 0, 0, 42000, 5600, 1800, 500, 190, 30, 20, 20, 20, 30, 190, 500, 1800, 5600, 42000, 0, 0, 62000, 8300, 2700, 800, 300, 50, 20, 20, 20, 20, 50, 300, 800, 2700, 8300, 62000, 0, 100000, 13000, 2600, 900, 400, 200, 20, 20, 20, 20, 20, 200, 400, 900, 2600, 13000, 100000, 5000, 460, 110, 10, 10, 10, 110, 460, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 780, 150, 20, 10, 10, 20, 150, 780, 10000, 0, 0, 0, 0, 0, 0, 0, 20100, 1100, 200, 60, 10, 10, 10, 60, 200, 1100, 20100, 0, 0, 0, 0, 0, 0, 32400, 1600, 400, 110, 20, 10, 10, 20, 110, 400, 1600, 32400, 0, 0, 0, 0, 0, 61900, 3000, 600, 150, 40, 10, 10, 10, 40, 150, 600, 3000, 61900, 0, 0, 0, 0, 101200, 5200, 1000, 300, 60, 10, 10, 10, 10, 60, 300, 1000, 5200, 101200, 0, 0, 0, 236900, 8000, 1600, 300, 120, 20, 10, 10, 10, 20, 120, 300, 1600, 8000, 236900, 0, 0, 500000, 12500, 2300, 600, 180, 20, 10, 10, 10, 10, 20, 180, 600, 2300, 12500, 500000, 0, 1000000, 21600, 2600, 700, 250, 110, 10, 10, 10, 10, 10, 110, 250, 700, 2600, 21600, 1000000];
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 <= 3) {
            let v4 = 8;
            while (v4 <= 16) {
                let v5 = *0x1::vector::borrow<u64>(&v0, paytable_index(v3, v4, 0));
                if (v5 > v1) {
                    v2 = v5;
                };
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(arg0 <= (((1000000000000000 as u128) * (100 as u128) / (v2 as u128)) as u64), 10);
    }

    entry fun bet_game_credits_plinko_v1(arg0: &PlinkoConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<PlinkoV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, arg7);
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = PlinkoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<PlinkoV1>(v2, arg1, arg4, v1, arg7, arg6);
        let v3 = draw_paths(arg5, arg10, arg9, arg12);
        let (v4, v5) = settle_game_credits_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v3, arg6, arg12);
        let v6 = v4;
        emit_plinko_batch_settled(v1, 2, &v0, &v6, v5, 0);
    }

    entry fun bet_rflh_plinko_v1(arg0: &PlinkoConfig, arg1: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg4: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<PlinkoV1>(arg1);
        let v0 = build_batch_plan(arg0, arg8, arg9, arg10, arg11, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg7));
        let v1 = draw_paths(arg5, arg10, arg9, arg12);
        let v2 = 0x2::tx_context::sender(arg12);
        let (v3, v4, v5) = settle_rflh_batch(arg1, arg2, arg3, arg4, &v0, arg7, &v1, arg6, arg12);
        let v6 = v3;
        emit_plinko_batch_settled(v2, 1, &v0, &v6, v4, v5);
    }

    fun bucket_of_path(arg0: u16) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            v0 = v0 + ((arg0 >> v1 & 1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    fun build_batch_plan(arg0: &PlinkoConfig, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u64) : BatchPlan {
        assert!(arg3 >= 1 && arg3 <= 100, 14);
        assert!(arg1 <= 3, 12);
        assert!(arg2 >= 8 && arg2 <= 16, 13);
        let v0 = vector[560, 210, 110, 100, 50, 100, 110, 210, 560, 0, 0, 0, 0, 0, 0, 0, 0, 560, 200, 160, 100, 70, 70, 100, 160, 200, 560, 0, 0, 0, 0, 0, 0, 0, 890, 300, 140, 110, 100, 50, 100, 110, 140, 300, 890, 0, 0, 0, 0, 0, 0, 840, 300, 190, 130, 100, 70, 70, 100, 130, 190, 300, 840, 0, 0, 0, 0, 0, 1000, 300, 160, 140, 110, 100, 50, 100, 110, 140, 160, 300, 1000, 0, 0, 0, 0, 810, 400, 300, 190, 120, 90, 70, 70, 90, 120, 190, 300, 400, 810, 0, 0, 0, 710, 400, 190, 140, 130, 110, 100, 50, 100, 110, 130, 140, 190, 400, 710, 0, 0, 1500, 800, 300, 200, 150, 110, 100, 70, 70, 100, 110, 150, 200, 300, 800, 1500, 0, 1600, 900, 200, 140, 140, 120, 110, 100, 50, 100, 110, 120, 140, 140, 200, 900, 1600, 1300, 300, 130, 70, 40, 70, 130, 300, 1300, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 400, 170, 90, 50, 50, 90, 170, 400, 1800, 0, 0, 0, 0, 0, 0, 0, 2200, 500, 200, 140, 60, 40, 60, 140, 200, 500, 2200, 0, 0, 0, 0, 0, 0, 2400, 600, 300, 180, 70, 50, 50, 70, 180, 300, 600, 2400, 0, 0, 0, 0, 0, 3300, 1100, 400, 200, 110, 60, 30, 60, 110, 200, 400, 1100, 3300, 0, 0, 0, 0, 4300, 1300, 600, 300, 130, 70, 40, 40, 70, 130, 300, 600, 1300, 4300, 0, 0, 0, 5800, 1500, 700, 400, 190, 100, 50, 20, 50, 100, 190, 400, 700, 1500, 5800, 0, 0, 8800, 1800, 1100, 500, 300, 130, 50, 30, 30, 50, 130, 300, 500, 1100, 1800, 8800, 0, 11000, 4100, 1000, 500, 300, 150, 100, 50, 30, 50, 100, 150, 300, 500, 1000, 4100, 11000, 2900, 400, 150, 30, 20, 30, 150, 400, 2900, 0, 0, 0, 0, 0, 0, 0, 0, 4300, 700, 200, 60, 20, 20, 60, 200, 700, 4300, 0, 0, 0, 0, 0, 0, 0, 7600, 1000, 300, 90, 30, 20, 30, 90, 300, 1000, 7600, 0, 0, 0, 0, 0, 0, 12000, 1400, 520, 140, 40, 20, 20, 40, 140, 520, 1400, 12000, 0, 0, 0, 0, 0, 17000, 2400, 810, 200, 70, 20, 20, 20, 70, 200, 810, 2400, 17000, 0, 0, 0, 0, 26000, 3700, 1100, 400, 100, 20, 20, 20, 20, 100, 400, 1100, 3700, 26000, 0, 0, 0, 42000, 5600, 1800, 500, 190, 30, 20, 20, 20, 30, 190, 500, 1800, 5600, 42000, 0, 0, 62000, 8300, 2700, 800, 300, 50, 20, 20, 20, 20, 50, 300, 800, 2700, 8300, 62000, 0, 100000, 13000, 2600, 900, 400, 200, 20, 20, 20, 20, 20, 200, 400, 900, 2600, 13000, 100000, 5000, 460, 110, 10, 10, 10, 110, 460, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 780, 150, 20, 10, 10, 20, 150, 780, 10000, 0, 0, 0, 0, 0, 0, 0, 20100, 1100, 200, 60, 10, 10, 10, 60, 200, 1100, 20100, 0, 0, 0, 0, 0, 0, 32400, 1600, 400, 110, 20, 10, 10, 20, 110, 400, 1600, 32400, 0, 0, 0, 0, 0, 61900, 3000, 600, 150, 40, 10, 10, 10, 40, 150, 600, 3000, 61900, 0, 0, 0, 0, 101200, 5200, 1000, 300, 60, 10, 10, 10, 10, 60, 300, 1000, 5200, 101200, 0, 0, 0, 236900, 8000, 1600, 300, 120, 20, 10, 10, 10, 20, 120, 300, 1600, 8000, 236900, 0, 0, 500000, 12500, 2300, 600, 180, 20, 10, 10, 10, 10, 20, 180, 600, 2300, 12500, 500000, 0, 1000000, 21600, 2600, 700, 250, 110, 10, 10, 10, 10, 10, 110, 250, 700, 2600, 21600, 1000000];
        let v1 = *0x1::vector::borrow<u64>(&v0, paytable_index(arg1, arg2, 0));
        assert!(v1 > 0, 11);
        let v2 = (((1000000000000000 as u128) * (100 as u128) / (v1 as u128)) as u64);
        let v3 = if (v2 < arg0.max_bet) {
            v2
        } else {
            arg0.max_bet
        };
        assert!(arg4 >= arg0.min_bet && arg4 <= v3, 2);
        let v4 = checked_mul_u64(arg3, arg4);
        assert!(arg5 >= v4, 15);
        assert!(arg5 <= checked_mul_u64(arg3, v3), 15);
        BatchPlan{
            risk             : arg1,
            rows             : arg2,
            max_multiplier_h : v1,
            num_balls        : arg3,
            stake            : arg4,
            stake_cap        : v3,
            total_stake      : v4,
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

    public fun config_version(arg0: &PlinkoConfig) : u64 {
        arg0.config_version
    }

    fun draw_paths(arg0: &0x2::random::Random, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : vector<u16> {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<u16>(&mut v1, 0x2::random::generate_u16(&mut v0) & (((1 << arg2) - 1) as u16));
            v2 = v2 + 1;
        };
        v1
    }

    fun emit_plinko_batch_settled(arg0: address, arg1: u8, arg2: &BatchPlan, arg3: &BatchOutcome, arg4: u64, arg5: u64) {
        let v0 = PlinkoBatchSettled{
            player         : arg0,
            asset_type     : arg1,
            risk           : arg2.risk,
            rows           : arg2.rows,
            num_balls      : arg2.num_balls,
            stake          : arg2.stake,
            budget         : arg3.budget,
            paths          : arg3.paths,
            buckets        : arg3.buckets,
            payouts        : arg3.payouts,
            total_staked   : arg3.total_staked,
            returned_stake : arg3.returned_stake,
            losing_stake   : arg3.losing_stake,
            total_paid     : arg3.total_paid,
            total_profit   : arg3.total_profit,
            refund         : arg3.refund,
            burned_amount  : arg4,
            reserve_amount : arg5,
        };
        0x2::event::emit<PlinkoBatchSettled>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlinkoConfig{
            id                      : 0x2::object::new(arg0),
            config_version          : 1,
            min_bet                 : 100000000,
            max_bet                 : 1000000000000,
            limit_updates_renounced : false,
        };
        0x2::transfer::share_object<PlinkoConfig>(v0);
    }

    public fun limit_updates_renounced(arg0: &PlinkoConfig) : bool {
        arg0.limit_updates_renounced
    }

    public fun max_bet(arg0: &PlinkoConfig) : u64 {
        arg0.max_bet
    }

    public fun max_plinko_balls() : u64 {
        100
    }

    public fun max_plinko_bet_ceiling() : u64 {
        1000000000000
    }

    public fun max_plinko_win() : u64 {
        1000000000000000
    }

    public fun max_risk() : u8 {
        3
    }

    public fun max_rows() : u8 {
        16
    }

    public fun min_bet(arg0: &PlinkoConfig) : u64 {
        arg0.min_bet
    }

    public fun min_plinko_bet_floor() : u64 {
        10000000
    }

    public fun min_rows() : u8 {
        8
    }

    public fun multiplier_denominator() : u64 {
        100
    }

    public(friend) fun outcome_buckets(arg0: &BatchOutcome) : vector<u8> {
        arg0.buckets
    }

    public(friend) fun outcome_budget(arg0: &BatchOutcome) : u64 {
        arg0.budget
    }

    public(friend) fun outcome_losing_stake(arg0: &BatchOutcome) : u64 {
        arg0.losing_stake
    }

    public(friend) fun outcome_paths(arg0: &BatchOutcome) : vector<u16> {
        arg0.paths
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

    public(friend) fun outcome_total_paid(arg0: &BatchOutcome) : u64 {
        arg0.total_paid
    }

    public(friend) fun outcome_total_profit(arg0: &BatchOutcome) : u64 {
        arg0.total_profit
    }

    public(friend) fun outcome_total_staked(arg0: &BatchOutcome) : u64 {
        arg0.total_staked
    }

    fun paytable_index(arg0: u8, arg1: u8, arg2: u64) : u64 {
        (arg0 as u64) * 153 + ((arg1 - 8) as u64) * 17 + arg2
    }

    public fun paytable_multiplier(arg0: u8, arg1: u8, arg2: u64) : u64 {
        assert!(arg0 <= 3, 12);
        assert!(arg1 >= 8 && arg1 <= 16, 13);
        assert!(arg2 <= (arg1 as u64), 18);
        let v0 = vector[560, 210, 110, 100, 50, 100, 110, 210, 560, 0, 0, 0, 0, 0, 0, 0, 0, 560, 200, 160, 100, 70, 70, 100, 160, 200, 560, 0, 0, 0, 0, 0, 0, 0, 890, 300, 140, 110, 100, 50, 100, 110, 140, 300, 890, 0, 0, 0, 0, 0, 0, 840, 300, 190, 130, 100, 70, 70, 100, 130, 190, 300, 840, 0, 0, 0, 0, 0, 1000, 300, 160, 140, 110, 100, 50, 100, 110, 140, 160, 300, 1000, 0, 0, 0, 0, 810, 400, 300, 190, 120, 90, 70, 70, 90, 120, 190, 300, 400, 810, 0, 0, 0, 710, 400, 190, 140, 130, 110, 100, 50, 100, 110, 130, 140, 190, 400, 710, 0, 0, 1500, 800, 300, 200, 150, 110, 100, 70, 70, 100, 110, 150, 200, 300, 800, 1500, 0, 1600, 900, 200, 140, 140, 120, 110, 100, 50, 100, 110, 120, 140, 140, 200, 900, 1600, 1300, 300, 130, 70, 40, 70, 130, 300, 1300, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 400, 170, 90, 50, 50, 90, 170, 400, 1800, 0, 0, 0, 0, 0, 0, 0, 2200, 500, 200, 140, 60, 40, 60, 140, 200, 500, 2200, 0, 0, 0, 0, 0, 0, 2400, 600, 300, 180, 70, 50, 50, 70, 180, 300, 600, 2400, 0, 0, 0, 0, 0, 3300, 1100, 400, 200, 110, 60, 30, 60, 110, 200, 400, 1100, 3300, 0, 0, 0, 0, 4300, 1300, 600, 300, 130, 70, 40, 40, 70, 130, 300, 600, 1300, 4300, 0, 0, 0, 5800, 1500, 700, 400, 190, 100, 50, 20, 50, 100, 190, 400, 700, 1500, 5800, 0, 0, 8800, 1800, 1100, 500, 300, 130, 50, 30, 30, 50, 130, 300, 500, 1100, 1800, 8800, 0, 11000, 4100, 1000, 500, 300, 150, 100, 50, 30, 50, 100, 150, 300, 500, 1000, 4100, 11000, 2900, 400, 150, 30, 20, 30, 150, 400, 2900, 0, 0, 0, 0, 0, 0, 0, 0, 4300, 700, 200, 60, 20, 20, 60, 200, 700, 4300, 0, 0, 0, 0, 0, 0, 0, 7600, 1000, 300, 90, 30, 20, 30, 90, 300, 1000, 7600, 0, 0, 0, 0, 0, 0, 12000, 1400, 520, 140, 40, 20, 20, 40, 140, 520, 1400, 12000, 0, 0, 0, 0, 0, 17000, 2400, 810, 200, 70, 20, 20, 20, 70, 200, 810, 2400, 17000, 0, 0, 0, 0, 26000, 3700, 1100, 400, 100, 20, 20, 20, 20, 100, 400, 1100, 3700, 26000, 0, 0, 0, 42000, 5600, 1800, 500, 190, 30, 20, 20, 20, 30, 190, 500, 1800, 5600, 42000, 0, 0, 62000, 8300, 2700, 800, 300, 50, 20, 20, 20, 20, 50, 300, 800, 2700, 8300, 62000, 0, 100000, 13000, 2600, 900, 400, 200, 20, 20, 20, 20, 20, 200, 400, 900, 2600, 13000, 100000, 5000, 460, 110, 10, 10, 10, 110, 460, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 780, 150, 20, 10, 10, 20, 150, 780, 10000, 0, 0, 0, 0, 0, 0, 0, 20100, 1100, 200, 60, 10, 10, 10, 60, 200, 1100, 20100, 0, 0, 0, 0, 0, 0, 32400, 1600, 400, 110, 20, 10, 10, 20, 110, 400, 1600, 32400, 0, 0, 0, 0, 0, 61900, 3000, 600, 150, 40, 10, 10, 10, 40, 150, 600, 3000, 61900, 0, 0, 0, 0, 101200, 5200, 1000, 300, 60, 10, 10, 10, 10, 60, 300, 1000, 5200, 101200, 0, 0, 0, 236900, 8000, 1600, 300, 120, 20, 10, 10, 10, 20, 120, 300, 1600, 8000, 236900, 0, 0, 500000, 12500, 2300, 600, 180, 20, 10, 10, 10, 10, 20, 180, 600, 2300, 12500, 500000, 0, 1000000, 21600, 2600, 700, 250, 110, 10, 10, 10, 10, 10, 110, 250, 700, 2600, 21600, 1000000];
        *0x1::vector::borrow<u64>(&v0, paytable_index(arg0, arg1, arg2))
    }

    public fun risk_expert() : u8 {
        3
    }

    public fun risk_high() : u8 {
        2
    }

    public fun risk_low() : u8 {
        0
    }

    public fun risk_medium() : u8 {
        1
    }

    fun run_batch(arg0: &BatchPlan, arg1: u64, arg2: &vector<u16>) : BatchOutcome {
        assert!(0x1::vector::length<u16>(arg2) == arg0.num_balls, 18);
        let v0 = vector[560, 210, 110, 100, 50, 100, 110, 210, 560, 0, 0, 0, 0, 0, 0, 0, 0, 560, 200, 160, 100, 70, 70, 100, 160, 200, 560, 0, 0, 0, 0, 0, 0, 0, 890, 300, 140, 110, 100, 50, 100, 110, 140, 300, 890, 0, 0, 0, 0, 0, 0, 840, 300, 190, 130, 100, 70, 70, 100, 130, 190, 300, 840, 0, 0, 0, 0, 0, 1000, 300, 160, 140, 110, 100, 50, 100, 110, 140, 160, 300, 1000, 0, 0, 0, 0, 810, 400, 300, 190, 120, 90, 70, 70, 90, 120, 190, 300, 400, 810, 0, 0, 0, 710, 400, 190, 140, 130, 110, 100, 50, 100, 110, 130, 140, 190, 400, 710, 0, 0, 1500, 800, 300, 200, 150, 110, 100, 70, 70, 100, 110, 150, 200, 300, 800, 1500, 0, 1600, 900, 200, 140, 140, 120, 110, 100, 50, 100, 110, 120, 140, 140, 200, 900, 1600, 1300, 300, 130, 70, 40, 70, 130, 300, 1300, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 400, 170, 90, 50, 50, 90, 170, 400, 1800, 0, 0, 0, 0, 0, 0, 0, 2200, 500, 200, 140, 60, 40, 60, 140, 200, 500, 2200, 0, 0, 0, 0, 0, 0, 2400, 600, 300, 180, 70, 50, 50, 70, 180, 300, 600, 2400, 0, 0, 0, 0, 0, 3300, 1100, 400, 200, 110, 60, 30, 60, 110, 200, 400, 1100, 3300, 0, 0, 0, 0, 4300, 1300, 600, 300, 130, 70, 40, 40, 70, 130, 300, 600, 1300, 4300, 0, 0, 0, 5800, 1500, 700, 400, 190, 100, 50, 20, 50, 100, 190, 400, 700, 1500, 5800, 0, 0, 8800, 1800, 1100, 500, 300, 130, 50, 30, 30, 50, 130, 300, 500, 1100, 1800, 8800, 0, 11000, 4100, 1000, 500, 300, 150, 100, 50, 30, 50, 100, 150, 300, 500, 1000, 4100, 11000, 2900, 400, 150, 30, 20, 30, 150, 400, 2900, 0, 0, 0, 0, 0, 0, 0, 0, 4300, 700, 200, 60, 20, 20, 60, 200, 700, 4300, 0, 0, 0, 0, 0, 0, 0, 7600, 1000, 300, 90, 30, 20, 30, 90, 300, 1000, 7600, 0, 0, 0, 0, 0, 0, 12000, 1400, 520, 140, 40, 20, 20, 40, 140, 520, 1400, 12000, 0, 0, 0, 0, 0, 17000, 2400, 810, 200, 70, 20, 20, 20, 70, 200, 810, 2400, 17000, 0, 0, 0, 0, 26000, 3700, 1100, 400, 100, 20, 20, 20, 20, 100, 400, 1100, 3700, 26000, 0, 0, 0, 42000, 5600, 1800, 500, 190, 30, 20, 20, 20, 30, 190, 500, 1800, 5600, 42000, 0, 0, 62000, 8300, 2700, 800, 300, 50, 20, 20, 20, 20, 50, 300, 800, 2700, 8300, 62000, 0, 100000, 13000, 2600, 900, 400, 200, 20, 20, 20, 20, 20, 200, 400, 900, 2600, 13000, 100000, 5000, 460, 110, 10, 10, 10, 110, 460, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 10000, 780, 150, 20, 10, 10, 20, 150, 780, 10000, 0, 0, 0, 0, 0, 0, 0, 20100, 1100, 200, 60, 10, 10, 10, 60, 200, 1100, 20100, 0, 0, 0, 0, 0, 0, 32400, 1600, 400, 110, 20, 10, 10, 20, 110, 400, 1600, 32400, 0, 0, 0, 0, 0, 61900, 3000, 600, 150, 40, 10, 10, 10, 40, 150, 600, 3000, 61900, 0, 0, 0, 0, 101200, 5200, 1000, 300, 60, 10, 10, 10, 10, 60, 300, 1000, 5200, 101200, 0, 0, 0, 236900, 8000, 1600, 300, 120, 20, 10, 10, 10, 20, 120, 300, 1600, 8000, 236900, 0, 0, 500000, 12500, 2300, 600, 180, 20, 10, 10, 10, 10, 20, 180, 600, 2300, 12500, 500000, 0, 1000000, 21600, 2600, 700, 250, 110, 10, 10, 10, 10, 10, 110, 250, 700, 2600, 21600, 1000000];
        let v1 = arg0.stake;
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[];
        let v5 = b"";
        let v6 = vector[];
        let v7 = 0;
        while (v7 < arg0.num_balls) {
            let v8 = *0x1::vector::borrow<u16>(arg2, v7);
            assert!(v8 <= (((1 << arg0.rows) - 1) as u16), 18);
            let v9 = bucket_of_path(v8);
            let v10 = (((v1 as u128) * (*0x1::vector::borrow<u64>(&v0, paytable_index(arg0.risk, arg0.rows, v9)) as u128) / (100 as u128)) as u64);
            let v11 = ((18446744073709551616 + (v1 as u128) - (v10 as u128) - 1 >> 64) as u64);
            v2 = v2 + v11 * v10 + (1 - v11) * v1;
            v3 = v3 + v10;
            0x1::vector::push_back<u16>(&mut v4, v8);
            0x1::vector::push_back<u8>(&mut v5, (v9 as u8));
            0x1::vector::push_back<u64>(&mut v6, v10);
            v7 = v7 + 1;
        };
        let v12 = arg0.total_stake;
        assert!(v3 >= v2, 11);
        assert!(arg1 >= v12, 11);
        BatchOutcome{
            budget         : arg1,
            paths          : v4,
            buckets        : v5,
            payouts        : v6,
            total_staked   : v12,
            returned_stake : v2,
            losing_stake   : v12 - v2,
            total_paid     : v3,
            total_profit   : v3 - v2,
            refund         : arg1 - v12,
        }
    }

    fun settle_game_credits_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::GameCreditsLedger, arg4: &BatchPlan, arg5: u64, arg6: &vector<u16>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<PlinkoV1>(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = PlinkoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::assert_balance_at_least<PlinkoV1>(v1, arg0, arg3, v0, arg5, arg7);
        let v2 = run_batch(arg4, arg5, arg6);
        let v3 = v2.losing_stake;
        let v4 = PlinkoV1{dummy_field: false};
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_credits::debit_loss<PlinkoV1>(v4, arg0, arg3, v0, v3, arg7);
        let v5 = PlinkoV1{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<PlinkoV1>(v5, arg0, arg1, arg2, v2.total_profit, arg8), v0);
        (v2, v3)
    }

    fun settle_rflh_batch(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::GameRegistry, arg1: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::AuthorityVault, arg2: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RflhTreasuryAuthority, arg3: &mut 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::PrizeReserve, arg4: &BatchPlan, arg5: 0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>, arg6: &vector<u16>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (BatchOutcome, u64, u64) {
        0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::game_registry::assert_game_authorized<PlinkoV1>(arg0);
        let v0 = run_batch(arg4, 0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5), arg6);
        let v1 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::current_total_tracked_supply(arg1);
        let v2 = PlinkoV1{dummy_field: false};
        let (v3, v4) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve::split_rflh_loss(v0.losing_stake, v1);
        let v5 = PlinkoV1{dummy_field: false};
        let v6 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<PlinkoV1>(v5, arg0, arg1, arg2, 0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v3, arg8));
        assert!(v6 == v3, 11);
        let v7 = PlinkoV1{dummy_field: false};
        let (v8, v9) = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::treasury::route_game_reserve_contribution<PlinkoV1>(v7, arg0, arg3, arg2, v1, 0x2::coin::into_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(0x2::coin::split<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, v4, arg8)), arg7);
        let v10 = PlinkoV1{dummy_field: false};
        let v11 = 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::burn_rflh_for_game<PlinkoV1>(v10, arg0, arg1, arg2, 0x2::coin::from_balance<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(v9, arg8));
        assert!(v11 == v4 - v8, 11);
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(v0.refund, v0.returned_stake), 11);
        0x2::coin::join<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&mut arg5, 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::tokens::mint_rflh_for_game<PlinkoV1>(v2, arg0, arg1, arg2, v0.total_profit, arg8));
        assert!(0x2::coin::value<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>(&arg5) == checked_add_u64(checked_add_u64(v0.refund, v0.returned_stake), v0.total_profit), 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::rflh::RFLH>>(arg5, 0x2::tx_context::sender(arg8));
        (v0, v6 + v11, v8)
    }

    public fun update_limits(arg0: &0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::config::AdminCap, arg1: &mut PlinkoConfig, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.limit_updates_renounced, 8);
        assert_valid_limits(arg2, arg3);
        arg1.min_bet = arg2;
        arg1.max_bet = arg3;
        arg1.config_version = arg1.config_version + 1;
        let v0 = LimitsUpdated{
            config_id        : 0x2::object::id<PlinkoConfig>(arg1),
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

