module 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::navi_simple_compound {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy<phantom T0> has key {
        id: 0x2::object::UID,
        vault_access: 0x1::option::Option<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>,
        navi_pool_id: address,
        navi_asset: u8,
        navi_account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        underlying_nominal_value_t: u64,
        collected_profit_t: 0x2::balance::Balance<T0>,
        collected_profit_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    public(friend) entry fun new<T0>(arg0: &AdminCap, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Strategy<T0>>(new_inner<T0>(arg1, arg2));
    }

    fun assert_navi_incentive_v1(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive>(arg0) == @0xaaf735bf83ff564e1b219a0d644de894ef5bdc4b2250b126b2a46dd002331821, 4);
    }

    fun assert_navi_incentive_v2(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg0) == @0xf87a8acb8b81d14307894d12595541a73f19933f88e1326d5be349c7a6f7559c, 5);
    }

    fun assert_navi_oracle(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) {
        assert!(0x2::object::id_address<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg0) == @0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef, 3);
    }

    fun assert_navi_pool<T0>(arg0: &Strategy<T0>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg1) == arg0.navi_pool_id, 1);
    }

    fun assert_navi_storage(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        assert!(0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg0) == @0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe, 2);
    }

    fun assert_version<T0>(arg0: &Strategy<T0>) {
        assert!(arg0.version == 1, 6);
    }

    public fun collect_incentive_rewards<T0, T1>(arg0: &AdminCap, arg1: &mut Strategy<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_version<T0>(arg1);
        assert_navi_incentive_v2(arg2);
        assert_navi_storage(arg4);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T1>(arg5, arg2, arg3, arg4, arg1.navi_asset, 1, &arg1.navi_account_cap)
    }

    public fun collect_interest_profits<T0>(arg0: &AdminCap, arg1: &mut Strategy<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock) {
        assert_navi_pool<T0>(arg1, arg2);
        assert_navi_storage(arg3);
        assert_navi_oracle(arg4);
        assert_navi_incentive_v1(arg5);
        assert_navi_incentive_v2(arg6);
        let v0 = navi_supply_value_norm(arg3, arg1.navi_asset, &arg1.navi_account_cap);
        let v1 = (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::normal_amount<T0>(arg2, arg1.underlying_nominal_value_t) as u256);
        let v2 = if (v0 > v1) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg7, arg4, arg3, arg2, arg1.navi_asset, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, ((v0 - v1) as u64)), arg5, arg6, &arg1.navi_account_cap)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::balance::join<T0>(&mut arg1.collected_profit_t, v2);
    }

    public fun deposit_sold_profits<T0, T1>(arg0: &AdminCap, arg1: &mut Strategy<T0>, arg2: &mut 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::Vault<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        0x2::balance::join<T0>(&mut arg3, 0x2::balance::withdraw_all<T0>(&mut arg1.collected_profit_t));
        0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::strategy_hand_over_profit<T0, T1>(arg2, 0x1::option::borrow<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(&arg1.vault_access), arg3, arg4);
    }

    fun get_asset_for_navi_pool<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u8 {
        let v0 = 0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg0);
        if (v0 == @0x96df0fce3c471489f4debaaa762cf960b3d97820bd1f3f025ff8190730e958c5) {
            0
        } else if (v0 == @0xa02a98f9c88db51c6f5efaaf2261c81f34dd56d86073387e0ef1805ca22e39c8) {
            1
        } else if (v0 == @0xe060c3b5b8de00fb50511b7a45188c8e34b6995c01f69d98ea5a466fe10d103) {
            2
        } else if (v0 == @0x71b9f6e822c48ce827bceadce82201d6a7559f7b0350ed1daa1dc2ba3ac41b56) {
            3
        } else if (v0 == @0x3c376f857ec4247b8ee456c1db19e9c74e0154d4876915e54221b5052d5b1e2e) {
            4
        } else if (v0 == @0x9790c2c272e15b6bf9b341eb531ef16bcc8ed2b20dfda25d060bf47f5dd88d01) {
            5
        } else {
            assert!(v0 == @0x6fd9cb6ebd76bc80340a9443d72ea0ae282ee20e2fd7544f6ffcd2c070d9557a, 0);
            6
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun join_vault<T0, T1>(arg0: &0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::AdminCap<T1>, arg1: &mut 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::Vault<T0, T1>, arg2: &AdminCap, arg3: &mut Strategy<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg3);
        0x1::option::fill<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(&mut arg3.vault_access, 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::add_strategy<T0, T1>(arg0, arg1, arg4));
    }

    entry fun migrate<T0>(arg0: &AdminCap, arg1: &mut Strategy<T0>) {
        assert!(arg1.version < 1, 7);
        arg1.version = 1;
    }

    fun navi_supply_value_norm(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : u256 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg2));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::ray_math::ray_mul(v0, v2)
    }

    fun navi_withdraw_remaining_supply<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = navi_withdraw_remaining_supply_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::balance::join<T0>(&mut v0, navi_withdraw_remaining_supply_inner<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
        v0
    }

    fun navi_withdraw_remaining_supply_inner<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = navi_supply_value_norm(arg1, arg3, arg6);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg7, arg2, arg1, arg0, arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg0, (v0 as u64)), arg4, arg5, arg6)
    }

    public(friend) entry fun new_and_join_vault<T0, T1>(arg0: &0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::AdminCap<T1>, arg1: &mut 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::Vault<T0, T1>, arg2: &AdminCap, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new_inner<T0>(arg3, arg4);
        let v1 = &mut v0;
        join_vault<T0, T1>(arg0, arg1, arg2, v1, arg4);
        0x2::transfer::share_object<Strategy<T0>>(v0);
    }

    fun new_inner<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : Strategy<T0> {
        Strategy<T0>{
            id                         : 0x2::object::new(arg1),
            vault_access               : 0x1::option::none<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(),
            navi_pool_id               : 0x2::object::id_address<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg0),
            navi_asset                 : get_asset_for_navi_pool<T0>(arg0),
            navi_account_cap           : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            underlying_nominal_value_t : 0,
            collected_profit_t         : 0x2::balance::zero<T0>(),
            collected_profit_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            version                    : 1,
        }
    }

    public fun rebalance<T0, T1>(arg0: &AdminCap, arg1: &mut Strategy<T0>, arg2: &mut 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::Vault<T0, T1>, arg3: &0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::RebalanceAmounts, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert_navi_pool<T0>(arg1, arg4);
        assert_navi_storage(arg5);
        assert_navi_oracle(arg6);
        assert_navi_incentive_v1(arg7);
        assert_navi_incentive_v2(arg8);
        let v0 = 0x1::option::borrow<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(&arg1.vault_access);
        let (v1, v2) = 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::rebalance_amounts_get(arg3, v0);
        if (v2 > 0) {
            let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg9, arg6, arg5, arg4, arg1.navi_asset, v2, arg7, arg8, &arg1.navi_account_cap);
            if (0x2::balance::value<T0>(&v3) > v2) {
                0x2::balance::join<T0>(&mut arg1.collected_profit_t, 0x2::balance::split<T0>(&mut v3, 0x2::balance::value<T0>(&v3) - v2));
            };
            0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::strategy_repay<T0, T1>(arg2, v0, v3);
            arg1.underlying_nominal_value_t = arg1.underlying_nominal_value_t - 0x2::balance::value<T0>(&v3);
        } else if (v1 > 0) {
            let v4 = 0x2::math::min(v1, 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::free_balance<T0, T1>(arg2));
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg9, arg5, arg4, arg1.navi_asset, 0x2::coin::from_balance<T0>(0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::strategy_borrow<T0, T1>(arg2, v0, v4), arg10), arg7, arg8, &arg1.navi_account_cap);
            arg1.underlying_nominal_value_t = arg1.underlying_nominal_value_t + v4;
        };
    }

    public fun remove_from_vault<T0, T1>(arg0: &AdminCap, arg1: &mut Strategy<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock) : 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::StrategyRemovalTicket<T0, T1> {
        assert_version<T0>(arg1);
        assert_navi_pool<T0>(arg1, arg2);
        assert_navi_storage(arg3);
        assert_navi_oracle(arg4);
        assert_navi_incentive_v1(arg5);
        assert_navi_incentive_v2(arg6);
        let v0 = navi_withdraw_remaining_supply<T0>(arg2, arg3, arg4, arg1.navi_asset, arg5, arg6, &arg1.navi_account_cap, arg7);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg1.collected_profit_t));
        arg1.underlying_nominal_value_t = 0;
        0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::new_strategy_removal_ticket<T0, T1>(0x1::option::extract<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(&mut arg1.vault_access), v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Strategy<T0>, arg1: &mut 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::WithdrawTicket<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert_navi_pool<T0>(arg0, arg2);
        assert_navi_storage(arg3);
        assert_navi_oracle(arg4);
        assert_navi_incentive_v1(arg5);
        assert_navi_incentive_v2(arg6);
        let v0 = 0x1::option::borrow<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::VaultAccess>(&arg0.vault_access);
        let v1 = 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::withdraw_ticket_to_withdraw<T0, T1>(arg1, v0);
        if (v1 == 0) {
            return
        };
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg7, arg4, arg3, arg2, arg0.navi_asset, v1, arg5, arg6, &arg0.navi_account_cap);
        if (0x2::balance::value<T0>(&v2) > v1) {
            0x2::balance::join<T0>(&mut arg0.collected_profit_t, 0x2::balance::split<T0>(&mut v2, 0x2::balance::value<T0>(&v2) - v1));
        };
        0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::strategy_withdraw_to_ticket<T0, T1>(arg1, v0, v2);
        arg0.underlying_nominal_value_t = arg0.underlying_nominal_value_t - v1;
    }

    // decompiled from Move bytecode v6
}

