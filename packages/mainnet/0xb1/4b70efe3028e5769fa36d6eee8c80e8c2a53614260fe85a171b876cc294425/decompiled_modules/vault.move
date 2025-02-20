module 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::vault {
    struct DepositEvent<phantom T0> has copy, drop {
        amount: u64,
        lp_minted: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        amount: u64,
        lp_burned: u64,
    }

    struct StrategyProfitEvent<phantom T0> has copy, drop {
        strategy_id: 0x2::object::ID,
        profit: u64,
        fee_amt_yt: u64,
    }

    struct StrategyLossEvent<phantom T0> has copy, drop {
        strategy_id: 0x2::object::ID,
        to_withdraw: u64,
        withdrawn: u64,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct VaultAccess has store, key {
        id: 0x2::object::UID,
    }

    struct StrategyRemovalTicket<phantom T0, phantom T1> {
        access: VaultAccess,
        returned_balance: 0x2::balance::Balance<T0>,
    }

    struct StrategyWithdrawInfo<phantom T0> has store {
        to_withdraw: u64,
        withdrawn_balance: 0x2::balance::Balance<T0>,
        has_withdrawn: bool,
    }

    struct WithdrawTicket<phantom T0, phantom T1> {
        to_withdraw_from_free_balance: u64,
        strategy_infos: 0x2::vec_map::VecMap<0x2::object::ID, StrategyWithdrawInfo<T0>>,
        lp_to_burn: 0x2::balance::Balance<T1>,
    }

    struct RebalanceInfo has copy, drop, store {
        to_repay: u64,
        can_borrow: u64,
    }

    struct RebalanceAmounts has copy, drop {
        inner: 0x2::vec_map::VecMap<0x2::object::ID, RebalanceInfo>,
    }

    struct StrategyState has store {
        borrowed: u64,
        target_alloc_weight_bps: u64,
        max_borrow: 0x1::option::Option<u64>,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        free_balance: 0x2::balance::Balance<T0>,
        time_locked_profit: 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::TimeLockedBalance<T0>,
        lp_treasury: 0x2::coin::TreasuryCap<T1>,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, StrategyState>,
        performance_fee_balance: 0x2::balance::Balance<T1>,
        strategy_withdraw_priority_order: vector<0x2::object::ID>,
        withdraw_ticket_issued: bool,
        tvl_cap: 0x1::option::Option<u64>,
        profit_unlock_duration_sec: u64,
        performance_fee_bps: u64,
        total_allocated_bps: u64,
    }

    struct FlashLoanReceitp<phantom T0, phantom T1> {
        access: 0x2::object::ID,
        loan_amount: u64,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (AdminCap<T1>, Vault<T0, T1>) {
        assert!(0x2::coin::total_supply<T1>(&arg0) == 0, 10);
        assert!(arg2 <= 10000 && arg3 <= 10000, 0);
        let v0 = Vault<T0, T1>{
            id                               : 0x2::object::new(arg4),
            versions                         : 0x2::vec_set::singleton<u64>(1),
            free_balance                     : 0x2::balance::zero<T0>(),
            time_locked_profit               : 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::create<T0>(0x2::balance::zero<T0>(), 0, 0),
            lp_treasury                      : arg0,
            strategies                       : 0x2::vec_map::empty<0x2::object::ID, StrategyState>(),
            performance_fee_balance          : 0x2::balance::zero<T1>(),
            strategy_withdraw_priority_order : 0x1::vector::empty<0x2::object::ID>(),
            withdraw_ticket_issued           : false,
            tvl_cap                          : 0x1::option::none<u64>(),
            profit_unlock_duration_sec       : arg1,
            performance_fee_bps              : arg2,
            total_allocated_bps              : arg3,
        };
        let v1 = AdminCap<T1>{id: 0x2::object::new(arg4)};
        (v1, v0)
    }

    public fun add_strategy<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : VaultAccess {
        assert_version<T0, T1>(arg1);
        let v0 = VaultAccess{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        let v2 = if (0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg1.strategies) == 0) {
            arg1.total_allocated_bps
        } else {
            0
        };
        let v3 = StrategyState{
            borrowed                : 0,
            target_alloc_weight_bps : v2,
            max_borrow              : 0x1::option::none<u64>(),
        };
        0x2::vec_map::insert<0x2::object::ID, StrategyState>(&mut arg1.strategies, v1, v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.strategy_withdraw_priority_order, v1);
        v0
    }

    entry fun add_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    fun assert_version<T0, T1>(arg0: &Vault<T0, T1>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 9);
    }

    public fun calc_rebalance_amounts<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : RebalanceAmounts {
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = 0x2::vec_map::empty<0x2::object::ID, RebalanceInfo>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0 + 0x2::balance::value<T0>(&arg0.free_balance) + 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::max_withdrawable<T0>(&arg0.time_locked_profit, arg1);
        let v4 = 0;
        while (v4 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg0.strategies)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v4);
            let v7 = RebalanceInfo{
                to_repay   : 0,
                can_borrow : 0,
            };
            0x2::vec_map::insert<0x2::object::ID, RebalanceInfo>(&mut v0, *v5, v7);
            v3 = v3 + v6.borrowed;
            if (0x1::option::is_some<u64>(&v6.max_borrow)) {
                0x1::vector::push_back<u64>(&mut v1, v4);
            } else {
                0x1::vector::push_back<u64>(&mut v2, v4);
            };
            v4 = v4 + 1;
        };
        let v8 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(v3, arg0.total_allocated_bps, 10000);
        let v9 = arg0.total_allocated_bps;
        let v10 = true;
        while (v10) {
            let v11 = 0;
            let v12 = 0x1::vector::empty<u64>();
            v10 = false;
            while (v11 < 0x1::vector::length<u64>(&v1)) {
                let v13 = *0x1::vector::borrow<u64>(&v1, v11);
                let (_, v15) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v13);
                let (_, v17) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v0, v13);
                let v18 = *0x1::option::borrow<u64>(&v15.max_borrow);
                let v19 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(v8, v15.target_alloc_weight_bps, v9);
                if (v19 <= v15.borrowed || v18 <= v15.borrowed) {
                    if (v19 < v18) {
                        0x1::vector::push_back<u64>(&mut v12, v13);
                    } else {
                        v17.to_repay = v15.borrowed - v18;
                        v8 = v8 - v18;
                        v9 = v9 - v15.target_alloc_weight_bps;
                        v10 = true;
                    };
                    v11 = v11 + 1;
                    continue
                };
                if (v19 >= v18) {
                    v17.can_borrow = v18 - v15.borrowed;
                    v8 = v8 - v18;
                    v9 = v9 - v15.target_alloc_weight_bps;
                    v10 = true;
                    v11 = v11 + 1;
                    continue
                };
                0x1::vector::push_back<u64>(&mut v12, v13);
                v11 = v11 + 1;
            };
            v1 = v12;
        };
        let v20 = 0;
        while (v20 < 0x1::vector::length<u64>(&v1)) {
            let v21 = *0x1::vector::borrow<u64>(&v1, v20);
            let (_, v23) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v21);
            let (_, v25) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v0, v21);
            let v26 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(v8, v23.target_alloc_weight_bps, v9);
            if (v26 >= v23.borrowed) {
                v25.can_borrow = v26 - v23.borrowed;
            } else {
                v25.to_repay = v23.borrowed - v26;
            };
            v20 = v20 + 1;
        };
        let v27 = 0;
        while (v27 < 0x1::vector::length<u64>(&v2)) {
            let v28 = *0x1::vector::borrow<u64>(&v2, v27);
            let (_, v30) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v28);
            let (_, v32) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, RebalanceInfo>(&mut v0, v28);
            let v33 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(v8, v30.target_alloc_weight_bps, v9);
            if (v33 >= v30.borrowed) {
                v32.can_borrow = v33 - v30.borrowed;
            } else {
                v32.to_repay = v30.borrowed - v33;
            };
            v27 = v27 + 1;
        };
        RebalanceAmounts{inner: v0}
    }

    fun create_withdraw_ticket<T0, T1>(arg0: &Vault<T0, T1>) : WithdrawTicket<T0, T1> {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, StrategyWithdrawInfo<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v2 = StrategyWithdrawInfo<T0>{
                to_withdraw       : 0,
                withdrawn_balance : 0x2::balance::zero<T0>(),
                has_withdrawn     : false,
            };
            0x2::vec_map::insert<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v1), v2);
            v1 = v1 + 1;
        };
        WithdrawTicket<T0, T1>{
            to_withdraw_from_free_balance : 0,
            strategy_infos                : v0,
            lp_to_burn                    : 0x2::balance::zero<T1>(),
        }
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        if (0x2::coin::total_supply<T1>(&arg0.lp_treasury) == 0) {
            0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0, arg2);
            0x2::balance::join<T0>(&mut arg0.free_balance, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.time_locked_profit));
            0x2::balance::join<T0>(&mut arg0.free_balance, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg2));
            0x2::balance::join<T1>(&mut arg0.performance_fee_balance, 0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, total_available_balance<T0, T1>(arg0, arg2)));
        };
        let v0 = total_available_balance<T0, T1>(arg0, arg2);
        if (0x1::option::is_some<u64>(&arg0.tvl_cap)) {
            assert!(v0 + 0x2::balance::value<T0>(&arg1) <= *0x1::option::borrow<u64>(&arg0.tvl_cap), 1);
        };
        let v1 = if (v0 == 0) {
            0x2::balance::value<T0>(&arg1)
        } else {
            0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(0x2::coin::total_supply<T1>(&arg0.lp_treasury), 0x2::balance::value<T0>(&arg1), v0)
        };
        let v2 = DepositEvent<T1>{
            amount    : 0x2::balance::value<T0>(&arg1),
            lp_minted : v1,
        };
        0x2::event::emit<DepositEvent<T1>>(v2);
        0x2::balance::join<T0>(&mut arg0.free_balance, arg1);
        0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, v1)
    }

    public fun flash_loan<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: u64) : (0x2::balance::Balance<T0>, FlashLoanReceitp<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.free_balance), 11);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = 0x2::vec_map::keys<0x2::object::ID, StrategyState>(strategies<T0, T1>(arg0));
        assert!(0x1::vector::contains<0x2::object::ID>(&v1, &v0), 6);
        let v2 = FlashLoanReceitp<T0, T1>{
            access      : v0,
            loan_amount : arg2,
        };
        (0x2::balance::split<T0>(&mut arg0.free_balance, arg2), v2)
    }

    public fun free_balance<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.free_balance
    }

    public fun new_strategy_removal_ticket<T0, T1>(arg0: VaultAccess, arg1: 0x2::balance::Balance<T0>) : StrategyRemovalTicket<T0, T1> {
        StrategyRemovalTicket<T0, T1>{
            access           : arg0,
            returned_balance : arg1,
        }
    }

    public fun performance_fee_balance<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.performance_fee_balance
    }

    public fun performance_fee_bps<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.performance_fee_bps
    }

    public fun profit_unlock_duration_sec<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.profit_unlock_duration_sec
    }

    entry fun pull_unlocked_profits_to_free_balance<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg1);
        0x2::balance::join<T0>(&mut arg1.free_balance, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::withdraw_all<T0>(&mut arg1.time_locked_profit, arg2));
    }

    public fun rebalance_amounts_get(arg0: &RebalanceAmounts, arg1: &VaultAccess) : (u64, u64) {
        let v0 = 0x2::vec_map::get<0x2::object::ID, RebalanceInfo>(&arg0.inner, 0x2::object::uid_as_inner(&arg1.id));
        (v0.can_borrow, v0.to_repay)
    }

    public fun redeem_withdraw_ticket<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: WithdrawTicket<T0, T1>) : 0x2::balance::Balance<T0> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::balance::zero<T0>();
        let WithdrawTicket {
            to_withdraw_from_free_balance : v1,
            strategy_infos                : v2,
            lp_to_burn                    : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        while (0x2::vec_map::size<0x2::object::ID, StrategyWithdrawInfo<T0>>(&v5) > 0) {
            let (v6, v7) = 0x2::vec_map::pop<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v5);
            let v8 = v6;
            let StrategyWithdrawInfo {
                to_withdraw       : v9,
                withdrawn_balance : v10,
                has_withdrawn     : v11,
            } = v7;
            let v12 = v10;
            if (v9 > 0) {
                assert!(v11, 5);
            };
            if (0x2::balance::value<T0>(&v12) < v9) {
                let v13 = StrategyLossEvent<T1>{
                    strategy_id : v8,
                    to_withdraw : v9,
                    withdrawn   : 0x2::balance::value<T0>(&v12),
                };
                0x2::event::emit<StrategyLossEvent<T1>>(v13);
            };
            let v14 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, &v8);
            v14.borrowed = v14.borrowed - v9;
            0x2::balance::join<T0>(&mut v0, v12);
        };
        0x2::vec_map::destroy_empty<0x2::object::ID, StrategyWithdrawInfo<T0>>(v5);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.free_balance, v1));
        0x2::balance::decrease_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg0.lp_treasury), v4);
        let v15 = WithdrawEvent<T1>{
            amount    : 0x2::balance::value<T0>(&v0),
            lp_burned : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<WithdrawEvent<T1>>(v15);
        arg0.withdraw_ticket_issued = false;
        v0
    }

    public fun remove_strategy<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: StrategyRemovalTicket<T0, T1>, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg1);
        let StrategyRemovalTicket {
            access           : v0,
            returned_balance : v1,
        } = arg2;
        let v2 = v1;
        let VaultAccess { id: v3 } = v0;
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = &v4;
        0x2::object::delete(v3);
        let (_, v7) = 0x2::vec_map::remove<0x2::object::ID, StrategyState>(&mut arg1.strategies, v5);
        let StrategyState {
            borrowed                : v8,
            target_alloc_weight_bps : _,
            max_borrow              : _,
        } = v7;
        let v11 = 0x2::balance::value<T0>(&v2);
        if (v11 > v8) {
            0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::top_up<T0>(&mut arg1.time_locked_profit, 0x2::balance::split<T0>(&mut v2, v11 - v8), arg5);
        };
        0x2::balance::join<T0>(&mut arg1.free_balance, v2);
        let (v12, v13) = 0x1::vector::index_of<0x2::object::ID>(&arg1.strategy_withdraw_priority_order, v5);
        assert!(v12, 8);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.strategy_withdraw_priority_order, v13);
        set_strategy_target_alloc_weights_bps<T0, T1>(arg0, arg1, arg3, arg4);
    }

    entry fun remove_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: FlashLoanReceitp<T0, T1>, arg3: 0x2::balance::Balance<T0>) {
        assert_version<T0, T1>(arg0);
        let FlashLoanReceitp {
            access      : v0,
            loan_amount : v1,
        } = arg2;
        assert!(0x2::balance::value<T0>(&arg3) >= v1, 12);
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(v2 == v0, 6);
        let v3 = 0x2::vec_map::keys<0x2::object::ID, StrategyState>(strategies<T0, T1>(arg0));
        assert!(0x1::vector::contains<0x2::object::ID>(&v3, &v2), 6);
        0x2::balance::join<T0>(&mut arg0.free_balance, arg3);
    }

    entry fun set_performance_fee_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        assert!(arg2 <= 10000, 0);
        arg1.performance_fee_bps = arg2;
    }

    entry fun set_profit_unlock_duration_sec<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.profit_unlock_duration_sec = arg2;
    }

    entry fun set_strategy_max_borrow<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>) {
        assert_version<T0, T1>(arg1);
        0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg1.strategies, &arg2).max_borrow = arg3;
    }

    entry fun set_strategy_target_alloc_weights_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: vector<0x2::object::ID>, arg3: vector<u64>) {
        assert_version<T0, T1>(arg1);
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg1.strategies)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, v3);
            v1 = v1 + v4;
            0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg1.strategies, &v3).target_alloc_weight_bps = v4;
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0 && v1 == 0 || v1 == arg1.total_allocated_bps, 7);
    }

    entry fun set_total_allocated_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        assert!(arg2 <= 10000, 0);
        arg1.total_allocated_bps = arg2;
    }

    entry fun set_tvl_cap<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: 0x1::option::Option<u64>) {
        assert_version<T0, T1>(arg1);
        arg1.tvl_cap = arg2;
    }

    public fun strategies<T0, T1>(arg0: &Vault<T0, T1>) : &0x2::vec_map::VecMap<0x2::object::ID, StrategyState> {
        &arg0.strategies
    }

    public fun strategy_borrow<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, 0x2::object::uid_as_inner(&arg1.id));
        v0.borrowed = v0.borrowed + arg2;
        0x2::balance::split<T0>(&mut arg0.free_balance, arg2)
    }

    public fun strategy_hand_over_profit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        assert!(0x2::vec_map::contains<0x2::object::ID, StrategyState>(&arg0.strategies, 0x2::object::uid_as_inner(&arg1.id)), 6);
        let v0 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(0x2::balance::value<T0>(&arg2), arg0.performance_fee_bps, 10000);
        let v1 = if (v0 > 0) {
            let v2 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(0x2::coin::total_supply<T1>(&arg0.lp_treasury), v0, total_available_balance<T0, T1>(arg0, arg3) - v0);
            0x2::balance::join<T1>(&mut arg0.performance_fee_balance, 0x2::coin::mint_balance<T1>(&mut arg0.lp_treasury, v2));
            v2
        } else {
            0
        };
        let v3 = StrategyProfitEvent<T1>{
            strategy_id : 0x2::object::uid_to_inner(&arg1.id),
            profit      : 0x2::balance::value<T0>(&arg2),
            fee_amt_yt  : v1,
        };
        0x2::event::emit<StrategyProfitEvent<T1>>(v3);
        0x2::balance::join<T0>(&mut arg0.free_balance, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg3));
        0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0, arg3);
        let v4 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.time_locked_profit);
        0x2::balance::join<T0>(&mut v4, arg2);
        0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.time_locked_profit, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::timestamp_sec(arg3), arg3);
        0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.time_locked_profit, 0x1::u64::divide_and_round_up(0x2::balance::value<T0>(&v4), arg0.profit_unlock_duration_sec), arg3);
        0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::top_up<T0>(&mut arg0.time_locked_profit, v4, arg3);
    }

    public fun strategy_repay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyState>(&mut arg0.strategies, 0x2::object::uid_as_inner(&arg1.id));
        v0.borrowed = v0.borrowed - 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.free_balance, arg2);
    }

    public fun strategy_state(arg0: &StrategyState) : (u64, u64, 0x1::option::Option<u64>) {
        (arg0.borrowed, arg0.target_alloc_weight_bps, arg0.max_borrow)
    }

    public fun strategy_withdraw_priority_order<T0, T1>(arg0: &Vault<T0, T1>) : vector<0x2::object::ID> {
        arg0.strategy_withdraw_priority_order
    }

    public fun strategy_withdraw_to_ticket<T0, T1>(arg0: &mut WithdrawTicket<T0, T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut arg0.strategy_infos, 0x2::object::uid_as_inner(&arg1.id));
        assert!(v0.has_withdrawn == false, 4);
        v0.has_withdrawn = true;
        0x2::balance::join<T0>(&mut v0.withdrawn_balance, arg2);
    }

    public fun time_locked_profit<T0, T1>(arg0: &Vault<T0, T1>) : &0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::TimeLockedBalance<T0> {
        &arg0.time_locked_profit
    }

    public fun total_available_balance<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0 + 0x2::balance::value<T0>(&arg0.free_balance) + 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::max_withdrawable<T0>(&arg0.time_locked_profit, arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, StrategyState>(&arg0.strategies)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyState>(&arg0.strategies, v1);
            v0 = v0 + v3.borrowed;
            v1 = v1 + 1;
        };
        v0
    }

    public fun total_yt_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::coin::total_supply<T1>(&arg0.lp_treasury)
    }

    public fun tvl_cap<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.tvl_cap
    }

    public fun vault_access_id(arg0: &VaultAccess) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun vault_info<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64, u64, u64, u64, bool, 0x1::option::Option<u64>, u64) {
        (0x2::balance::value<T0>(&arg0.free_balance), 0x2::balance::value<T0>(0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::locked_balance<T0>(&arg0.time_locked_profit)), 0x2::balance::value<T0>(0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::unlocked_balance<T0>(&arg0.time_locked_profit)), 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::unlock_per_second<T0>(&arg0.time_locked_profit), 0x2::balance::value<T1>(&arg0.performance_fee_balance), arg0.withdraw_ticket_issued, arg0.tvl_cap, arg0.profit_unlock_duration_sec)
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : WithdrawTicket<T0, T1> {
        assert_version<T0, T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 2);
        assert!(0x2::balance::value<T1>(&arg1) > 0, 3);
        arg0.withdraw_ticket_issued = true;
        let v0 = create_withdraw_ticket<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut v0.lp_to_burn, arg1);
        0x2::balance::join<T0>(&mut arg0.free_balance, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::time_locked_balance::withdraw_all<T0>(&mut arg0.time_locked_profit, arg2));
        let v1 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(0x2::balance::value<T1>(&v0.lp_to_burn), total_available_balance<T0, T1>(arg0, arg2), 0x2::coin::total_supply<T1>(&arg0.lp_treasury));
        v0.to_withdraw_from_free_balance = 0x1::u64::min(v1, 0x2::balance::value<T0>(&arg0.free_balance));
        let v2 = v1 - v0.to_withdraw_from_free_balance;
        let v3 = v2;
        if (v2 == 0) {
            return v0
        };
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v6 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v5);
            let v7 = 0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v6);
            let v8 = if (0x1::option::is_some<u64>(&v7.max_borrow)) {
                let v9 = *0x1::option::borrow<u64>(&v7.max_borrow);
                if (v7.borrowed > v9) {
                    v7.borrowed - v9
                } else {
                    0
                }
            } else {
                0
            };
            let v10 = if (v8 >= v3) {
                v3
            } else {
                v8
            };
            v3 = v3 - v10;
            let v11 = v4 + v7.borrowed;
            v4 = v11 - v8;
            0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0.strategy_infos, v6).to_withdraw = v8;
            v5 = v5 + 1;
        };
        if (v3 == 0) {
            return v0
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v13 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v12);
            let v14 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0.strategy_infos, v13);
            let v15 = 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div(0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v13).borrowed - v14.to_withdraw, v3, v4);
            v14.to_withdraw = v14.to_withdraw + v15;
            v3 = v3 - v15;
            v12 = v12 + 1;
        };
        if (v3 == 0) {
            return v0
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v17 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v16);
            let v18 = 0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0.strategy_infos, v17);
            let v19 = 0x1::u64::min(0x2::vec_map::get<0x2::object::ID, StrategyState>(&arg0.strategies, v17).borrowed - v18.to_withdraw, v3);
            v18.to_withdraw = v18.to_withdraw + v19;
            let v20 = v3 - v19;
            v3 = v20;
            if (v20 == 0) {
                break
            };
            v16 = v16 + 1;
        };
        v0
    }

    public fun withdraw_performance_fee<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut Vault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T1> {
        assert_version<T0, T1>(arg1);
        0x2::balance::split<T1>(&mut arg1.performance_fee_balance, arg2)
    }

    public fun withdraw_t_amt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : WithdrawTicket<T0, T1> {
        let v0 = 0x2::balance::split<T1>(arg2, 0xb14b70efe3028e5769fa36d6eee8c80e8c2a53614260fe85a171b876cc294425::utils::mul_div_round_up(arg1, 0x2::coin::total_supply<T1>(&arg0.lp_treasury), total_available_balance<T0, T1>(arg0, arg3)));
        withdraw<T0, T1>(arg0, v0, arg3)
    }

    public fun withdraw_ticket_issued<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.withdraw_ticket_issued
    }

    public fun withdraw_ticket_to_withdraw<T0, T1>(arg0: &WithdrawTicket<T0, T1>, arg1: &VaultAccess) : u64 {
        0x2::vec_map::get<0x2::object::ID, StrategyWithdrawInfo<T0>>(&arg0.strategy_infos, 0x2::object::uid_as_inner(&arg1.id)).to_withdraw
    }

    // decompiled from Move bytecode v6
}

