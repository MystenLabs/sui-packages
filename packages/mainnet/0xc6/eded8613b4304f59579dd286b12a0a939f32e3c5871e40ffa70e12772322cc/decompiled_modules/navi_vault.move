module 0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::navi_vault {
    struct NaviVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        asset_id: u8,
        deposits_open: bool,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    public fun admin_claim_rewards<T0, T1, T2>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &NaviVault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg3: vector<0x1::ascii::String>, arg4: vector<address>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::assert_current_version(arg8);
        let v0 = 0x2::coin::from_balance<T2>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg7, arg6, arg5, arg2, arg3, arg4, &arg1.account_cap), arg9);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_rewards_claimed<T2>(0x2::object::id_address<NaviVault<T0, T1>>(arg1), 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun admin_deposit<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &NaviVault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, arg8: &0x2::clock::Clock, arg9: &0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::Version) {
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::assert_current_version(arg9);
        assert!(0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::is_move<T0, T1>(arg7), 13906834801408737283);
        assert!(!0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::can_consoom<T0, T1>(arg7), 13906834805703835653);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg8, arg3, arg4, arg1.asset_id, arg2, arg5, arg6, &arg1.account_cap);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_deposit(0x2::object::id_address<NaviVault<T0, T1>>(arg1), 0x2::coin::value<T0>(&arg2));
        0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg1.id, arg7);
    }

    public fun admin_withdraw<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &NaviVault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::Version, arg10: &mut 0x2::tx_context::TxContext) : (0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, 0x2::coin::Coin<T0>) {
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::assert_current_version(arg9);
        let v0 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg4, arg2, arg3, arg1.asset_id, arg7, arg5, arg6, &arg1.account_cap), arg10);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_withdraw(0x2::object::id_address<NaviVault<T0, T1>>(arg1), 0x2::coin::value<T0>(&v0));
        (0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::create_session<T0, T1>(&arg1.id, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::move_kind(), 0x2::coin::value<T0>(&v0)), v0)
    }

    public fun asset_id<T0, T1>(arg0: &NaviVault<T0, T1>) : u8 {
        arg0.asset_id
    }

    public fun create_vault<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviVault<T0, T1>{
            id            : 0x2::object::new(arg2),
            asset_id      : arg1,
            deposits_open : true,
            account_cap   : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2),
        };
        0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::authorize(arg0, &mut v0.id);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_created<T0, T1>(0x2::object::id_address<NaviVault<T0, T1>>(&v0));
        0x2::transfer::share_object<NaviVault<T0, T1>>(v0);
    }

    public fun deposit<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.asset_id, arg1, arg4, arg5, &arg0.account_cap);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_deposit(0x2::object::id_address<NaviVault<T0, T1>>(arg0), 0x2::coin::value<T0>(&arg1));
    }

    public fun deposits_open<T0, T1>(arg0: &NaviVault<T0, T1>) : bool {
        arg0.deposits_open
    }

    public fun public_deposit<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::Version) : 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1> {
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::assert_current_version(arg8);
        assert!(deposits_open<T0, T1>(arg0), 13906834621019979777);
        let v0 = 0x2::coin::value<T0>(&arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg2, arg3, arg0.asset_id, arg1, arg4, arg5, &arg0.account_cap);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_deposit(0x2::object::id_address<NaviVault<T0, T1>>(arg0), v0);
        let v1 = 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::create_session<T0, T1>(&arg0.id, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::deposit_kind(), v0);
        if (arg6) {
            0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg0.id, &mut v1);
        };
        v1
    }

    public fun public_withdraw<T0, T1>(arg0: &NaviVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::SessionFlow<T0, T1>, arg7: &0x2::clock::Clock, arg8: &0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::version::assert_current_version(arg8);
        assert!(0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::is_withdrawal<T0, T1>(arg6), 13906834960322527235);
        assert!(!0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::can_consoom<T0, T1>(arg6), 13906834964617625605);
        let v0 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg7, arg3, arg1, arg2, arg0.asset_id, 0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::value<T0, T1>(arg6), arg4, arg5, &arg0.account_cap), arg9);
        0x2662bcdf06c7b58473eb9f6215b81b45f97a4e86bb566e988c60032fd21fca57::session_flow::allow_consoom<T0, T1>(&arg0.id, arg6);
        0x1b4f035dea5174306b438f63e6d3a9e60a33eea28bb40d9f5ad01dea42037da1::events::navi_vault_withdraw(0x2::object::id_address<NaviVault<T0, T1>>(arg0), 0x2::coin::value<T0>(&v0));
        v0
    }

    public fun toggle_deposits<T0, T1>(arg0: &0x58e1e537fb40c9e8fba75714cd06338ae43a86d1b00a29272dcbcd2ac5742dd1::admin::AdminCap, arg1: &mut NaviVault<T0, T1>, arg2: bool) {
        arg1.deposits_open = arg2;
    }

    public fun total_assets<T0, T1>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviVault<T0, T1>) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1.asset_id, 0x2::object::id_address<NaviVault<T0, T1>>(arg1));
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

