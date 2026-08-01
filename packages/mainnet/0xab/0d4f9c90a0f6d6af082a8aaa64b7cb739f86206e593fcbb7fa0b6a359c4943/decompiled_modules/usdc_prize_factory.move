module 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::usdc_prize_factory {
    struct FactoryOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct Config has copy, drop, store {
        staking_fee_bps: u64,
        spread_bps: u64,
        early_exit_fee_bps: u64,
        epoch_duration_ms: u64,
        maturity_period_ms: u64,
        max_slippage_bps: u64,
        max_oracle_age_ms: u64,
        max_oracle_variance_bps: u64,
        grace_period_ms: u64,
        min_deposit_mist: u64,
        liquidity_buffer_bps: u64,
        validator: address,
    }

    struct SlotInfo has copy, drop, store {
        beneficiary: address,
        receipt_id: 0x2::object::ID,
        principal: u64,
        eligible_from_ms: u64,
        active: bool,
    }

    struct PendingPrize has copy, drop, store {
        epoch_id: u64,
        winner: address,
        winner_slot: u64,
        sui_amount: u64,
    }

    struct DepositReceipt has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        slot: u64,
        principal: u64,
        deposited_at_ms: u64,
        matures_at_ms: u64,
    }

    struct AdminTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        stream_a: 0x2::balance::Balance<0x2::sui::SUI>,
        stream_b: 0x2::balance::Balance<T0>,
        lifetime_stream_a: u64,
        lifetime_stream_b: u64,
    }

    struct RafflePool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config: Config,
        treasury_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        operator_cap_id: 0x2::object::ID,
        price_feed_id: 0x2::object::ID,
        prize_decimals: u8,
        total_principal: u64,
        liquid: 0x2::balance::Balance<0x2::sui::SUI>,
        stakes: 0x2::table::Table<u64, 0x3::staking_pool::StakedSui>,
        stake_head: u64,
        stake_tail: u64,
        staked_principal: u64,
        weights: 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::Fenwick,
        slots: 0x2::table::Table<u64, SlotInfo>,
        next_slot: u64,
        active_depositors: u64,
        prize_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_prize: 0x1::option::Option<PendingPrize>,
        epoch_id: u64,
        epoch_ends_at_ms: u64,
        phase: u8,
        deposits_paused: bool,
    }

    struct WithdrawalIntent has drop {
        receipt_id: 0x2::object::ID,
        slot: u64,
        principal: u64,
        beneficiary: address,
        is_early: bool,
        principal_before: u64,
        now_ms: u64,
        liquidity_needed: u64,
    }

    struct SwapTicket {
        pool_id: 0x2::object::ID,
        epoch_id: u64,
        winner: address,
        sui_in: u64,
        minimum_out: u64,
        fair_value_out: u64,
        attestation: 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::PriceAttestation,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        operator_cap_id: 0x2::object::ID,
        price_feed_id: 0x2::object::ID,
        config: Config,
    }

    struct DepositMade has copy, drop {
        pool_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        depositor: address,
        slot: u64,
        amount: u64,
        eligible_from_ms: u64,
        total_principal: u64,
        timestamp_ms: u64,
    }

    struct WithdrawalMade has copy, drop {
        pool_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        beneficiary: address,
        slot: u64,
        principal_returned: u64,
        was_early: bool,
        early_exit_fee: u64,
        rewards_to_prize: u64,
        total_principal: u64,
        timestamp_ms: u64,
    }

    struct YieldHarvested has copy, drop {
        pool_id: 0x2::object::ID,
        epoch_id: u64,
        gross_yield: u64,
        stream_a_fee: u64,
        net_to_prize: u64,
        prize_carry_over: u64,
        total_principal: u64,
        restaked_amount: u64,
        harvested_at_ms: u64,
        sui_epoch: u64,
    }

    struct WinnerSelected has copy, drop {
        pool_id: 0x2::object::ID,
        epoch_id: u64,
        winner: address,
        winner_slot: u64,
        winner_weight: u128,
        total_weight: u128,
        prize_sui: u64,
        attempts: u8,
        permissionless: bool,
        timestamp_ms: u64,
    }

    struct DrawRolledOver has copy, drop {
        pool_id: 0x2::object::ID,
        epoch_id: u64,
        carried_prize_sui: u64,
        reason_no_eligible_slots: bool,
        timestamp_ms: u64,
    }

    struct PrizeSettled has copy, drop {
        pool_id: 0x2::object::ID,
        epoch_id: u64,
        winner: address,
        sui_converted: u64,
        oracle_price_1e18: u128,
        oracle_fair_value_out: u64,
        amm_gross_out: u64,
        spread_bps: u64,
        stream_b_fee: u64,
        winner_payout: u64,
        realised_slippage_bps: u64,
        timestamp_ms: u64,
    }

    struct ConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        previous: Config,
        current: Config,
        timestamp_ms: u64,
    }

    struct TreasurySwept has copy, drop {
        pool_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        stream_a_amount: u64,
        stream_b_amount: u64,
        recipient: address,
    }

    struct DepositsPauseToggled has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
    }

    public fun active_depositors<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.active_depositors
    }

    fun apply_harvest<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::math::bps_of(v0, arg0.config.staking_fee_bps);
        if (v1 > 0) {
            arg1.lifetime_stream_a = arg1.lifetime_stream_a + v1;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.stream_a, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v1));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_sui, arg2);
        arg0.epoch_id = arg0.epoch_id + 1;
        arg0.epoch_ends_at_ms = arg4 + arg0.config.epoch_duration_ms;
        arg0.phase = 1;
        let v2 = YieldHarvested{
            pool_id          : 0x2::object::id<RafflePool<T0>>(arg0),
            epoch_id         : arg0.epoch_id,
            gross_yield      : v0,
            stream_a_fee     : v1,
            net_to_prize     : 0x2::balance::value<0x2::sui::SUI>(&arg2),
            prize_carry_over : 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_sui),
            total_principal  : arg0.total_principal,
            restaked_amount  : arg3,
            harvested_at_ms  : arg4,
            sui_epoch        : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<YieldHarvested>(v2);
    }

    fun assert_config_within_bounds(arg0: &Config) {
        assert!(arg0.staking_fee_bps <= 2000, 16);
        assert!(arg0.spread_bps <= 300, 16);
        assert!(arg0.early_exit_fee_bps <= 5000, 16);
        assert!(arg0.max_slippage_bps <= 1000, 16);
        assert!(arg0.liquidity_buffer_bps <= 2000, 16);
        assert!(arg0.epoch_duration_ms >= 3600000 && arg0.epoch_duration_ms <= 2592000000, 17);
        assert!(arg0.min_deposit_mist > 0, 3);
    }

    fun assert_version<T0>(arg0: &RafflePool<T0>) {
        assert!(arg0.version == 1, 1);
    }

    fun begin_withdrawal<T0>(arg0: &mut RafflePool<T0>, arg1: DepositReceipt, arg2: &0x2::clock::Clock) : WithdrawalIntent {
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 5);
        let DepositReceipt {
            id              : v0,
            pool_id         : _,
            slot            : v2,
            principal       : v3,
            deposited_at_ms : _,
            matures_at_ms   : v5,
        } = arg1;
        let v6 = v0;
        0x2::object::delete(v6);
        let v7 = 0x2::clock::timestamp_ms(arg2);
        let v8 = v7 < v5;
        let v9 = 0x2::table::borrow_mut<u64, SlotInfo>(&mut arg0.slots, v2);
        assert!(v9.active, 21);
        v9.active = false;
        0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::decrease(&mut arg0.weights, v2, (v3 as u128));
        arg0.total_principal = arg0.total_principal - v3;
        arg0.active_depositors = arg0.active_depositors - 1;
        let v10 = if (v8 && v3 < 18446744073709551615) {
            v3 + 1
        } else {
            v3
        };
        WithdrawalIntent{
            receipt_id       : 0x2::object::uid_to_inner(&v6),
            slot             : v2,
            principal        : v3,
            beneficiary      : v9.beneficiary,
            is_early         : v8,
            principal_before : arg0.total_principal,
            now_ms           : v7,
            liquidity_needed : v10,
        }
    }

    public fun config<T0>(arg0: &RafflePool<T0>) : Config {
        arg0.config
    }

    public fun create_pool<T0>(arg0: &FactoryOwnerCap, arg1: u8, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (AdminCap, OperatorCap) {
        let v0 = Config{
            staking_fee_bps         : arg3,
            spread_bps              : arg4,
            early_exit_fee_bps      : arg5,
            epoch_duration_ms       : arg6,
            maturity_period_ms      : arg7,
            max_slippage_bps        : arg8,
            max_oracle_age_ms       : arg9,
            max_oracle_variance_bps : arg10,
            grace_period_ms         : arg11,
            min_deposit_mist        : arg12,
            liquidity_buffer_bps    : arg13,
            validator               : arg14,
        };
        assert_config_within_bounds(&v0);
        assert!(arg1 <= 18, 22);
        let v1 = 0x2::object::new(arg16);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = AdminTreasury<T0>{
            id                : 0x2::object::new(arg16),
            pool_id           : v2,
            stream_a          : 0x2::balance::zero<0x2::sui::SUI>(),
            stream_b          : 0x2::balance::zero<T0>(),
            lifetime_stream_a : 0,
            lifetime_stream_b : 0,
        };
        let v4 = 0x2::object::id<AdminTreasury<T0>>(&v3);
        let v5 = AdminCap{
            id      : 0x2::object::new(arg16),
            pool_id : v2,
        };
        let v6 = OperatorCap{
            id      : 0x2::object::new(arg16),
            pool_id : v2,
        };
        let v7 = 0x2::object::id<AdminCap>(&v5);
        let v8 = 0x2::object::id<OperatorCap>(&v6);
        let v9 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2);
        let v10 = RafflePool<T0>{
            id                : v1,
            version           : 1,
            config            : v0,
            treasury_id       : v4,
            admin_cap_id      : v7,
            operator_cap_id   : v8,
            price_feed_id     : v9,
            prize_decimals    : arg1,
            total_principal   : 0,
            liquid            : 0x2::balance::zero<0x2::sui::SUI>(),
            stakes            : 0x2::table::new<u64, 0x3::staking_pool::StakedSui>(arg16),
            stake_head        : 0,
            stake_tail        : 0,
            staked_principal  : 0,
            weights           : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::new(1048576, arg16),
            slots             : 0x2::table::new<u64, SlotInfo>(arg16),
            next_slot         : 1,
            active_depositors : 0,
            prize_sui         : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_prize     : 0x1::option::none<PendingPrize>(),
            epoch_id          : 0,
            epoch_ends_at_ms  : 0x2::clock::timestamp_ms(arg15) + arg6,
            phase             : 0,
            deposits_paused   : false,
        };
        let v11 = PoolCreated{
            pool_id         : v2,
            treasury_id     : v4,
            admin_cap_id    : v7,
            operator_cap_id : v8,
            price_feed_id   : v9,
            config          : v0,
        };
        0x2::event::emit<PoolCreated>(v11);
        0x2::transfer::share_object<RafflePool<T0>>(v10);
        0x2::transfer::share_object<AdminTreasury<T0>>(v3);
        (v5, v6)
    }

    public fun deposit<T0>(arg0: &mut RafflePool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DepositReceipt {
        assert_version<T0>(arg0);
        assert!(!arg0.deposits_paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.config.min_deposit_mist, 3);
        assert!(arg0.next_slot <= 1048576, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = arg0.next_slot;
        arg0.next_slot = v2 + 1;
        let v3 = 0x2::object::id<RafflePool<T0>>(arg0);
        let v4 = DepositReceipt{
            id              : 0x2::object::new(arg3),
            pool_id         : v3,
            slot            : v2,
            principal       : v0,
            deposited_at_ms : v1,
            matures_at_ms   : v1 + arg0.config.maturity_period_ms,
        };
        let v5 = 0x2::object::id<DepositReceipt>(&v4);
        let v6 = SlotInfo{
            beneficiary      : 0x2::tx_context::sender(arg3),
            receipt_id       : v5,
            principal        : v0,
            eligible_from_ms : arg0.epoch_ends_at_ms,
            active           : true,
        };
        0x2::table::add<u64, SlotInfo>(&mut arg0.slots, v2, v6);
        0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::increase(&mut arg0.weights, v2, (v0 as u128));
        arg0.total_principal = arg0.total_principal + v0;
        arg0.active_depositors = arg0.active_depositors + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v7 = DepositMade{
            pool_id          : v3,
            receipt_id       : v5,
            depositor        : 0x2::tx_context::sender(arg3),
            slot             : v2,
            amount           : v0,
            eligible_from_ms : arg0.epoch_ends_at_ms,
            total_principal  : arg0.total_principal,
            timestamp_ms     : v1,
        };
        0x2::event::emit<DepositMade>(v7);
        v4
    }

    public fun deposit_and_keep<T0>(arg0: &mut RafflePool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<DepositReceipt>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun deposits_paused<T0>(arg0: &RafflePool<T0>) : bool {
        arg0.deposits_paused
    }

    public fun early_exit_fee_bps(arg0: &Config) : u64 {
        arg0.early_exit_fee_bps
    }

    fun ensure_liquidity<T0>(arg0: &mut RafflePool<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = arg0.stake_tail - arg0.stake_head;
        while (0x2::balance::value<0x2::sui::SUI>(&arg0.liquid) < arg2 && v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg0.stake_head);
            arg0.stake_head = arg0.stake_head + 1;
            if (0x3::staking_pool::stake_activation_epoch(&v2) > 0x2::tx_context::epoch(arg3)) {
                0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg0.stake_tail, v2);
                arg0.stake_tail = arg0.stake_tail + 1;
                continue
            };
            let v3 = 0x3::staking_pool::staked_sui_amount(&v2);
            let v4 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg3);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v4) >= v3, 10);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3));
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
            arg0.staked_principal = arg0.staked_principal - v3;
        };
        v0
    }

    public fun epoch_duration_ms(arg0: &Config) : u64 {
        arg0.epoch_duration_ms
    }

    public fun epoch_ends_at_ms<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.epoch_ends_at_ms
    }

    public fun epoch_id<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.epoch_id
    }

    entry fun execute_draw<T0>(arg0: &mut RafflePool<T0>, arg1: &OperatorCap, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 9);
        run_draw<T0>(arg0, arg2, arg3, 0x1::option::none<address>(), false, arg4);
    }

    entry fun execute_draw_permissionless<T0>(arg0: &mut RafflePool<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.epoch_ends_at_ms + arg0.config.grace_period_ms, 13);
        let v0 = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        run_draw<T0>(arg0, arg1, arg2, v0, true, arg3);
    }

    fun finalize_withdrawal<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: WithdrawalIntent, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::id<AdminTreasury<T0>>(arg1) == arg0.treasury_id, 8);
        let WithdrawalIntent {
            receipt_id       : v0,
            slot             : v1,
            principal        : v2,
            beneficiary      : v3,
            is_early         : v4,
            principal_before : v5,
            now_ms           : v6,
            liquidity_needed : _,
        } = arg2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.liquid) >= v2, 11);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v9 = 0;
        let v10 = if (v4) {
            if (v8 > 0) {
                v5 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            let v11 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::math::bps_of(0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::math::mul_div_u64(v8, v2, v5), arg0.config.early_exit_fee_bps);
            v9 = v11;
            if (v11 > 0) {
                arg1.lifetime_stream_a = arg1.lifetime_stream_a + v11;
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.stream_a, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v11));
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.prize_sui, arg3);
        let v12 = WithdrawalMade{
            pool_id            : 0x2::object::id<RafflePool<T0>>(arg0),
            receipt_id         : v0,
            beneficiary        : v3,
            slot               : v1,
            principal_returned : v2,
            was_early          : v4,
            early_exit_fee     : v9,
            rewards_to_prize   : 0x2::balance::value<0x2::sui::SUI>(&arg3),
            total_principal    : arg0.total_principal,
            timestamp_ms       : v6,
        };
        0x2::event::emit<WithdrawalMade>(v12);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.liquid, v2, arg4)
    }

    public fun harvest_and_seal<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.phase == 0, 6);
        assert!(0x2::object::id<AdminTreasury<T0>>(arg1) == arg0.treasury_id, 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.epoch_ends_at_ms, 7);
        let v1 = unstake_all_active<T0>(arg0, arg2, arg4);
        let v2 = stakeable_amount<T0>(arg0);
        let v3 = if (v2 >= 1000000000) {
            stake_exact<T0>(arg0, arg2, v2, arg4);
            v2
        } else {
            0
        };
        apply_harvest<T0>(arg0, arg1, v1, v3, v0, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FactoryOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun liquid_balance<T0>(arg0: &RafflePool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.liquid)
    }

    public fun phase<T0>(arg0: &RafflePool<T0>) : u8 {
        arg0.phase
    }

    public fun price_feed_id<T0>(arg0: &RafflePool<T0>) : 0x2::object::ID {
        arg0.price_feed_id
    }

    public fun prize_balance<T0>(arg0: &RafflePool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_sui)
    }

    public fun prize_decimals<T0>(arg0: &RafflePool<T0>) : u8 {
        arg0.prize_decimals
    }

    public fun receipt_matures_at_ms(arg0: &DepositReceipt) : u64 {
        arg0.matures_at_ms
    }

    public fun receipt_pool_id(arg0: &DepositReceipt) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun receipt_principal(arg0: &DepositReceipt) : u64 {
        arg0.principal
    }

    public fun receipt_slot(arg0: &DepositReceipt) : u64 {
        arg0.slot
    }

    fun roll_over<T0>(arg0: &mut RafflePool<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        arg0.phase = 0;
        let v0 = DrawRolledOver{
            pool_id                  : arg1,
            epoch_id                 : arg0.epoch_id,
            carried_prize_sui        : arg2,
            reason_no_eligible_slots : true,
            timestamp_ms             : arg3,
        };
        0x2::event::emit<DrawRolledOver>(v0);
    }

    fun run_draw<T0>(arg0: &mut RafflePool<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<address>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 1, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_sui);
        assert!(v0 > 0, 12);
        assert!(arg0.active_depositors > 0, 19);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::total(&arg0.weights);
        let v3 = 0x2::object::id<RafflePool<T0>>(arg0);
        if (v2 == 0) {
            roll_over<T0>(arg0, v3, v0, v1);
            return
        };
        let v4 = 0x2::random::new_generator(arg1, arg5);
        let v5 = 0;
        let v6 = 0x1::option::none<u64>();
        while (v5 < 12) {
            v5 = v5 + 1;
            let v7 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::find(&arg0.weights, 0x2::random::generate_u128_in_range(&mut v4, 0, v2 - 1));
            let v8 = 0x2::table::borrow<u64, SlotInfo>(&arg0.slots, v7);
            if (!v8.active) {
                continue
            };
            if (v1 < v8.eligible_from_ms) {
                continue
            };
            if (0x1::option::is_some<address>(&arg3) && *0x1::option::borrow<address>(&arg3) == v8.beneficiary) {
            } else {
                v6 = 0x1::option::some<u64>(v7);
                break
            };
        };
        if (0x1::option::is_none<u64>(&v6)) {
            roll_over<T0>(arg0, v3, v0, v1);
            return
        };
        let v9 = 0x1::option::destroy_some<u64>(v6);
        let v10 = 0x2::table::borrow<u64, SlotInfo>(&arg0.slots, v9).beneficiary;
        let v11 = PendingPrize{
            epoch_id    : arg0.epoch_id,
            winner      : v10,
            winner_slot : v9,
            sui_amount  : v0,
        };
        arg0.pending_prize = 0x1::option::some<PendingPrize>(v11);
        arg0.phase = 2;
        let v12 = WinnerSelected{
            pool_id        : v3,
            epoch_id       : arg0.epoch_id,
            winner         : v10,
            winner_slot    : v9,
            winner_weight  : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::weight_at(&arg0.weights, v9),
            total_weight   : v2,
            prize_sui      : v0,
            attempts       : v5,
            permissionless : arg4,
            timestamp_ms   : v1,
        };
        0x2::event::emit<WinnerSelected>(v12);
    }

    public fun set_beneficiary<T0>(arg0: &mut RafflePool<T0>, arg1: &DepositReceipt, arg2: address) {
        assert_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 5);
        let v0 = 0x2::table::borrow_mut<u64, SlotInfo>(&mut arg0.slots, arg1.slot);
        assert!(v0.active, 21);
        v0.beneficiary = arg2;
    }

    public fun set_deposits_paused<T0>(arg0: &mut RafflePool<T0>, arg1: &AdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 9);
        arg0.deposits_paused = arg2;
        let v0 = DepositsPauseToggled{
            pool_id : 0x2::object::id<RafflePool<T0>>(arg0),
            paused  : arg2,
        };
        0x2::event::emit<DepositsPauseToggled>(v0);
    }

    public fun set_price_feed<T0>(arg0: &mut RafflePool<T0>, arg1: &AdminCap, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        assert_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 9);
        arg0.price_feed_id = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2);
    }

    public fun settle_prize<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: SwapTicket, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.phase == 3, 6);
        assert!(0x2::object::id<AdminTreasury<T0>>(arg1) == arg0.treasury_id, 8);
        let SwapTicket {
            pool_id        : v0,
            epoch_id       : v1,
            winner         : v2,
            sui_in         : v3,
            minimum_out    : v4,
            fair_value_out : v5,
            attestation    : v6,
        } = arg2;
        let v7 = v6;
        assert!(v0 == 0x2::object::id<RafflePool<T0>>(arg0), 14);
        let v8 = 0x2::coin::value<T0>(&arg3);
        0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::assert_execution_quality(v8, v4);
        let v9 = 0x2::coin::into_balance<T0>(arg3);
        let v10 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::math::bps_of(v8, arg0.config.spread_bps);
        if (v10 > 0) {
            arg1.lifetime_stream_b = arg1.lifetime_stream_b + v10;
            0x2::balance::join<T0>(&mut arg1.stream_b, 0x2::balance::split<T0>(&mut v9, v10));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg5), v2);
        arg0.pending_prize = 0x1::option::none<PendingPrize>();
        arg0.phase = 0;
        let v11 = PrizeSettled{
            pool_id               : v0,
            epoch_id              : v1,
            winner                : v2,
            sui_converted         : v3,
            oracle_price_1e18     : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::price_1e18(&v7),
            oracle_fair_value_out : v5,
            amm_gross_out         : v8,
            spread_bps            : arg0.config.spread_bps,
            stream_b_fee          : v10,
            winner_payout         : 0x2::balance::value<T0>(&v9),
            realised_slippage_bps : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::realised_slippage_bps(v8, v5),
            timestamp_ms          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PrizeSettled>(v11);
    }

    public fun spread_bps(arg0: &Config) : u64 {
        arg0.spread_bps
    }

    fun stake_exact<T0>(arg0: &mut RafflePool<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg0.stake_tail, 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.liquid, arg2, arg3), arg0.config.validator, arg3));
        arg0.stake_tail = arg0.stake_tail + 1;
        arg0.staked_principal = arg0.staked_principal + arg2;
    }

    public fun stake_liquid<T0>(arg0: &mut RafflePool<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = stakeable_amount<T0>(arg0);
        assert!(v0 >= 1000000000, 18);
        stake_exact<T0>(arg0, arg1, v0, arg2);
    }

    fun stakeable_amount<T0>(arg0: &RafflePool<T0>) : u64 {
        let v0 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::math::bps_of(arg0.total_principal, arg0.config.liquidity_buffer_bps);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.liquid);
        if (v1 <= v0) {
            0
        } else {
            v1 - v0
        }
    }

    public fun staked_principal<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.staked_principal
    }

    public fun staking_fee_bps(arg0: &Config) : u64 {
        arg0.staking_fee_bps
    }

    public fun sweep_treasury<T0>(arg0: &mut AdminTreasury<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == arg0.pool_id, 9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.stream_a) >= arg2, 20);
        assert!(0x2::balance::value<T0>(&arg0.stream_b) >= arg3, 20);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.stream_a, arg2, arg5), arg4);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.stream_b, arg3, arg5), arg4);
        };
        let v0 = TreasurySwept{
            pool_id         : arg0.pool_id,
            treasury_id     : 0x2::object::id<AdminTreasury<T0>>(arg0),
            stream_a_amount : arg2,
            stream_b_amount : arg3,
            recipient       : arg4,
        };
        0x2::event::emit<TreasurySwept>(v0);
    }

    public fun take_prize_sui<T0>(arg0: &mut RafflePool<T0>, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SwapTicket) {
        assert_version<T0>(arg0);
        assert!(arg0.phase == 2, 6);
        assert!(0x1::option::is_some<PendingPrize>(&arg0.pending_prize), 15);
        let v0 = 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::attest(arg1, arg2, arg0.config.max_oracle_age_ms, arg0.config.max_oracle_variance_bps);
        0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::assert_feed(&v0, arg0.price_feed_id);
        let v1 = *0x1::option::borrow<PendingPrize>(&arg0.pending_prize);
        let v2 = v1.sui_amount;
        arg0.phase = 3;
        let v3 = SwapTicket{
            pool_id        : 0x2::object::id<RafflePool<T0>>(arg0),
            epoch_id       : v1.epoch_id,
            winner         : v1.winner,
            sui_in         : v2,
            minimum_out    : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::minimum_acceptable_out(&v0, v2, 9, arg0.prize_decimals, arg0.config.max_slippage_bps),
            fair_value_out : 0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::circuit_breaker::fair_value_out(&v0, v2, 9, arg0.prize_decimals),
            attestation    : v0,
        };
        (0x2::coin::take<0x2::sui::SUI>(&mut arg0.prize_sui, v2, arg3), v3)
    }

    public fun total_principal<T0>(arg0: &RafflePool<T0>) : u64 {
        arg0.total_principal
    }

    public fun total_weight<T0>(arg0: &RafflePool<T0>) : u128 {
        0xab0d4f9c90a0f6d6af082a8aaa64b7cb739f86206e593fcbb7fa0b6a359c4943::fenwick::total(&arg0.weights)
    }

    public fun treasury_lifetime_stream_a<T0>(arg0: &AdminTreasury<T0>) : u64 {
        arg0.lifetime_stream_a
    }

    public fun treasury_lifetime_stream_b<T0>(arg0: &AdminTreasury<T0>) : u64 {
        arg0.lifetime_stream_b
    }

    public fun treasury_stream_a<T0>(arg0: &AdminTreasury<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.stream_a)
    }

    public fun treasury_stream_b<T0>(arg0: &AdminTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stream_b)
    }

    fun unstake_all_active<T0>(arg0: &mut RafflePool<T0>, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = arg0.stake_tail - arg0.stake_head;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x2::table::remove<u64, 0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg0.stake_head);
            arg0.stake_head = arg0.stake_head + 1;
            if (0x3::staking_pool::stake_activation_epoch(&v2) > 0x2::tx_context::epoch(arg2)) {
                0x2::table::add<u64, 0x3::staking_pool::StakedSui>(&mut arg0.stakes, arg0.stake_tail, v2);
                arg0.stake_tail = arg0.stake_tail + 1;
                continue
            };
            let v3 = 0x3::staking_pool::staked_sui_amount(&v2);
            let v4 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, v2, arg2);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v4) >= v3, 10);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3));
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
            arg0.staked_principal = arg0.staked_principal - v3;
        };
        v0
    }

    public fun update_config<T0>(arg0: &mut RafflePool<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::id<RafflePool<T0>>(arg0), 9);
        let v0 = Config{
            staking_fee_bps         : arg2,
            spread_bps              : arg3,
            early_exit_fee_bps      : arg4,
            epoch_duration_ms       : arg5,
            maturity_period_ms      : arg6,
            max_slippage_bps        : arg7,
            max_oracle_age_ms       : arg8,
            max_oracle_variance_bps : arg9,
            grace_period_ms         : arg10,
            min_deposit_mist        : arg11,
            liquidity_buffer_bps    : arg12,
            validator               : arg13,
        };
        assert_config_within_bounds(&v0);
        arg0.config = v0;
        let v1 = ConfigUpdated{
            pool_id      : 0x2::object::id<RafflePool<T0>>(arg0),
            previous     : arg0.config,
            current      : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun validator(arg0: &Config) : address {
        arg0.validator
    }

    public fun withdraw<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: DepositReceipt, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version<T0>(arg0);
        let v0 = begin_withdrawal<T0>(arg0, arg2, arg4);
        let v1 = ensure_liquidity<T0>(arg0, arg3, v0.liquidity_needed, arg5);
        finalize_withdrawal<T0>(arg0, arg1, v0, v1, arg5)
    }

    public fun withdraw_and_keep<T0>(arg0: &mut RafflePool<T0>, arg1: &mut AdminTreasury<T0>, arg2: DepositReceipt, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

