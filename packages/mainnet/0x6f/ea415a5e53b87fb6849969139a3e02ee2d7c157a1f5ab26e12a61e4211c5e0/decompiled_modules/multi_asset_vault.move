module 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::multi_asset_vault {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct VaultAccess has store {
        id: 0x2::object::UID,
    }

    struct MultiAssetVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        free_balances: 0x2::bag::Bag,
        time_locked_profits: 0x2::bag::Bag,
        profit_unlock_duration_sec: u64,
        lp_treasury: 0x2::coin::TreasuryCap<T0>,
        strategies: 0x2::vec_map::VecMap<0x2::object::ID, MultiAssetStrategyState>,
        performance_fee_bps: u64,
        performance_fee_balances: 0x2::bag::Bag,
        strategy_withdraw_priority_order: vector<0x2::object::ID>,
        withdraw_ticket_issued: bool,
        tvl_caps: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<u64>>,
    }

    struct MultiAssetStrategyState has store {
        borrowed_infos: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BorrowedInfo>,
    }

    struct BorrowedInfo has store {
        borrowed: u64,
        max_borrow: 0x1::option::Option<u64>,
        target_alloc_weight_bps: u64,
    }

    struct MultiAssetStrategyRemovalTicket<phantom T0> {
        access: VaultAccess,
        balance_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        returned_balances: 0x2::bag::Bag,
    }

    struct DepositTicket<phantom T0> {
        deposited_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        minted_yt_amt: u64,
    }

    struct StrategyWithdrawInfo<phantom T0> has store {
        to_withdraw: u64,
        withdrawn_balance: 0x2::balance::Balance<T0>,
        has_withdrawn: bool,
    }

    struct WithdrawInfo<phantom T0> has store {
        to_withdraw_from_free_balance: u64,
        strategy_infos: 0x2::vec_map::VecMap<0x2::object::ID, StrategyWithdrawInfo<T0>>,
    }

    struct WithdrawTicket<phantom T0> {
        withdraw_infos: 0x2::bag::Bag,
        claimed: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        lp_to_burn: 0x2::balance::Balance<T0>,
    }

    struct RebalanceInfo has copy, drop, store {
        to_repay: u64,
        can_borrow: u64,
    }

    struct RebalanceAmounts<phantom T0> has copy, drop {
        inner: 0x2::vec_map::VecMap<0x2::object::ID, RebalanceInfo>,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, MultiAssetVault<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 101);
        let v0 = AdminCap<T0>{id: 0x2::object::new(arg1)};
        let v1 = MultiAssetVault<T0>{
            id                               : 0x2::object::new(arg1),
            version                          : 1,
            free_balances                    : 0x2::bag::new(arg1),
            time_locked_profits              : 0x2::bag::new(arg1),
            profit_unlock_duration_sec       : 3600,
            lp_treasury                      : arg0,
            strategies                       : 0x2::vec_map::empty<0x2::object::ID, MultiAssetStrategyState>(),
            performance_fee_bps              : 1000,
            performance_fee_balances         : 0x2::bag::new(arg1),
            strategy_withdraw_priority_order : 0x1::vector::empty<0x2::object::ID>(),
            withdraw_ticket_issued           : false,
            tvl_caps                         : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<u64>>(),
        };
        (v0, v1)
    }

    public fun add_strategy<T0>(arg0: &AdminCap<T0>, arg1: &mut MultiAssetVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : VaultAccess {
        assert_version<T0>(arg1);
        let v0 = VaultAccess{id: 0x2::object::new(arg2)};
        let v1 = vault_access_id(&v0);
        let v2 = MultiAssetStrategyState{borrowed_infos: 0x2::vec_map::empty<0x1::type_name::TypeName, BorrowedInfo>()};
        0x2::vec_map::insert<0x2::object::ID, MultiAssetStrategyState>(&mut arg1.strategies, v1, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.strategy_withdraw_priority_order, v1);
        v0
    }

    public fun add_strategy_removal_asset_by_asset<T0, T1>(arg0: &mut MultiAssetStrategyRemovalTicket<T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.balance_types, v0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.returned_balances, v0, arg1);
    }

    public fun add_strategy_supported_asset<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &AdminCap<T1>, arg2: &VaultAccess) {
        assert_version<T1>(arg0);
        let v0 = vault_access_id(arg2);
        let v1 = BorrowedInfo{
            borrowed                : 0,
            max_borrow              : 0x1::option::none<u64>(),
            target_alloc_weight_bps : 0,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, BorrowedInfo>(&mut 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg0.strategies, &v0).borrowed_infos, 0x1::type_name::get<T0>(), v1);
    }

    public entry fun add_vault_supported_aaset<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &AdminCap<T1>) {
        assert_version<T1>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_balances, v0, 0x2::balance::zero<T0>());
        0x2::bag::add<0x1::type_name::TypeName, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0>>(&mut arg0.time_locked_profits, v0, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::create<T0>(0x2::balance::zero<T0>(), 0, 0));
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.performance_fee_balances, v0, 0x2::balance::zero<T0>());
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<u64>>(&mut arg0.tvl_caps, v0, 0x1::option::none<u64>());
    }

    fun assert_version<T0>(arg0: &MultiAssetVault<T0>) {
        assert!(arg0.version == 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::module_version(), 1);
    }

    public fun borrowed(arg0: &BorrowedInfo) : u64 {
        arg0.borrowed
    }

    public fun borrowed_info<T0>(arg0: &MultiAssetStrategyState) : &BorrowedInfo {
        let v0 = 0x1::type_name::get<T0>();
        let (_, v2) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, BorrowedInfo>(&arg0.borrowed_infos, 0x2::vec_map::get_idx<0x1::type_name::TypeName, BorrowedInfo>(&arg0.borrowed_infos, &v0));
        v2
    }

    fun borrowed_info_mut<T0>(arg0: &mut MultiAssetStrategyState) : &mut BorrowedInfo {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::get_mut<0x1::type_name::TypeName, BorrowedInfo>(&mut arg0.borrowed_infos, &v0)
    }

    public fun borrowed_infos_contains_by_asset<T0>(arg0: &MultiAssetStrategyState) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, BorrowedInfo>(&arg0.borrowed_infos, &v0)
    }

    public fun calc_rebalance_amounts_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: &0x2::clock::Clock) : RebalanceAmounts<T0> {
        assert!(arg0.withdraw_ticket_issued == false, 108);
        let v0 = 0x2::vec_map::empty<0x2::object::ID, RebalanceInfo>();
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0 + 0x2::balance::value<T0>(free_balance<T0, T1>(arg0)) + 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::max_withdrawable<T0>(time_locked_profit<T0, T1>(arg0), arg1);
        let v4 = supported_strategies_by_asset<T0, T1>(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&v4, v5);
            let v7 = RebalanceInfo{
                to_repay   : 0,
                can_borrow : 0,
            };
            0x2::vec_map::insert<0x2::object::ID, RebalanceInfo>(&mut v0, v6, v7);
            let v8 = borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v6));
            v3 = v3 + v8.borrowed;
            if (0x1::option::is_some<u64>(&v8.max_borrow)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1, v6);
            } else {
                0x1::vector::push_back<0x2::object::ID>(&mut v2, v6);
            };
            v5 = v5 + 1;
        };
        let v9 = v3;
        let v10 = 10000;
        let v11 = true;
        while (v11) {
            let v12 = 0;
            let v13 = 0x1::vector::empty<0x2::object::ID>();
            v11 = false;
            while (v12 < 0x1::vector::length<0x2::object::ID>(&v1)) {
                let v14 = *0x1::vector::borrow<0x2::object::ID>(&v1, v12);
                let v15 = borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v14));
                let v16 = 0x2::vec_map::get_mut<0x2::object::ID, RebalanceInfo>(&mut v0, &v14);
                let v17 = *0x1::option::borrow<u64>(&v15.max_borrow);
                let v18 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(v9, v15.target_alloc_weight_bps, v10);
                if (v18 <= v15.borrowed || v17 <= v15.borrowed) {
                    if (v18 < v17) {
                        0x1::vector::push_back<0x2::object::ID>(&mut v13, v14);
                    } else {
                        v16.to_repay = v15.borrowed - v17;
                        v9 = v9 - v17;
                        v10 = v10 - v15.target_alloc_weight_bps;
                        v11 = true;
                    };
                    v12 = v12 + 1;
                    continue
                };
                if (v18 >= v17) {
                    v16.can_borrow = v17 - v15.borrowed;
                    v9 = v9 - v17;
                    v10 = v10 - v15.target_alloc_weight_bps;
                    v11 = true;
                    v12 = v12 + 1;
                    continue
                };
                0x1::vector::push_back<0x2::object::ID>(&mut v13, v14);
                v12 = v12 + 1;
            };
            v1 = v13;
        };
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v20 = *0x1::vector::borrow<0x2::object::ID>(&v1, v19);
            let v21 = borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v20));
            let v22 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(v9, v21.target_alloc_weight_bps, v10);
            if (v22 >= v21.borrowed) {
                0x2::vec_map::get_mut<0x2::object::ID, RebalanceInfo>(&mut v0, &v20).can_borrow = v22 - v21.borrowed;
            } else {
                0x2::vec_map::get_mut<0x2::object::ID, RebalanceInfo>(&mut v0, &v20).to_repay = v21.borrowed - v22;
            };
            v19 = v19 + 1;
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v24 = *0x1::vector::borrow<0x2::object::ID>(&v2, v23);
            let v25 = borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v24));
            let v26 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(v9, v25.target_alloc_weight_bps, v10);
            if (v26 >= v25.borrowed) {
                0x2::vec_map::get_mut<0x2::object::ID, RebalanceInfo>(&mut v0, &v24).can_borrow = v26 - v25.borrowed;
            } else {
                0x2::vec_map::get_mut<0x2::object::ID, RebalanceInfo>(&mut v0, &v24).to_repay = v25.borrowed - v26;
            };
            v23 = v23 + 1;
        };
        RebalanceAmounts<T0>{inner: v0}
    }

    fun check_deposit_ticket_fulfilled<T0>(arg0: &MultiAssetVault<T0>, arg1: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let v0 = supported_assets<T0>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1)), 112);
            v1 = v1 + 1;
        };
    }

    fun check_removal_ticket_fulfilled<T0>(arg0: &MultiAssetVault<T0>, arg1: &VaultAccess, arg2: &0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let v0 = vault_access_id(arg1);
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, BorrowedInfo>(&0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v0).borrowed_infos);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(arg2, 0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2)), 112);
            v2 = v2 + 1;
        };
    }

    fun decrease_borrowed<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg0.strategies, &arg1);
        let v1 = borrowed_info_mut<T0>(v0);
        v1.borrowed = v1.borrowed - arg2;
    }

    public fun deposit_by_asset<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut DepositTicket<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_version<T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 108);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T0>()
        };
        if (0x2::coin::total_supply<T1>(&arg0.lp_treasury) == 0) {
            let v0 = time_locked_profit_mut<T0, T1>(arg0);
            0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::change_unlock_per_second<T0>(v0, 0, arg3);
            let v1 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::skim_extraneous_balance<T0>(v0);
            let v2 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::withdraw_all<T0>(v0, arg3);
            let v3 = free_balance_mut<T0, T1>(arg0);
            0x2::balance::join<T0>(v3, v1);
            0x2::balance::join<T0>(v3, v2);
            let v4 = 0x2::balance::withdraw_all<T0>(v3);
            let v5 = performance_fee_balance_mut<T0, T1>(arg0);
            0x2::balance::join<T0>(v5, v4);
        };
        let v6 = tvl_cap_by_asset<T0, T1>(arg0);
        if (0x1::option::is_some<u64>(&v6)) {
            assert!(total_available_balance_by_asset<T0, T1>(arg0, arg3) + 0x2::balance::value<T0>(&arg1) <= *0x1::option::borrow<u64>(&v6), 109);
        };
        let v7 = get_required_deposit_by_given_yt<T0, T1>(arg0, arg2.minted_yt_amt, arg3);
        assert!(0x2::balance::value<T0>(&arg1) >= v7, 110);
        let v8 = if (v7 > 0x2::balance::value<T0>(&arg1)) {
            0x2::balance::split<T0>(&mut arg1, v7 - 0x2::balance::value<T0>(&arg1))
        } else {
            0x2::balance::zero<T0>()
        };
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::event::deposit_by_asset_event<T0, T1>(0x2::balance::value<T0>(&arg1), arg2.minted_yt_amt);
        0x2::balance::join<T0>(free_balance_mut<T0, T1>(arg0), arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg2.deposited_types, 0x1::type_name::get<T0>());
        v8
    }

    public fun free_balance<T0, T1>(arg0: &MultiAssetVault<T1>) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.free_balances, 0x1::type_name::get<T0>())
    }

    fun free_balance_mut<T0, T1>(arg0: &mut MultiAssetVault<T1>) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.free_balances, 0x1::type_name::get<T0>())
    }

    public fun free_balances_contains<T0, T1>(arg0: &MultiAssetVault<T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_balances, 0x1::type_name::get<T0>())
    }

    public fun get_borrowed_info_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: 0x2::object::ID) : (u64, 0x1::option::Option<u64>, u64) {
        let v0 = borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &arg1));
        (v0.borrowed, v0.max_borrow, v0.target_alloc_weight_bps)
    }

    public fun get_expected_yt_by_given_deposit<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = total_available_balance_by_asset<T0, T1>(arg0, arg2);
        if (v0 == 0) {
            arg1
        } else {
            0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(arg1, 0x2::coin::total_supply<T1>(&arg0.lp_treasury), v0)
        }
    }

    public fun get_output_yt_by_given_deposit<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = total_available_balance_by_asset<T0, T1>(arg0, arg2);
        if (v0 == 0) {
            arg1
        } else {
            0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(0x2::coin::total_supply<T1>(&arg0.lp_treasury), arg1, v0)
        }
    }

    public fun get_required_deposit_by_given_yt<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = total_available_balance_by_asset<T0, T1>(arg0, arg2);
        if (v0 == 0) {
            arg1
        } else {
            0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(arg1, v0, 0x2::coin::total_supply<T1>(&arg0.lp_treasury))
        }
    }

    fun increase_borrowed<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg0.strategies, &arg1);
        let v1 = borrowed_info_mut<T0>(v0);
        v1.borrowed = v1.borrowed + arg2;
    }

    fun initialize_withdraw_ticket_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: &mut WithdrawTicket<T1>) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, StrategyWithdrawInfo<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v1);
            if (borrowed_infos_contains_by_asset<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v2))) {
                let v3 = StrategyWithdrawInfo<T0>{
                    to_withdraw       : 0,
                    withdrawn_balance : 0x2::balance::zero<T0>(),
                    has_withdrawn     : false,
                };
                0x2::vec_map::insert<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v0, v2, v3);
            };
            v1 = v1 + 1;
        };
        let v4 = WithdrawInfo<T0>{
            to_withdraw_from_free_balance : 0,
            strategy_infos                : v0,
        };
        0x2::bag::add<0x1::type_name::TypeName, WithdrawInfo<T0>>(&mut arg1.withdraw_infos, 0x1::type_name::get<T0>(), v4);
    }

    public fun is_strategy_exist<T0>(arg0: &MultiAssetVault<T0>, arg1: &0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, arg1)
    }

    public fun max_borrow(arg0: &BorrowedInfo) : 0x1::option::Option<u64> {
        arg0.max_borrow
    }

    entry fun migrate<T0>(arg0: &AdminCap<T0>, arg1: &mut MultiAssetVault<T0>) {
        assert!(arg1.version < 1, 107);
        arg1.version = 1;
    }

    public fun multi_asset_strategy_state<T0>(arg0: &MultiAssetVault<T0>, arg1: &0x2::object::ID) : &MultiAssetStrategyState {
        0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, arg1)
    }

    public fun new_multi_asset_strategy_removal_ticket<T0>(arg0: &AdminCap<T0>, arg1: VaultAccess, arg2: &mut 0x2::tx_context::TxContext) : MultiAssetStrategyRemovalTicket<T0> {
        MultiAssetStrategyRemovalTicket<T0>{
            access            : arg1,
            balance_types     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            returned_balances : 0x2::bag::new(arg2),
        }
    }

    public fun num_of_strategies_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>) : u64 {
        let v0 = supported_strategies_by_asset<T0, T1>(arg0);
        0x1::vector::length<0x2::object::ID>(&v0)
    }

    public fun performance_fee_balance<T0, T1>(arg0: &MultiAssetVault<T1>) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.performance_fee_balances, 0x1::type_name::get<T0>())
    }

    fun performance_fee_balance_mut<T0, T1>(arg0: &mut MultiAssetVault<T1>) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.performance_fee_balances, 0x1::type_name::get<T0>())
    }

    public fun performance_fee_bps<T0>(arg0: &MultiAssetVault<T0>) : u64 {
        arg0.performance_fee_bps
    }

    public fun prepare_deposit_ticket<T0>(arg0: &mut MultiAssetVault<T0>, arg1: u64) : DepositTicket<T0> {
        assert_version<T0>(arg0);
        DepositTicket<T0>{
            deposited_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            minted_yt_amt   : arg1,
        }
    }

    public fun prepare_withdraw_ticket<T0>(arg0: &mut MultiAssetVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : WithdrawTicket<T0> {
        assert!(arg0.withdraw_ticket_issued == false, 108);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 114);
        arg0.withdraw_ticket_issued = true;
        WithdrawTicket<T0>{
            withdraw_infos : 0x2::bag::new(arg2),
            claimed        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            lp_to_burn     : arg1,
        }
    }

    public fun profit_unlock_duration_sec<T0>(arg0: &MultiAssetVault<T0>) : u64 {
        arg0.profit_unlock_duration_sec
    }

    public entry fun pull_unlocked_profits_to_free_balance_by_asset<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: &0x2::clock::Clock) {
        assert_version<T1>(arg1);
        let v0 = time_locked_profit_mut<T0, T1>(arg1);
        0x2::balance::join<T0>(free_balance_mut<T0, T1>(arg1), 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::withdraw_all<T0>(v0, arg2));
    }

    public fun rebalance_amounts_get<T0>(arg0: &RebalanceAmounts<T0>, arg1: &VaultAccess) : (u64, u64) {
        let v0 = vault_access_id(arg1);
        let v1 = 0x2::vec_map::get<0x2::object::ID, RebalanceInfo>(&arg0.inner, &v0);
        (v1.can_borrow, v1.to_repay)
    }

    public fun redeem_withdraw_ticket<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &mut WithdrawTicket<T1>) : 0x2::balance::Balance<T0> {
        assert_version<T1>(arg0);
        let v0 = 0x2::balance::zero<T0>();
        assert!(withdraw_infos_contains<T0, T1>(arg1), 119);
        let WithdrawInfo {
            to_withdraw_from_free_balance : v1,
            strategy_infos                : v2,
        } = 0x2::bag::remove<0x1::type_name::TypeName, WithdrawInfo<T0>>(&mut arg1.withdraw_infos, 0x1::type_name::get<T0>());
        let v3 = v2;
        while (0x2::vec_map::size<0x2::object::ID, StrategyWithdrawInfo<T0>>(&v3) > 0) {
            let (v4, v5) = 0x2::vec_map::pop<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut v3);
            let StrategyWithdrawInfo {
                to_withdraw       : v6,
                withdrawn_balance : v7,
                has_withdrawn     : v8,
            } = v5;
            let v9 = v7;
            if (v6 > 0) {
                assert!(v8, 115);
            };
            if (0x2::balance::value<T0>(&v9) < v6) {
                0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::event::strategy_loss_event<T1>(v4, v6, 0x2::balance::value<T0>(&v9));
            };
            decrease_borrowed<T0, T1>(arg0, v4, v6);
            0x2::balance::join<T0>(&mut v0, v9);
        };
        0x2::vec_map::destroy_empty<0x2::object::ID, StrategyWithdrawInfo<T0>>(v3);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(free_balance_mut<T0, T1>(arg0), v1));
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::event::withdraw_event<T1>(0x2::balance::value<T0>(&v0), 0x2::balance::value<T1>(&arg1.lp_to_burn));
        v0
    }

    public fun remove_strategy<T0>(arg0: &mut MultiAssetVault<T0>, arg1: &AdminCap<T0>, arg2: MultiAssetStrategyRemovalTicket<T0>) {
        assert_version<T0>(arg0);
        let MultiAssetStrategyRemovalTicket {
            access            : v0,
            balance_types     : v1,
            returned_balances : v2,
        } = arg2;
        let v3 = v1;
        let v4 = v0;
        check_removal_ticket_fulfilled<T0>(arg0, &v4, &v3);
        0x2::bag::destroy_empty(v2);
        let VaultAccess { id: v5 } = v4;
        let v6 = 0x2::object::uid_to_inner(&v5);
        0x2::object::delete(v5);
        let (_, v8) = 0x2::vec_map::remove<0x2::object::ID, MultiAssetStrategyState>(&mut arg0.strategies, &v6);
        let MultiAssetStrategyState { borrowed_infos: v9 } = v8;
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, BorrowedInfo>(v9);
        let (v10, v11) = 0x1::vector::index_of<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, &v6);
        assert!(v10, 106);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.strategy_withdraw_priority_order, v11);
    }

    public fun remove_strategy_by_asset<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: &mut MultiAssetStrategyRemovalTicket<T1>, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        assert_version<T1>(arg1);
        let v0 = remove_strategy_removal_asset_by_asset<T0, T1>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = vault_access_id(&arg2.access);
        let v3 = 0x1::type_name::get<T0>();
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, BorrowedInfo>(&mut 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg1.strategies, &v2).borrowed_infos, &v3);
        let BorrowedInfo {
            borrowed                : v6,
            max_borrow              : _,
            target_alloc_weight_bps : _,
        } = v5;
        if (v1 > v6) {
            let v9 = time_locked_profit_mut<T0, T1>(arg1);
            0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::top_up<T0>(v9, 0x2::balance::split<T0>(&mut v0, v1 - v6), arg5);
        };
        let v10 = free_balance_mut<T0, T1>(arg1);
        0x2::balance::join<T0>(v10, v0);
        set_strategy_target_alloc_weights_bps<T0, T1>(arg0, arg1, arg3, arg4);
    }

    fun remove_strategy_removal_asset_by_asset<T0, T1>(arg0: &mut MultiAssetStrategyRemovalTicket<T1>) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.returned_balances, 0x1::type_name::get<T0>())
    }

    public entry fun remove_vault_supported_aaset<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>) {
        assert_version<T1>(arg1);
        let v0 = 0x1::type_name::get<T0>();
        0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.free_balances, v0));
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::destroy_empty<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0>>(&mut arg1.time_locked_profits, v0));
    }

    entry fun set_performance_fee_bps<T0>(arg0: &AdminCap<T0>, arg1: &mut MultiAssetVault<T0>, arg2: u64) {
        assert_version<T0>(arg1);
        assert!(arg2 <= 10000, 102);
        arg1.performance_fee_bps = arg2;
    }

    entry fun set_profit_unlock_duration_sec<T0>(arg0: &AdminCap<T0>, arg1: &mut MultiAssetVault<T0>, arg2: u64) {
        assert_version<T0>(arg1);
        arg1.profit_unlock_duration_sec = arg2;
    }

    entry fun set_strategy_max_borrow_by_asset<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>) {
        assert_version<T1>(arg1);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg1.strategies, &arg2);
        borrowed_info_mut<T0>(v0).max_borrow = arg3;
    }

    public entry fun set_strategy_target_alloc_weights_bps<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: vector<0x2::object::ID>, arg3: vector<u64>) {
        assert_version<T1>(arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3), 120);
        let v0 = 0x2::vec_set::empty<0x2::object::ID>();
        let v1 = 0;
        let v2 = 0;
        let v3 = num_of_strategies_by_asset<T0, T1>(arg1);
        assert!(v3 == 0x1::vector::length<0x2::object::ID>(&arg2), 121);
        while (v2 < v3) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v2);
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, v4);
            v1 = v1 + v5;
            let v6 = 0x2::vec_map::get_mut<0x2::object::ID, MultiAssetStrategyState>(&mut arg1.strategies, &v4);
            let v7 = borrowed_info_mut<T0>(v6);
            update_target_alloc_weight_bps(v7, v5);
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0 && v1 == 0 || v1 == 10000, 103);
    }

    entry fun set_tvl_cap_by_asset<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: 0x1::option::Option<u64>) {
        assert_version<T1>(arg1);
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<u64>>(&mut arg1.tvl_caps, &v0) = arg2;
    }

    public fun settle_deposit_ticket<T0>(arg0: &mut MultiAssetVault<T0>, arg1: DepositTicket<T0>) : 0x2::balance::Balance<T0> {
        check_deposit_ticket_fulfilled<T0>(arg0, &arg1.deposited_types);
        let DepositTicket {
            deposited_types : _,
            minted_yt_amt   : v1,
        } = arg1;
        0x2::coin::mint_balance<T0>(&mut arg0.lp_treasury, v1)
    }

    public fun settle_withdraw_ticket<T0>(arg0: &mut MultiAssetVault<T0>, arg1: WithdrawTicket<T0>) {
        assert!(0x2::bag::is_empty(&arg1.withdraw_infos) && supported_assets<T0>(arg0) == *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.claimed), 116);
        let WithdrawTicket {
            withdraw_infos : v0,
            claimed        : _,
            lp_to_burn     : v2,
        } = arg1;
        0x2::bag::destroy_empty(v0);
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.lp_treasury), v2);
        arg0.withdraw_ticket_issued = false;
    }

    public fun strategies<T0>(arg0: &MultiAssetVault<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, MultiAssetStrategyState> {
        &arg0.strategies
    }

    public fun strategy_borrow<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &VaultAccess, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 108);
        increase_borrowed<T0, T1>(arg0, vault_access_id(arg1), arg2);
        0x2::balance::split<T0>(free_balance_mut<T0, T1>(arg0), arg2)
    }

    public fun strategy_hand_over_profit<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_version<T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 108);
        let v0 = vault_access_id(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v0), 117);
        let v1 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(0x2::balance::value<T0>(&arg2), arg0.performance_fee_bps, 10000);
        let v2 = performance_fee_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v2, 0x2::balance::split<T0>(&mut arg2, v1));
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::event::strategy_profit_event<T0>(vault_access_id(arg1), 0x2::balance::value<T0>(&arg2), v1);
        let v3 = time_locked_profit_mut<T0, T1>(arg0);
        let v4 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::withdraw_all<T0>(v3, arg3);
        let v5 = free_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v5, v4);
        let v6 = arg0.profit_unlock_duration_sec;
        let v7 = time_locked_profit_mut<T0, T1>(arg0);
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::change_unlock_per_second<T0>(v7, 0, arg3);
        let v8 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::skim_extraneous_balance<T0>(v7);
        0x2::balance::join<T0>(&mut v8, arg2);
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::change_unlock_start_ts_sec<T0>(v7, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::timestamp_sec(arg3), arg3);
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::change_unlock_per_second<T0>(v7, 0x2::math::divide_and_round_up(0x2::balance::value<T0>(&v8), v6), arg3);
        0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::top_up<T0>(v7, v8, arg3);
    }

    public fun strategy_repay<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        assert_version<T1>(arg0);
        assert!(arg0.withdraw_ticket_issued == false, 108);
        decrease_borrowed<T0, T1>(arg0, vault_access_id(arg1), 0x2::balance::value<T0>(&arg2));
        0x2::balance::join<T0>(free_balance_mut<T0, T1>(arg0), arg2);
    }

    public fun strategy_withdraw_info<T0, T1>(arg0: &WithdrawTicket<T1>, arg1: 0x2::object::ID) : &StrategyWithdrawInfo<T0> {
        let v0 = withdraw_info<T0, T1>(arg0);
        let (_, v2) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, StrategyWithdrawInfo<T0>>(&v0.strategy_infos, 0x2::vec_map::get_idx<0x2::object::ID, StrategyWithdrawInfo<T0>>(&v0.strategy_infos, &arg1));
        v2
    }

    fun strategy_withdraw_info_mut<T0, T1>(arg0: &mut WithdrawTicket<T1>, arg1: 0x2::object::ID) : &mut StrategyWithdrawInfo<T0> {
        0x2::vec_map::get_mut<0x2::object::ID, StrategyWithdrawInfo<T0>>(&mut withdraw_info_mut<T0, T1>(arg0).strategy_infos, &arg1)
    }

    public fun strategy_withdraw_priority_order<T0>(arg0: &MultiAssetVault<T0>) : vector<0x2::object::ID> {
        arg0.strategy_withdraw_priority_order
    }

    public fun strategy_withdraw_to_ticket<T0, T1>(arg0: &mut WithdrawTicket<T1>, arg1: &VaultAccess, arg2: 0x2::balance::Balance<T0>) {
        let v0 = strategy_withdraw_info_mut<T0, T1>(arg0, vault_access_id(arg1));
        assert!(v0.has_withdrawn == false, 113);
        v0.has_withdrawn = true;
        0x2::balance::join<T0>(&mut v0.withdrawn_balance, arg2);
    }

    public fun supported_assets<T0>(arg0: &MultiAssetVault<T0>) : vector<0x1::type_name::TypeName> {
        0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<u64>>(&arg0.tvl_caps)
    }

    public fun supported_strategies_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, v1);
            let v4 = 0x1::type_name::get<T0>();
            if (0x2::vec_map::contains<0x1::type_name::TypeName, BorrowedInfo>(&v3.borrowed_infos, &v4)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun target_alloc_weight_bps(arg0: &BorrowedInfo) : u64 {
        arg0.target_alloc_weight_bps
    }

    public fun time_locked_profit<T0, T1>(arg0: &MultiAssetVault<T1>) : &0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0>>(&arg0.time_locked_profits, 0x1::type_name::get<T0>())
    }

    fun time_locked_profit_mut<T0, T1>(arg0: &mut MultiAssetVault<T1>) : &mut 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::TimeLockedBalance<T0>>(&mut arg0.time_locked_profits, 0x1::type_name::get<T0>())
    }

    public fun time_locked_profits_contains<T0, T1>(arg0: &MultiAssetVault<T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.time_locked_profits, 0x1::type_name::get<T0>())
    }

    public fun total_available_balance_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0 + 0x2::balance::value<T0>(free_balance<T0, T1>(arg0)) + 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::max_withdrawable<T0>(time_locked_profit<T0, T1>(arg0), arg1);
        let v1 = supported_strategies_by_asset<T0, T1>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            v0 = v0 + borrowed(borrowed_info<T0>(0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, &v3)));
            v2 = v2 + 1;
        };
        v0
    }

    public fun total_yt_supply<T0>(arg0: &MultiAssetVault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury)
    }

    public fun tvl_cap_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::get<T0>();
        *0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<u64>>(&arg0.tvl_caps, &v0)
    }

    public fun tvl_caps_contains<T0, T1>(arg0: &MultiAssetVault<T1>) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<u64>>(&arg0.tvl_caps, &v0)
    }

    fun update_target_alloc_weight_bps(arg0: &mut BorrowedInfo, arg1: u64) {
        arg0.target_alloc_weight_bps = arg1;
    }

    fun update_to_withdraw_by_asset<T0, T1>(arg0: &mut WithdrawTicket<T1>, arg1: 0x2::object::ID, arg2: u64) {
        strategy_withdraw_info_mut<T0, T1>(arg0, arg1).to_withdraw = arg2;
    }

    public fun vault_access_id(arg0: &VaultAccess) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun vault_info_by_asset<T0, T1>(arg0: &MultiAssetVault<T1>) : (u64, u64, u64, u64, u64, bool, u64) {
        let v0 = time_locked_profit<T0, T1>(arg0);
        (0x2::balance::value<T0>(free_balance<T0, T1>(arg0)), 0x2::balance::value<T0>(0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::locked_balance<T0>(v0)), 0x2::balance::value<T0>(0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::unlocked_balance<T0>(v0)), 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::unlock_per_second<T0>(v0), 0x2::balance::value<T0>(performance_fee_balance<T0, T1>(arg0)), arg0.withdraw_ticket_issued, arg0.profit_unlock_duration_sec)
    }

    public fun withdraw<T0, T1>(arg0: &mut MultiAssetVault<T1>, arg1: &mut WithdrawTicket<T1>, arg2: &0x2::clock::Clock) {
        assert_version<T1>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.claimed, &v0), 118);
        assert!(0x2::balance::value<T1>(&arg1.lp_to_burn) > 0, 114);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.claimed, v0);
        initialize_withdraw_ticket_by_asset<T0, T1>(arg0, arg1);
        let v1 = time_locked_profit_mut<T0, T1>(arg0);
        let v2 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::time_locked_balance::withdraw_all<T0>(v1, arg2);
        let v3 = free_balance_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v3, v2);
        let v4 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(0x2::balance::value<T1>(&arg1.lp_to_burn), total_available_balance_by_asset<T0, T1>(arg0, arg2), 0x2::coin::total_supply<T1>(&arg0.lp_treasury));
        let v5 = withdraw_info_mut<T0, T1>(arg1);
        v5.to_withdraw_from_free_balance = 0x2::math::min(v4, 0x2::balance::value<T0>(free_balance<T0, T1>(arg0)));
        let v6 = v4 - withdraw_info<T0, T1>(arg1).to_withdraw_from_free_balance;
        let v7 = v6;
        if (v6 == 0) {
            return
        };
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v10 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v9);
            let v11 = 0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, v10);
            if (borrowed_infos_contains_by_asset<T0>(v11)) {
                let v12 = borrowed_info<T0>(v11);
                let v13 = if (0x1::option::is_some<u64>(&v12.max_borrow)) {
                    let v14 = *0x1::option::borrow<u64>(&v12.max_borrow);
                    if (v12.borrowed > v14) {
                        v12.borrowed - v14
                    } else {
                        0
                    }
                } else {
                    0
                };
                let v15 = if (v13 >= v7) {
                    v7
                } else {
                    v13
                };
                v7 = v7 - v15;
                let v16 = v8 + v12.borrowed;
                v8 = v16 - v13;
                update_to_withdraw_by_asset<T0, T1>(arg1, *v10, v13);
            };
            v9 = v9 + 1;
        };
        if (v7 == 0) {
            return
        };
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v18 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v17);
            let v19 = 0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, v18);
            if (borrowed_infos_contains_by_asset<T0>(v19)) {
                let v20 = borrowed_info<T0>(v19);
                let v21 = strategy_withdraw_info_mut<T0, T1>(arg1, *v18);
                let v22 = 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::utils::mul_div(v20.borrowed - v21.to_withdraw, v7, v8);
                v21.to_withdraw = v21.to_withdraw + v22;
                v7 = v7 - v22;
            };
            v17 = v17 + 1;
        };
        if (v7 == 0) {
            return
        };
        let v23 = 0;
        while (v23 < 0x1::vector::length<0x2::object::ID>(&arg0.strategy_withdraw_priority_order)) {
            let v24 = 0x1::vector::borrow<0x2::object::ID>(&arg0.strategy_withdraw_priority_order, v23);
            let v25 = 0x2::vec_map::get<0x2::object::ID, MultiAssetStrategyState>(&arg0.strategies, v24);
            if (borrowed_infos_contains_by_asset<T0>(v25)) {
                let v26 = borrowed_info<T0>(v25);
                let v27 = strategy_withdraw_info_mut<T0, T1>(arg1, *v24);
                let v28 = 0x2::math::min(v26.borrowed - v27.to_withdraw, v7);
                v27.to_withdraw = v27.to_withdraw + v28;
                let v29 = v7 - v28;
                v7 = v29;
                if (v29 == 0) {
                    break
                };
            };
            v23 = v23 + 1;
        };
    }

    public fun withdraw_info<T0, T1>(arg0: &WithdrawTicket<T1>) : &WithdrawInfo<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, WithdrawInfo<T0>>(&arg0.withdraw_infos, 0x1::type_name::get<T0>())
    }

    fun withdraw_info_mut<T0, T1>(arg0: &mut WithdrawTicket<T1>) : &mut WithdrawInfo<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, WithdrawInfo<T0>>(&mut arg0.withdraw_infos, 0x1::type_name::get<T0>())
    }

    public fun withdraw_infos_contains<T0, T1>(arg0: &WithdrawTicket<T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.withdraw_infos, 0x1::type_name::get<T0>())
    }

    public fun withdraw_performance_fee<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut MultiAssetVault<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T1>(arg1);
        0x2::balance::split<T0>(performance_fee_balance_mut<T0, T1>(arg1), arg2)
    }

    public fun withdraw_ticket_issued<T0>(arg0: &MultiAssetVault<T0>) : bool {
        arg0.withdraw_ticket_issued
    }

    public fun withdraw_ticket_to_withdraw<T0, T1>(arg0: &WithdrawTicket<T1>, arg1: 0x2::object::ID) : u64 {
        if (withdraw_infos_contains<T0, T1>(arg0)) {
            strategy_withdraw_info<T0, T1>(arg0, arg1).to_withdraw
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

