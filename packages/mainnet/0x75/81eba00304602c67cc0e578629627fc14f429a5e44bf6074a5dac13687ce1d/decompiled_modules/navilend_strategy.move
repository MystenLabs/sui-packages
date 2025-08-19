module 0x7581eba00304602c67cc0e578629627fc14f429a5e44bf6074a5dac13687ce1d::navilend_strategy {
    struct NaviLendingStrategy<phantom T0> has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        vault_access: 0x1::option::Option<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        usdc_index: u8,
        underlying_nominal_value: u64,
        version: u64,
        is_active: bool,
    }

    struct StrategyAdminCap has key {
        id: 0x2::object::UID,
        strategy_id: 0x2::object::ID,
    }

    struct StrategyCreated has copy, drop {
        strategy_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyJoinedVault has copy, drop {
        strategy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct StrategyRebalanced has copy, drop {
        strategy_id: 0x2::object::ID,
        fund_amount: u64,
        defund_amount: u64,
        new_underlying_value: u64,
        timestamp: u64,
    }

    struct PTBWithdrawalExecuted has copy, drop {
        strategy_id: 0x2::object::ID,
        requested_amount: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrawExecuted has copy, drop {
        strategy_id: 0x2::object::ID,
        withdrawn_amount: u64,
        initial_underlying_value: u64,
        timestamp: u64,
    }

    struct StrategyProfitEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        profit_amount: u64,
        timestamp: u64,
    }

    struct RewardsHarvested has copy, drop {
        strategy_id: 0x2::object::ID,
        reward_coin_type: 0x1::ascii::String,
        reward_amount: u64,
        timestamp: u64,
    }

    fun assert_admin<T0>(arg0: &StrategyAdminCap, arg1: &NaviLendingStrategy<T0>) {
        assert!(0x2::object::id<StrategyAdminCap>(arg0) == arg1.admin_cap_id, 3);
    }

    fun assert_navi_incentive_v2(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg0) == @0xf87a8acb8b81d14307894d12595541a73f19933f88e1326d5be349c7a6f7559c, 7);
    }

    fun assert_navi_incentive_v3(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg0) == @0x62982dad27fb10bb314b3384d5de8d2ac2d72ab2dbeae5d801dbdb9efa816c80, 7);
    }

    fun assert_navi_oracle(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) {
        assert!(0x2::object::id_address<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg0) == @0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef, 8);
    }

    fun assert_navi_pool<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg0) == @0xa3582097b4c57630046c0c49a88bfc6b202a3ec0a9db5597c31765f7563755a8, 6);
    }

    fun assert_navi_storage(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg0) == @0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe, 5);
    }

    fun assert_vault_access<T0>(arg0: &NaviLendingStrategy<T0>) {
        assert!(0x1::option::is_some<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access), 10);
    }

    fun assert_version<T0>(arg0: &NaviLendingStrategy<T0>) {
        assert!(arg0.version == 1, 2);
    }

    public fun check_strategy_loss<T0>(arg0: &StrategyAdminCap, arg1: &mut NaviLendingStrategy<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : (bool, u64) {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        assert_vault_access<T0>(arg1);
        assert_navi_storage(arg2);
        assert_navi_pool<T0>(arg3);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg3, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, arg1.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg1.account_cap)) as u64));
        if (v0 == 0 || arg1.underlying_nominal_value == 0) {
            return (false, 0)
        };
        let v1 = arg1.underlying_nominal_value;
        if (v0 < v1) {
            (true, v1 - v0)
        } else {
            (false, 0)
        }
    }

    public fun create_strategy<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xf92f5598caf737db94a4902f927629596a659e695406851d91982cfb55e2bc1, 1);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = StrategyAdminCap{
            id          : 0x2::object::new(arg1),
            strategy_id : v1,
        };
        let v3 = 0x2::object::id<StrategyAdminCap>(&v2);
        let v4 = NaviLendingStrategy<T0>{
            id                       : v0,
            admin_cap_id             : v3,
            vault_access             : 0x1::option::none<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(),
            account_cap              : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            usdc_index               : 10,
            underlying_nominal_value : 0,
            version                  : 1,
            is_active                : true,
        };
        let v5 = StrategyCreated{
            strategy_id  : v1,
            admin_cap_id : v3,
            timestamp    : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<StrategyCreated>(v5);
        0x2::transfer::share_object<NaviLendingStrategy<T0>>(v4);
        0x2::transfer::transfer<StrategyAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun emergency_withdraw<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut NaviLendingStrategy<T0>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        assert_vault_access<T0>(arg1);
        assert_navi_storage(arg3);
        assert_navi_pool<T0>(arg4);
        assert_navi_incentive_v2(arg5);
        assert_navi_incentive_v3(arg6);
        assert_navi_oracle(arg7);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg1.vault_access);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg1.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg1.account_cap)) as u64));
        if (v1 == 0) {
            arg1.underlying_nominal_value = 0;
            let v2 = EmergencyWithdrawExecuted{
                strategy_id              : 0x2::object::id<NaviLendingStrategy<T0>>(arg1),
                withdrawn_amount         : 0,
                initial_underlying_value : arg1.underlying_nominal_value,
                timestamp                : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<EmergencyWithdrawExecuted>(v2);
            return
        };
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg7, arg3, arg4, arg1.usdc_index, v1, arg5, arg6, &arg1.account_cap);
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::emergency_defund_strategy<T0, T1>(arg2, v0, v3, arg8);
        arg1.underlying_nominal_value = 0;
        let v4 = EmergencyWithdrawExecuted{
            strategy_id              : 0x2::object::id<NaviLendingStrategy<T0>>(arg1),
            withdrawn_amount         : 0x2::balance::value<T0>(&v3),
            initial_underlying_value : arg1.underlying_nominal_value,
            timestamp                : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<EmergencyWithdrawExecuted>(v4);
    }

    public fun get_account_owner<T0>(arg0: &NaviLendingStrategy<T0>) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    public fun get_admin_cap_id<T0>(arg0: &NaviLendingStrategy<T0>) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun get_claimable_rewards_info<T0, T1>(arg0: &NaviLendingStrategy<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &0x2::clock::Clock) : (u256, vector<0x1::ascii::String>, vector<vector<address>>) {
        assert_version<T0>(arg0);
        assert_navi_storage(arg1);
        assert_navi_incentive_v3(arg2);
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg3, arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v11 = &v10;
        let v12 = 0;
        let v13 = 0x1::vector::empty<0x1::ascii::String>();
        let v14 = 0x1::vector::empty<vector<address>>();
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::ascii::String>(&v8)) {
            let v16 = *0x1::vector::borrow<u256>(&v7, v15);
            let v17 = *0x1::vector::borrow<u256>(&v6, v15);
            if (0x1::vector::borrow<0x1::ascii::String>(&v8, v15) == v11 && v16 > v17) {
                v12 = v12 + v16 - v17;
                0x1::vector::push_back<0x1::ascii::String>(&mut v13, *0x1::vector::borrow<0x1::ascii::String>(&v9, v15));
                0x1::vector::push_back<vector<address>>(&mut v14, *0x1::vector::borrow<vector<address>>(&v5, v15));
            };
            v15 = v15 + 1;
        };
        (v12, v13, v14)
    }

    public fun get_deposited_balance<T0>(arg0: &NaviLendingStrategy<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, arg0.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64))
    }

    public fun get_strategy_id<T0>(arg0: &NaviLendingStrategy<T0>) : 0x2::object::ID {
        0x2::object::id<NaviLendingStrategy<T0>>(arg0)
    }

    public fun get_strategy_summary<T0>(arg0: &NaviLendingStrategy<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : (u64, u64, bool, u64, bool) {
        (arg0.underlying_nominal_value, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, arg0.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64)), arg0.is_active, arg0.version, 0x1::option::is_some<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access))
    }

    public fun get_strategy_version<T0>(arg0: &NaviLendingStrategy<T0>) : u64 {
        arg0.version
    }

    public fun get_underlying_value<T0>(arg0: &NaviLendingStrategy<T0>) : u64 {
        arg0.underlying_nominal_value
    }

    public fun get_usdc_index<T0>(arg0: &NaviLendingStrategy<T0>) : u8 {
        arg0.usdc_index
    }

    public fun harvest_profit<T0, T1>(arg0: &mut NaviLendingStrategy<T0>, arg1: &StrategyAdminCap, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        assert_admin<T0>(arg1, arg0);
        assert_vault_access<T0>(arg0);
        assert_navi_storage(arg3);
        assert_navi_pool<T0>(arg4);
        assert_navi_incentive_v2(arg5);
        assert_navi_incentive_v3(arg6);
        assert_navi_oracle(arg7);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg0.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64));
        if (v1 == 0 || arg0.underlying_nominal_value == 0) {
            return 0
        };
        let v2 = arg0.underlying_nominal_value;
        if (v1 > v2) {
            let v4 = v1 - v2;
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::add_strategy_profit<T0, T1>(arg2, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg7, arg3, arg4, arg0.usdc_index, v4, arg5, arg6, &arg0.account_cap), arg8);
            let v5 = StrategyProfitEvent{
                vault_id      : 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::vault_id<T0, T1>(arg2),
                strategy_id   : 0x2::object::id<NaviLendingStrategy<T0>>(arg0),
                profit_amount : v4,
                timestamp     : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<StrategyProfitEvent>(v5);
            v4
        } else {
            0
        }
    }

    public fun harvest_rewards<T0, T1>(arg0: &NaviLendingStrategy<T0>, arg1: &StrategyAdminCap, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_version<T0>(arg0);
        assert_admin<T0>(arg1, arg0);
        assert_navi_storage(arg2);
        assert_navi_incentive_v3(arg3);
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg5, arg2, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v11 = &v10;
        let v12 = 0x1::vector::empty<0x1::ascii::String>();
        let v13 = 0x1::vector::empty<address>();
        let v14 = 0;
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::ascii::String>(&v9)) {
            let v16 = 0x1::vector::borrow<0x1::ascii::String>(&v9, v15);
            let v17 = 0x1::vector::borrow<0x1::ascii::String>(&v8, v15);
            let v18 = *0x1::vector::borrow<u256>(&v7, v15);
            let v19 = *0x1::vector::borrow<u256>(&v6, v15);
            let v20 = 0x1::vector::borrow<vector<address>>(&v5, v15);
            if (v18 > v19 && v17 == v11) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, *v16);
                0x1::vector::append<address>(&mut v13, *v20);
                v14 = v14 + v18 - v19;
            };
            v15 = v15 + 1;
        };
        if (0x1::vector::length<0x1::ascii::String>(&v12) == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v21 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T1>(arg5, arg3, arg2, arg4, v12, v13, &arg0.account_cap);
        let v22 = 0x2::balance::value<T1>(&v21);
        if (v22 > 0) {
            let v23 = RewardsHarvested{
                strategy_id      : 0x2::object::id<NaviLendingStrategy<T0>>(arg0),
                reward_coin_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                reward_amount    : v22,
                timestamp        : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<RewardsHarvested>(v23);
        };
        v21
    }

    public fun has_vault_access<T0>(arg0: &NaviLendingStrategy<T0>) : bool {
        0x1::option::is_some<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg0.vault_access)
    }

    public fun is_strategy_active<T0>(arg0: &NaviLendingStrategy<T0>) : bool {
        arg0.is_active
    }

    public fun join_vault<T0, T1>(arg0: &0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::AdminCap, arg1: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T0, T1>, arg2: &StrategyAdminCap, arg3: &mut NaviLendingStrategy<T0>, arg4: &0x2::clock::Clock) {
        assert_version<T0>(arg3);
        assert_admin<T0>(arg2, arg3);
        assert!(0x1::option::is_none<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg3.vault_access), 4);
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::set_target_allocation<T0, T1>(arg0, arg1, 0x2::object::id<NaviLendingStrategy<T0>>(arg3), 3000, arg4);
        0x1::option::fill<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&mut arg3.vault_access, 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::add_strategy<T0, T1>(arg0, arg1, 0x2::object::id<NaviLendingStrategy<T0>>(arg3), b"NAVILENDING_STRATEGY_LENDING_USDC", 5000, arg4));
        let v0 = StrategyJoinedVault{
            strategy_id : 0x2::object::id<NaviLendingStrategy<T0>>(arg3),
            vault_id    : 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::vault_id<T0, T1>(arg1),
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StrategyJoinedVault>(v0);
    }

    entry fun migrate<T0>(arg0: &StrategyAdminCap, arg1: &mut NaviLendingStrategy<T0>) {
        assert_admin<T0>(arg0, arg1);
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public fun ptb_withdraw<T0, T1>(arg0: &mut NaviLendingStrategy<T0>, arg1: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T0, T1>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::WithdrawReceipt<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_vault_access<T0>(arg0);
        assert_navi_storage(arg3);
        assert_navi_pool<T0>(arg4);
        assert_navi_incentive_v2(arg5);
        assert_navi_incentive_v3(arg6);
        assert_navi_oracle(arg7);
        let v0 = 0x2::object::id<NaviLendingStrategy<T0>>(arg0);
        if (!0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::is_strategy_allocated_in_receipt<T0, T1>(arg2, v0)) {
            return
        };
        let v1 = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::get_strategy_allocation_from_receipt<T0, T1>(arg2, v0);
        if (v1 == 0) {
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T0>(), arg9);
            return
        };
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg0.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64));
        if (v2 == 0 || arg0.underlying_nominal_value == 0) {
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T0>(), arg9);
            return
        };
        assert!(v2 >= v1, 9);
        arg0.underlying_nominal_value = v2 - v1;
        0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::update_receipt_after_strategy_withdrawal<T0, T1>(arg1, arg2, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg7, arg3, arg4, arg0.usdc_index, v1, arg5, arg6, &arg0.account_cap), arg9);
        let v3 = PTBWithdrawalExecuted{
            strategy_id      : v0,
            requested_amount : v1,
            timestamp        : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<PTBWithdrawalExecuted>(v3);
    }

    public fun rebalance<T0, T1>(arg0: &StrategyAdminCap, arg1: &mut NaviLendingStrategy<T0>, arg2: &mut 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::Vault<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_admin<T0>(arg0, arg1);
        assert_vault_access<T0>(arg1);
        assert_navi_storage(arg3);
        assert_navi_pool<T0>(arg4);
        assert_navi_incentive_v2(arg5);
        assert_navi_incentive_v3(arg6);
        assert_navi_oracle(arg7);
        let v0 = 0x1::option::borrow<0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::VaultAccess>(&arg1.vault_access);
        let v1 = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::calc_rebalance_amounts<T0, T1>(arg2);
        let (v2, v3) = 0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::rebalance_amounts_get(&v1, v0);
        if (v2 == 0 && v3 == 0) {
            return
        };
        if (v3 > 0) {
            let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg4, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg1.usdc_index, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg1.account_cap)) as u64));
            assert!(v3 <= v4, 9);
            0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::defund_strategy<T0, T1>(arg2, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg7, arg3, arg4, arg1.usdc_index, v3, arg5, arg6, &arg1.account_cap), v3, arg8);
            arg1.underlying_nominal_value = v4 - v3;
        };
        if (v2 > 0) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg8, arg3, arg4, arg1.usdc_index, 0x2::coin::from_balance<T0>(0xdd49ed83e6894fc9ef1166c16f61a8fcc00894f3a663be88d817673f4fdaf3df::usdc_vault::fund_strategy<T0, T1>(arg2, v0, v2, arg8), arg9), arg5, arg6, &arg1.account_cap);
            arg1.underlying_nominal_value = arg1.underlying_nominal_value + v2;
        };
        if (v2 > 0 || v3 > 0) {
            let v5 = StrategyRebalanced{
                strategy_id          : 0x2::object::id<NaviLendingStrategy<T0>>(arg1),
                fund_amount          : v2,
                defund_amount        : v3,
                new_underlying_value : arg1.underlying_nominal_value,
                timestamp            : 0x2::clock::timestamp_ms(arg8),
            };
            0x2::event::emit<StrategyRebalanced>(v5);
        };
    }

    public fun set_strategy_active<T0>(arg0: &StrategyAdminCap, arg1: &mut NaviLendingStrategy<T0>, arg2: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_version<T0>(arg1);
        arg1.is_active = arg2;
    }

    // decompiled from Move bytecode v6
}

