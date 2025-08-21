module 0x9abd70f8de96337fb071240b9a2b9018c0c4a3b18bf6abb9659ed51ae3832f0c::usdc_vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        idle_funds: 0x2::balance::Balance<T0>,
        total_assets: u64,
        share_token_supply: 0x2::coin::TreasuryCap<T1>,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, StrategyInfo>,
        withdrawal_queue: vector<0x2::object::ID>,
        version: u64,
        paused: bool,
        management_fee_bps: u64,
        last_management_fee_collection_timestamp: u64,
    }

    struct StrategyInfo has drop, store {
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

    struct VaultMetrics has copy, drop {
        total_assets: u64,
        current_share_price: u64,
        idle_funds: u64,
        management_fee_bps: u64,
        version: u64,
        total_strategies: u64,
        active_strategies: u64,
        last_management_fee_collection_timestamp: u64,
        paused: bool,
    }

    struct VaultInvariantValidated has copy, drop {
        vault_id: 0x2::object::ID,
        total_assets: u64,
        calculated_assets: u64,
    }

    struct WithdrawReceipt<phantom T0, phantom T1> {
        shares_remaining: 0x2::balance::Balance<T1>,
        total_expected: u64,
        idle_funds_allocation: u64,
        strategy_allocations: 0x2::vec_map::VecMap<0x2::object::ID, WithdrawAllocation>,
        withdrawn: 0x2::balance::Balance<T0>,
        processed_strategies: 0x2::vec_set::VecSet<0x2::object::ID>,
        initiated_at: u64,
        vault_id: 0x2::object::ID,
        user: address,
        min_amount_out: u64,
        current_share_price: u64,
    }

    struct WithdrawAllocation has copy, drop, store {
        strategy_id: 0x2::object::ID,
        expected_amount: u64,
        is_processed: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ManagementFeeRateUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_bps: u64,
        new_fee_bps: u64,
        timestamp: u64,
    }

    struct StrategyAddedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        max_allocation_bps: u64,
        timestamp: u64,
    }

    struct TargetAllocationUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        old_allocation_bps: u64,
        new_allocation_bps: u64,
        total_allocation_bps: u64,
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

    struct StrategyDefundedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        amount: u64,
        remaining_allocation: u64,
        timestamp: u64,
    }

    struct StrategyFundedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        amount: u64,
        new_allocation: u64,
        timestamp: u64,
    }

    struct StrategyDeactivatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyReactivatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyRemovedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        was_in_withdrawal_queue: bool,
        timestamp: u64,
    }

    struct MigrationEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct VaultPausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct VaultUnpausedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    struct ManagementFeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        fee_amount_usdc: u64,
        fee_shares_minted: u64,
        time_period_seconds: u64,
        recipient: address,
        timestamp: u64,
    }

    struct PTBWithdrawStarted has copy, drop {
        vault_id: 0x2::object::ID,
        shares_to_burn: u64,
        total_expected: u64,
        idle_allocation: u64,
        strategy_count: u64,
        timestamp: u64,
    }

    struct PTBWithdrawCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        total_withdrawn: u64,
        expected_amount: u64,
        user: address,
        shares_burned: u64,
        share_price: u64,
        timestamp: u64,
    }

    struct EmergencyDefundEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        returned_amount: u64,
        previous_allocation: u64,
        timestamp: u64,
    }

    struct StrategyProfitRecognized has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        profit_amount: u64,
        timestamp: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 1);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Vault<T0, T1>{
            id                                       : v0,
            idle_funds                               : 0x2::balance::zero<T0>(),
            total_assets                             : 0,
            share_token_supply                       : arg0,
            strategies                               : 0x2::vec_map::empty<0x2::object::ID, StrategyInfo>(),
            withdrawal_queue                         : 0x1::vector::empty<0x2::object::ID>(),
            version                                  : 1,
            paused                                   : false,
            management_fee_bps                       : 0,
            last_management_fee_collection_timestamp : 0x2::clock::timestamp_ms(arg1) / 60000,
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

    public fun add_strategy<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) : VaultAccess {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(arg4 <= 10000, 6);
        assert!(!0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 7);
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

    public fun add_strategy_profit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 8);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg2);
        arg0.total_assets = arg0.total_assets + v0;
        validate_vault_invariants<T0, T1>(arg0);
        let v1 = StrategyProfitRecognized{
            vault_id      : 0x2::object::id<Vault<T0, T1>>(arg0),
            strategy_id   : arg1.strategy_id,
            profit_amount : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyProfitRecognized>(v1);
    }

    fun assert_not_paused<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(!arg0.paused, 5);
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 1, 4);
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

    public fun calculate_pending_management_fee<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : (u64, u64) {
        if (arg0.management_fee_bps == 0) {
            return (0, 0)
        };
        let v0 = muldiv(muldiv(arg0.total_assets, arg0.management_fee_bps, 10000), 0x2::clock::timestamp_ms(arg1) / 60000 - arg0.last_management_fee_collection_timestamp, 525600);
        if (v0 == 0) {
            return (0, 0)
        };
        (v0, muldiv(v0, 10000, calculate_current_share_price<T0, T1>(arg0)))
    }

    fun calculate_total_allocated_assets<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, StrategyInfo>(&arg0.strategies);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            v1 = v1 + 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, &v3).allocated_amount;
            v2 = v2 + 1;
        };
        v1
    }

    fun calculate_total_target_allocations<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, StrategyInfo>(&arg0.strategies);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v2);
            let v4 = 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg0.strategies, &v3);
            if (v4.is_active) {
                v1 = v1 + v4.target_allocation_bps;
            };
            v2 = v2 + 1;
        };
        v1
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

    public fun collect_management_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        if (arg1.management_fee_bps == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg3) / 60000;
        let v1 = v0 - arg1.last_management_fee_collection_timestamp;
        let v2 = muldiv(muldiv(arg1.total_assets, arg1.management_fee_bps, 10000), v1, 525600);
        if (v2 == 0) {
            arg1.last_management_fee_collection_timestamp = v0;
            return
        };
        let v3 = muldiv(v2, 10000, calculate_current_share_price<T0, T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::mint<T1>(&mut arg1.share_token_supply, v3, arg4), arg2);
        arg1.last_management_fee_collection_timestamp = v0;
        validate_vault_invariants<T0, T1>(arg1);
        let v4 = ManagementFeeCollected{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg1),
            fee_amount_usdc     : v2,
            fee_shares_minted   : v3,
            time_period_seconds : v1,
            recipient           : arg2,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ManagementFeeCollected>(v4);
    }

    public fun complete_ptb_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: WithdrawReceipt<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_version<T0, T1>(arg0);
        let WithdrawReceipt {
            shares_remaining      : v0,
            total_expected        : v1,
            idle_funds_allocation : v2,
            strategy_allocations  : v3,
            withdrawn             : v4,
            processed_strategies  : _,
            initiated_at          : _,
            vault_id              : v7,
            user                  : v8,
            min_amount_out        : v9,
            current_share_price   : v10,
        } = arg1;
        let v11 = v4;
        let v12 = v3;
        let v13 = v0;
        assert!(v7 == 0x2::object::id<Vault<T0, T1>>(arg0), 20);
        assert!(v2 == 0, 26);
        let v14 = 0;
        let v15 = 0x2::vec_map::keys<0x2::object::ID, WithdrawAllocation>(&v12);
        while (v14 < 0x1::vector::length<0x2::object::ID>(&v15)) {
            let v16 = *0x1::vector::borrow<0x2::object::ID>(&v15, v14);
            let v17 = 0x2::vec_map::get<0x2::object::ID, WithdrawAllocation>(&v12, &v16);
            if (v17.expected_amount > 0) {
                assert!(v17.is_processed, 26);
            };
            v14 = v14 + 1;
        };
        if (0x2::balance::value<T1>(&v13) > 0) {
            0x2::coin::burn<T1>(&mut arg0.share_token_supply, 0x2::coin::from_balance<T1>(v13, arg3));
        } else {
            0x2::balance::destroy_zero<T1>(v13);
        };
        let v18 = 0x2::balance::value<T0>(&v11);
        assert!(v18 >= v9, 27);
        validate_vault_invariants<T0, T1>(arg0);
        let v19 = PTBWithdrawCompleted{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            total_withdrawn : v18,
            expected_amount : v1,
            user            : v8,
            shares_burned   : muldiv(v1, 10000, v10),
            share_price     : calculate_current_share_price<T0, T1>(arg0),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBWithdrawCompleted>(v19);
        v11
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

    public fun deactivate_strategy<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 8);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, &arg2);
        assert!(v0.is_active, 28);
        assert!(v0.allocated_amount == 0, 29);
        v0.is_active = false;
        v0.target_allocation_bps = 0;
        validate_vault_invariants<T0, T1>(arg1);
        let v1 = StrategyDeactivatedEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyDeactivatedEvent>(v1);
    }

    public fun defund_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 8);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = arg1.strategy_id;
        assert!(v0 >= arg3 - muldiv(arg3, 2, 10000), 13);
        let v2 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &v1);
        v2.allocated_amount = v2.allocated_amount - arg3;
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg2);
        arg0.total_assets = arg0.total_assets + v0 - arg3;
        validate_vault_invariants<T0, T1>(arg0);
        let v3 = StrategyDefundedEvent{
            vault_id             : 0x2::object::id<Vault<T0, T1>>(arg0),
            strategy_id          : v1,
            amount               : v0,
            remaining_allocation : v2.allocated_amount,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyDefundedEvent>(v3);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        validate_vault_operational<T0, T1>(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= 1000000, 10);
        let v1 = muldiv(v0, 10000, calculate_current_share_price<T0, T1>(arg0));
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg1);
        arg0.total_assets = arg0.total_assets + v0;
        validate_vault_invariants<T0, T1>(arg0);
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

    public fun emergency_defund_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 8);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = arg1.strategy_id;
        0x2::balance::join<T0>(&mut arg0.idle_funds, arg2);
        let v2 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &v1);
        let v3 = v2.allocated_amount;
        v2.allocated_amount = 0;
        if (v0 > v3) {
            arg0.total_assets = arg0.total_assets + v0 - v3;
        } else if (v0 < v3) {
            arg0.total_assets = arg0.total_assets - v3 - v0;
        };
        let v4 = EmergencyDefundEvent{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg0),
            strategy_id         : v1,
            returned_amount     : v0,
            previous_allocation : v3,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EmergencyDefundEvent>(v4);
    }

    fun find_strategy_in_withdrawal_queue<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.withdrawal_queue)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.withdrawal_queue, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun fund_strategy<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        validate_vault_operational<T0, T1>(arg0);
        assert!(0x2::object::id<Vault<T0, T1>>(arg0) == arg1.vault_id, 32);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1.strategy_id), 8);
        assert!(0x2::balance::value<T0>(&arg0.idle_funds) >= arg2, 15);
        assert!(arg2 > 0, 16);
        let v0 = arg1.strategy_id;
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &v0);
        let v2 = v1.allocated_amount + arg2;
        assert!(v2 <= muldiv(arg0.total_assets, v1.max_allocation_bps, 10000), 17);
        v1.allocated_amount = v2;
        let v3 = StrategyFundedEvent{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            strategy_id    : v0,
            amount         : arg2,
            new_allocation : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyFundedEvent>(v3);
        validate_vault_invariants<T0, T1>(arg0);
        0x2::balance::split<T0>(&mut arg0.idle_funds, arg2)
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
            total_assets                             : arg0.total_assets,
            current_share_price                      : calculate_current_share_price<T0, T1>(arg0),
            idle_funds                               : 0x2::balance::value<T0>(&arg0.idle_funds),
            management_fee_bps                       : arg0.management_fee_bps,
            version                                  : arg0.version,
            total_strategies                         : 0x2::vec_map::size<0x2::object::ID, StrategyInfo>(&arg0.strategies),
            active_strategies                        : count_active_strategies<T0, T1>(arg0),
            last_management_fee_collection_timestamp : arg0.last_management_fee_collection_timestamp,
            paused                                   : arg0.paused,
        }
    }

    public fun get_vault_summary<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64) {
        (arg0.total_assets, calculate_current_share_price<T0, T1>(arg0), 0x2::balance::value<T0>(&arg0.idle_funds))
    }

    public fun is_strategy_allocated_in_receipt<T0, T1>(arg0: &WithdrawReceipt<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg0.strategy_allocations, &arg1)
    }

    public fun migrate<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert!(arg1.version < 1, 29);
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
            abort 6
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun pause_vault<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg1);
        assert!(!arg1.paused, 30);
        arg1.paused = true;
        let v0 = VaultPausedEvent{
            vault_id  : 0x2::object::id<Vault<T0, T1>>(arg1),
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultPausedEvent>(v0);
    }

    public fun reactivate_strategy<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 8);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, &arg2);
        assert!(!v0.is_active, 7);
        v0.is_active = true;
        validate_vault_invariants<T0, T1>(arg1);
        let v1 = StrategyReactivatedEvent{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyReactivatedEvent>(v1);
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

    public fun remove_strategy<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 8);
        let v0 = 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2);
        assert!(!v0.is_active, 28);
        assert!(v0.allocated_amount == 0, 29);
        let (v1, v2) = find_strategy_in_withdrawal_queue<T0, T1>(arg1, arg2);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.withdrawal_queue, v2);
        };
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, &arg2);
        validate_vault_invariants<T0, T1>(arg1);
        let v5 = StrategyRemovedEvent{
            vault_id                : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id             : arg2,
            was_in_withdrawal_queue : v1,
            timestamp               : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StrategyRemovedEvent>(v5);
    }

    public fun set_management_fee_rate<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(arg2 <= 300, 2);
        let v0 = arg1.management_fee_bps;
        arg1.management_fee_bps = arg2;
        if (v0 != arg2) {
            arg1.last_management_fee_collection_timestamp = 0x2::clock::timestamp_ms(arg3) / 60000;
        };
        let v1 = ManagementFeeRateUpdated{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg1),
            old_fee_bps : v0,
            new_fee_bps : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ManagementFeeRateUpdated>(v1);
    }

    public fun set_target_allocation<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        validate_vault_operational<T0, T1>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2), 8);
        let v0 = 0x2::vec_map::get<0x2::object::ID, StrategyInfo>(&arg1.strategies, &arg2);
        assert!(arg3 <= v0.max_allocation_bps, 8);
        let v1 = v0.target_allocation_bps;
        let v2 = calculate_total_target_allocations<T0, T1>(arg1) - v1 + arg3;
        assert!(v2 <= 10000, 9);
        0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg1.strategies, &arg2).target_allocation_bps = arg3;
        let v3 = TargetAllocationUpdated{
            vault_id             : 0x2::object::id<Vault<T0, T1>>(arg1),
            strategy_id          : arg2,
            old_allocation_bps   : v1,
            new_allocation_bps   : arg3,
            total_allocation_bps : v2,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TargetAllocationUpdated>(v3);
    }

    public fun start_ptb_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : WithdrawReceipt<T0, T1> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert!(v0 > 0, 16);
        let v1 = calculate_current_share_price<T0, T1>(arg0);
        let v2 = muldiv(v0, v1, 10000);
        assert!(v2 <= arg0.total_assets, 18);
        assert!(v2 >= arg3, 19);
        let (v3, v4) = calculate_withdrawal_allocations<T0, T1>(arg0, v2);
        let v5 = WithdrawReceipt<T0, T1>{
            shares_remaining      : arg1,
            total_expected        : v2,
            idle_funds_allocation : v3,
            strategy_allocations  : v4,
            withdrawn             : 0x2::balance::zero<T0>(),
            processed_strategies  : 0x2::vec_set::empty<0x2::object::ID>(),
            initiated_at          : 0x2::clock::timestamp_ms(arg2),
            vault_id              : 0x2::object::id<Vault<T0, T1>>(arg0),
            user                  : 0x2::tx_context::sender(arg4),
            min_amount_out        : arg3,
            current_share_price   : v1,
        };
        let v6 = PTBWithdrawStarted{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            shares_to_burn  : v0,
            total_expected  : v2,
            idle_allocation : v3,
            strategy_count  : 0x2::vec_map::size<0x2::object::ID, WithdrawAllocation>(&v5.strategy_allocations),
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PTBWithdrawStarted>(v6);
        v5
    }

    public fun unpause_vault<T0, T1>(arg0: &AdminCap, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        validate_admin_cap<T0, T1>(arg1, arg0);
        assert_version<T0, T1>(arg1);
        assert!(arg1.paused, 31);
        arg1.paused = false;
        let v0 = VaultUnpausedEvent{
            vault_id  : 0x2::object::id<Vault<T0, T1>>(arg1),
            admin     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultUnpausedEvent>(v0);
    }

    public fun update_receipt_after_strategy_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut WithdrawReceipt<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_map::contains<0x2::object::ID, WithdrawAllocation>(&arg1.strategy_allocations, &arg2)) {
            assert!(0x2::balance::value<T0>(&arg3) == 0, 22);
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg1.processed_strategies, &arg2), 23);
        let v0 = 0x2::vec_map::get<0x2::object::ID, WithdrawAllocation>(&arg1.strategy_allocations, &arg2);
        assert!(0x2::balance::value<T0>(&arg3) >= v0.expected_amount - muldiv(v0.expected_amount, 2, 10000), 24);
        0x2::coin::burn<T1>(&mut arg0.share_token_supply, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.shares_remaining, muldiv(v0.expected_amount, 10000, arg1.current_share_price)), arg4));
        arg0.total_assets = arg0.total_assets - v0.expected_amount;
        update_strategy_allocation_after_withdrawal<T0, T1>(arg0, arg2, v0.expected_amount);
        0x2::balance::join<T0>(&mut arg1.withdrawn, arg3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.processed_strategies, arg2);
        0x2::vec_map::get_mut<0x2::object::ID, WithdrawAllocation>(&mut arg1.strategy_allocations, &arg2).is_processed = true;
        validate_vault_invariants<T0, T1>(arg0);
    }

    fun update_strategy_allocation_after_withdrawal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyInfo>(&arg0.strategies, &arg1), 8);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyInfo>(&mut arg0.strategies, &arg1);
        assert!(arg2 <= v0.allocated_amount, 25);
        v0.allocated_amount = v0.allocated_amount - arg2;
    }

    fun validate_admin_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 3);
    }

    fun validate_vault_invariants<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(calculate_total_allocated_assets<T0, T1>(arg0) + 0x2::balance::value<T0>(&arg0.idle_funds) == arg0.total_assets, 11);
        let v0 = VaultInvariantValidated{
            vault_id          : 0x2::object::id<Vault<T0, T1>>(arg0),
            total_assets      : arg0.total_assets,
            calculated_assets : muldiv(0x2::coin::total_supply<T1>(&arg0.share_token_supply), calculate_current_share_price<T0, T1>(arg0), 10000),
        };
        0x2::event::emit<VaultInvariantValidated>(v0);
    }

    fun validate_vault_operational<T0, T1>(arg0: &Vault<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_not_paused<T0, T1>(arg0);
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Vault<T0, T1>>(arg0)
    }

    public fun withdraw_from_idle_funds<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut WithdrawReceipt<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version<T0, T1>(arg0);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 20);
        let v0 = arg1.idle_funds_allocation;
        if (v0 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.idle_funds) >= v0, 21);
        0x2::coin::burn<T1>(&mut arg0.share_token_supply, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.shares_remaining, muldiv(v0, 10000, arg1.current_share_price)), arg2));
        arg0.total_assets = arg0.total_assets - v0;
        0x2::balance::join<T0>(&mut arg1.withdrawn, 0x2::balance::split<T0>(&mut arg0.idle_funds, v0));
        arg1.idle_funds_allocation = 0;
        validate_vault_invariants<T0, T1>(arg0);
    }

    // decompiled from Move bytecode v6
}

