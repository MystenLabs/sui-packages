module 0xa2948da11f30d45b3b9cc3f1c88fc0b51a4104e9d4466d57d58b6a8fa99aeeb6::usdc_vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        idle_funds: 0x2::balance::Balance<T0>,
        total_assets: u64,
        share_token_supply: 0x2::coin::TreasuryCap<T1>,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, StrategyInfo>,
        withdrawal_queue: vector<0x2::object::ID>,
        performance_fee_bps: u64,
        performance_fee_balance: 0x2::balance::Balance<T0>,
        total_fees_collected: u64,
        version: u64,
        paused: bool,
    }

    struct StrategyInfo has store {
        allocated_amount: u64,
        target_allocation_bps: u64,
        max_allocation_bps: u64,
        is_active: bool,
        strategy_type: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultAccess has drop, store {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
    }

    struct RebalanceAmounts has copy, drop {
        strategy_changes: 0x2::vec_map::VecMap<0x2::object::ID, StrategyChange>,
        total_rebalance_amount: u64,
    }

    struct StrategyChange has copy, drop {
        strategy_id: 0x2::object::ID,
        fund_amount: u64,
        defund_amount: u64,
    }

    struct WithdrawReceipt<phantom T0, phantom T1> {
        shares_burned: u64,
        total_expected: u64,
        idle_funds_allocation: u64,
        strategy_allocations: 0x2::vec_map::VecMap<0x2::object::ID, WithdrawAllocation>,
        withdrawn: 0x2::balance::Balance<T0>,
        processed_strategies: 0x2::vec_set::VecSet<0x2::object::ID>,
        initiated_at: u64,
        vault_id: 0x2::object::ID,
    }

    struct WithdrawAllocation has copy, drop, store {
        strategy_id: 0x2::object::ID,
        expected_amount: u64,
        is_processed: bool,
    }

    struct VaultMetrics has copy, drop {
        total_assets: u64,
        current_share_price: u64,
        idle_funds: u64,
        performance_fee_bps: u64,
        version: u64,
        total_strategies: u64,
        active_strategies: u64,
        total_fees_collected: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_minted: u64,
        new_share_price: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount_withdrawn: u64,
        shares_burned: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct PTBWithdrawStarted has copy, drop {
        vault_id: 0x2::object::ID,
        shares_burned: u64,
        total_expected: u64,
        idle_allocation: u64,
        strategy_count: u64,
        timestamp: u64,
    }

    struct PTBWithdrawCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        total_withdrawn: u64,
        expected_amount: u64,
        timestamp: u64,
    }

    struct HarvestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        performance_fee: u64,
        net_profit: u64,
        new_total_assets: u64,
        timestamp: u64,
        share_price: u64,
    }

    struct PerformanceFeeUpdateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
        timestamp: u64,
    }

    struct MigrationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct StrategyAddedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        max_allocation_bps: u64,
        timestamp: u64,
    }

    struct StrategyFundedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        amount: u64,
        new_allocation: u64,
        timestamp: u64,
    }

    struct StrategyDefundedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        amount: u64,
        remaining_allocation: u64,
        timestamp: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 17);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                      : v0,
            idle_funds              : 0x2::balance::zero<T0>(),
            total_assets            : 0,
            share_token_supply      : arg0,
            strategies              : 0x2::vec_map::empty<0x2::object::ID, StrategyInfo>(),
            withdrawal_queue        : 0x1::vector::empty<0x2::object::ID>(),
            performance_fee_bps     : 0,
            performance_fee_balance : 0x2::balance::zero<T0>(),
            total_fees_collected    : 0,
            version                 : 1,
            paused                  : false,
        };
        let v3 = AdminCap{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
        };
        let v4 = VaultCreated{
            vault_id     : v1,
            admin_cap_id : 0x2::object::id<AdminCap>(&v3),
            timestamp    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<Vault<T0, T1>>(v2);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun add_strategy<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VaultAccess {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(arg4 <= 10000, 8);
        assert!(!0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 14);
        let v0 = StrategyInfo{
            allocated_amount      : 0,
            target_allocation_bps : 0,
            max_allocation_bps    : arg4,
            is_active             : true,
            strategy_type         : arg3,
        };
        0x2::vec_map::insert<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, arg2, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.withdrawal_queue, arg2);
        let v1 = StrategyAddedEvent{
            vault_id           : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id        : arg2,
            max_allocation_bps : arg4,
            timestamp          : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<StrategyAddedEvent>(v1);
        VaultAccess{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id : arg2,
        }
    }

    fun assert_not_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.paused, 7);
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 1, 12);
    }

    public fun calc_rebalance_amounts<T0, T1>(arg0: &Vault<T0, T1>) : RebalanceAmounts {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, StrategyChange>();
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0x2::object::ID, StrategyInfo>(&arg0.strategies);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&v2, v3);
            let v5 = 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, &v4);
            if (v5.is_active) {
                let v6 = muldiv(arg0.total_assets, v5.target_allocation_bps, 10000);
                let v7 = v5.allocated_amount;
                let (v8, v9) = if (v6 > v7) {
                    (v6 - v7, 0)
                } else if (v7 > v6) {
                    (0, v7 - v6)
                } else {
                    (0, 0)
                };
                if (v8 > 0 || v9 > 0) {
                    let v10 = StrategyChange{
                        strategy_id   : v4,
                        fund_amount   : v8,
                        defund_amount : v9,
                    };
                    0x2::vec_map::insert<0x2::object::ID, StrategyChange>(&mut v0, v4, v10);
                    let v11 = v1 + v8;
                    v1 = v11 + v9;
                };
            };
            v3 = v3 + 1;
        };
        RebalanceAmounts{
            strategy_changes       : v0,
            total_rebalance_amount : v1,
        }
    }

    public fun calculate_current_share_price<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x2::coin::total_supply<T1>(&arg0.share_token_supply);
        if (v0 == 0 || arg0.total_assets == 0) {
            10000
        } else {
            muldiv(arg0.total_assets, 10000, v0)
        }
    }

    fun calculate_withdrawal_allocations<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (u64, 0x2::vec_map::VecMap<0x2::object::ID, WithdrawAllocation>) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, WithdrawAllocation>();
        let v1 = min(arg1, 0x2::balance::value<T0>(&arg0.idle_funds));
        let v2 = arg1 - v1;
        if (v2 == 0) {
            return (v1, v0)
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg0.withdrawal_queue) && v2 > 0) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg0.withdrawal_queue, v3);
            let v5 = 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, &v4);
            if (v5.is_active && v5.allocated_amount > 0) {
                let v6 = min(v2, v5.allocated_amount);
                if (v6 > 0) {
                    let v7 = WithdrawAllocation{
                        strategy_id     : v4,
                        expected_amount : v6,
                        is_processed    : false,
                    };
                    0x2::vec_map::insert<0x2::object::ID, WithdrawAllocation>(&mut v0, v4, v7);
                    v2 = v2 - v6;
                };
            };
            v3 = v3 + 1;
        };
        (v1, v0)
    }

    public fun complete_ptb_withdrawal<T0, T1>(arg0: &Vault<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        validate_vault_operational<T0, T1>(arg0);
        let WithdrawReceipt {
            shares_burned         : v0,
            total_expected        : v1,
            idle_funds_allocation : v2,
            strategy_allocations  : v3,
            withdrawn             : v4,
            processed_strategies  : _,
            initiated_at          : _,
            vault_id              : v7,
        } = arg1;
        let v8 = v4;
        let v9 = v3;
        assert!(v7 == 0x2::object::id<Vault<T0, T1>>(arg0), 19);
        assert!(v2 == 0, 20);
        let v10 = 0;
        let v11 = 0x2::vec_map::keys<0x2::object::ID, WithdrawAllocation>(&v9);
        while (v10 < 0x1::vector::length<0x2::object::ID>(&v11)) {
            let v12 = *0x1::vector::borrow<0x2::object::ID>(&v11, v10);
            let v13 = 0x2::vec_map::get<0x2::object::ID, WithdrawAllocation>(&v9, &v12);
            if (v13.expected_amount > 0) {
                assert!(v13.is_processed, 20);
            };
            v10 = v10 + 1;
        };
        let v14 = 0x2::balance::value<T0>(&v8);
        let v15 = PTBWithdrawCompleted{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            total_withdrawn : v14,
            expected_amount : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBWithdrawCompleted>(v15);
        let v16 = WithdrawEvent{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
            user             : @0x0,
            amount_withdrawn : v14,
            shares_burned    : v0,
            share_price      : calculate_current_share_price<T0, T1>(arg0),
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v16);
        v8
    }

    fun count_active_strategies<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, StrategyInfo>(&arg0.strategies);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            if (0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, &v3).is_active) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun defund_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        validate_vault_operational<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 12);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 1);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::object::id<Vault<T0, T1>>(arg0);
        let v2 = arg1.strategy_id;
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &v2);
        let v4 = v3.allocated_amount;
        let v5 = min(arg3, v4);
        let v6 = 0;
        let v7 = 0;
        let v8 = if (v5 == v4) {
            v4
        } else {
            v5
        };
        if (v0 > v8) {
            let v9 = v0 - v8;
            let v10 = muldiv(v9, arg0.performance_fee_bps, 10000);
            v6 = v10;
            if (v10 > 0) {
                0x2::balance::join<T0>(&mut arg0.performance_fee_balance, 0x2::balance::split<T0>(&mut arg2, v10));
                arg0.total_fees_collected = arg0.total_fees_collected + v10;
            };
            let v11 = v9 - v10;
            v7 = v11;
            v3.allocated_amount = v4 - v5;
            arg0.total_assets = arg0.total_assets + v11;
        } else if (v0 < v8) {
            v3.allocated_amount = v4 - v0;
            arg0.total_assets = arg0.total_assets - v8 - v0;
        } else {
            v3.allocated_amount = v4 - v5;
        };
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg2);
        if (v7 > 0) {
            let v12 = HarvestEvent{
                vault_id         : v1,
                performance_fee  : v6,
                net_profit       : v7,
                new_total_assets : arg0.total_assets,
                timestamp        : 0x2::clock::timestamp_ms(arg4),
                share_price      : calculate_current_share_price<T0, T1>(arg0),
            };
            0x2::event::emit<HarvestEvent>(v12);
        };
        let v13 = StrategyDefundedEvent{
            vault_id             : v1,
            strategy_id          : v2,
            amount               : v0,
            remaining_allocation : v3.allocated_amount,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyDefundedEvent>(v13);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate_vault_operational<T0, T1>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 16);
        let v1 = muldiv(v0, 10000, calculate_current_share_price<T0, T1>(arg0));
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg1);
        arg0.total_assets = arg0.total_assets + v0;
        let v2 = DepositEvent{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            user            : 0x2::tx_context::sender(arg3),
            amount          : v0,
            shares_minted   : v1,
            new_share_price : calculate_current_share_price<T0, T1>(arg0),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v2);
        0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(&mut arg0.share_token_supply, v1, arg3))
    }

    public fun fund_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        validate_vault_operational<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 12);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 1);
        let v0 = min(arg2, 0x2::balance::value<T0>(&arg0.idle_funds));
        assert!(v0 > 0, 5);
        let v1 = arg1.strategy_id;
        let v2 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &v1);
        v2.allocated_amount = v2.allocated_amount + v0;
        let v3 = StrategyFundedEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            strategy_id    : v1,
            amount         : v0,
            new_allocation : v2.allocated_amount,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyFundedEvent>(v3);
        0x2::balance::split<T0>(&mut arg0.idle_funds, v0)
    }

    public fun get_strategy_allocation_from_receipt<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID) : u64 {
        if (0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1)) {
            let v1 = 0x2::vec_map::get<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1);
            if (!v1.is_processed) {
                v1.expected_amount
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_vault_performance<T0, T1>(arg0: &Vault<T0, T1>) : VaultMetrics {
        VaultMetrics{
            total_assets         : arg0.total_assets,
            current_share_price  : calculate_current_share_price<T0, T1>(arg0),
            idle_funds           : 0x2::balance::value<T0>(&arg0.idle_funds),
            performance_fee_bps  : arg0.performance_fee_bps,
            version              : arg0.version,
            total_strategies     : 0x2::vec_map::size<0x2::object::ID, StrategyInfo>(&arg0.strategies),
            active_strategies    : count_active_strategies<T0, T1>(arg0),
            total_fees_collected : arg0.total_fees_collected,
        }
    }

    public fun get_vault_summary<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (arg0.total_assets, calculate_current_share_price<T0, T1>(arg0), 0x2::balance::value<T0>(&arg0.idle_funds))
    }

    public fun get_withdrawn_amount<T0, T1>(arg0: &WithdrawReceipt<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.withdrawn)
    }

    public fun idle_funds_value<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_funds)
    }

    public fun is_strategy_allocated_in_receipt<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1)
    }

    public fun is_strategy_processed<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.processed_strategies, &arg1)
    }

    entry fun migrate<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
        let v0 = MigrationEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            old_version : arg1.version,
            new_version : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MigrationEvent>(v0);
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg2 == 0) {
            abort 8
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun rebalance_amounts_get(arg0: &RebalanceAmounts, arg1: &VaultAccess) : (u64, u64) {
        let v0 = arg1.strategy_id;
        if (0x2::vec_map::contains<0x2::object::ID, StrategyChange>(&arg0.strategy_changes, &v0)) {
            let v3 = 0x2::vec_map::get<0x2::object::ID, StrategyChange>(&arg0.strategy_changes, &v0);
            (v3.fund_amount, v3.defund_amount)
        } else {
            (0, 0)
        }
    }

    public fun set_performance_fee_bps<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(arg2 <= 2000, 9);
        arg1.performance_fee_bps = arg2;
        let v0 = PerformanceFeeUpdateEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            old_fee_bps : arg1.performance_fee_bps,
            new_fee_bps : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PerformanceFeeUpdateEvent>(v0);
    }

    public fun set_target_allocation<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: u64) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, &arg2);
        assert!(arg3 <= v0.max_allocation_bps, 15);
        v0.target_allocation_bps = arg3;
    }

    public fun start_ptb_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        validate_vault_operational<T0, T1>(arg0);
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert!(v0 > 0, 16);
        let v1 = min(muldiv(v0, calculate_current_share_price<T0, T1>(arg0), 10000), arg0.total_assets);
        0x2::coin::burn<T1>(&mut arg0.share_token_supply, 0x2::coin::from_balance<T1>(arg1, arg3));
        arg0.total_assets = arg0.total_assets - v1;
        let (v2, v3) = calculate_withdrawal_allocations<T0, T1>(arg0, v1);
        let v4 = WithdrawReceipt<T0, T1>{
            shares_burned         : v0,
            total_expected        : v1,
            idle_funds_allocation : v2,
            strategy_allocations  : v3,
            withdrawn             : 0x2::balance::zero<T0>(),
            processed_strategies  : 0x2::vec_set::empty<0x2::object::ID>(),
            initiated_at          : 0x2::clock::timestamp_ms(arg2),
            vault_id              : 0x2::object::id<Vault<T0, T1>>(arg0),
        };
        let v5 = PTBWithdrawStarted{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            shares_burned   : v0,
            total_expected  : v1,
            idle_allocation : v2,
            strategy_count  : 0x2::vec_map::size<0x2::object::ID, WithdrawAllocation>(&v4.strategy_allocations),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBWithdrawStarted>(v5);
        v4
    }

    public fun strategy_info<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::object::ID) : &StrategyInfo {
        0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, arg1)
    }

    public fun strategy_needs_processing<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1) && !0x2::vec_set::contains<0x2::object::ID>(&arg0.processed_strategies, &arg1)
    }

    public fun total_assets<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_assets
    }

    public fun update_receipt_after_strategy_withdrawal<T0, T1>(arg0: &mut WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        if (!0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1)) {
            assert!(0x2::balance::value<T0>(&arg2) == 0, 21);
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.processed_strategies, &arg1), 22);
        0x2::balance::join<T0>(&mut arg0.withdrawn, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.processed_strategies, arg1);
        0x2::vec_map::get_mut<0x2::object::ID, WithdrawAllocation>(&mut arg0.strategy_allocations, &arg1).is_processed = true;
    }

    public fun update_strategy_allocation_after_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1), 1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &arg1);
        v0.allocated_amount = v0.allocated_amount - min(arg2, v0.allocated_amount);
    }

    fun validate_admin_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 13);
    }

    fun validate_vault_operational<T0, T1>(arg0: &Vault<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Vault<T0, T1>>(arg0)
    }

    public fun withdraw_from_idle_funds<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut WithdrawReceipt<T0, T1>) {
        validate_vault_operational<T0, T1>(arg0);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 19);
        let v0 = arg1.idle_funds_allocation;
        if (v0 == 0) {
            return
        };
        let v1 = min(v0, 0x2::balance::value<T0>(&arg0.idle_funds));
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg1.withdrawn, 0x2::balance::split<T0>(&mut arg0.idle_funds, v1));
        };
        arg1.idle_funds_allocation = 0;
    }

    public fun withdraw_performance_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(0x2::balance::value<T0>(&arg1.performance_fee_balance) >= arg2, 10);
        0x2::balance::split<T0>(&mut arg1.performance_fee_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

