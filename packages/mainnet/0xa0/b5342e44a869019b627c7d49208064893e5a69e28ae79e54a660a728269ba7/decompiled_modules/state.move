module 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::state {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionStateV1 has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        coin_types: vector<0x1::type_name::TypeName>,
        asset_ids: vector<u8>,
        deposits_enabled: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ExtensionStateV1 {
        ExtensionStateV1{
            id               : 0x2::object::new(arg0),
            account_cap      : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
            coin_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            asset_ids        : b"",
            deposits_enabled : true,
        }
    }

    public(friend) fun allow_deposits_of_coin_type_into_navi<T0>(arg0: &mut ExtensionStateV1, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg1, arg2) == 0x1::type_name::into_string(v0), 13835621834164535301);
        assert!(!0x1::vector::contains<u8>(&arg0.asset_ids, &arg2), 13835903322026278919);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coin_types, v0);
        0x1::vector::push_back<u8>(&mut arg0.asset_ids, arg2);
    }

    public(friend) fun claim_rewards<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: vector<0x1::ascii::String>, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg6, arg3, arg1, arg2, arg4, arg5, &arg0.account_cap), arg7)
    }

    public(friend) fun create_extension_key() : ExtensionKey {
        ExtensionKey{dummy_field: false}
    }

    public(friend) fun deposit_into_extension<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock) {
        assert!(arg0.deposits_enabled, 13835340728554881027);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.coin_types;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 8 */
                if (0x1::option::is_none<u64>(&v3)) {
                    abort 13836185617341874185
                };
                0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg6, arg1, arg2, *0x1::vector::borrow<u8>(&arg0.asset_ids, 0x1::option::extract<u64>(&mut v3)), arg5, arg3, arg4, &arg0.account_cap);
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public(friend) fun destroy(arg0: ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        let v0 = &arg0.asset_ids;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            if (!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, *0x1::vector::borrow<u8>(v0, v1), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) == 0)) {
                v2 = false;
                /* label 6 */
                assert!(v2, 13835058540613468161);
                let ExtensionStateV1 {
                    id               : v3,
                    account_cap      : v4,
                    coin_types       : _,
                    asset_ids        : _,
                    deposits_enabled : _,
                } = arg0;
                0x2::transfer::public_transfer<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v4, @0x0);
                0x2::object::delete(v3);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    public(friend) fun disable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = false;
    }

    public(friend) fun enable_deposits(arg0: &mut ExtensionStateV1) {
        arg0.deposits_enabled = true;
    }

    public(friend) fun take_profit<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg7 == 0 || !0x1::vector::contains<0x1::type_name::TypeName>(&arg0.coin_types, &v0)) {
            return 0x2::coin::zero<T0>(arg9)
        };
        let v1 = total_active_liquidity<T0>(arg0, arg1);
        if (v1 <= arg7) {
            return 0x2::coin::zero<T0>(arg9)
        };
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = &arg0.coin_types;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v3)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v3, v4) == &v2) {
                v5 = 0x1::option::some<u64>(v4);
                /* label 14 */
                if (0x1::option::is_none<u64>(&v5)) {
                    abort 13836185617341874185
                };
                return 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg8, arg3, arg1, arg2, *0x1::vector::borrow<u8>(&arg0.asset_ids, 0x1::option::extract<u64>(&mut v5)), v1 - arg7, arg4, arg5, &arg0.account_cap, arg6, arg9), arg9)
            };
            v4 = v4 + 1;
        };
        v5 = 0x1::option::none<u64>();
        /* goto 14 */
    }

    public(friend) fun total_active_liquidity<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.coin_types;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                return if (0x1::option::is_none<u64>(&v3)) {
                    0
                } else {
                    (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg1, *0x1::vector::borrow<u8>(&arg0.asset_ids, 0x1::option::extract<u64>(&mut v3)), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)) as u64)
                }
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun withdraw_from_extension<T0>(arg0: &ExtensionStateV1, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = total_active_liquidity<T0>(arg0, arg1);
        let v1 = 0x1::u64::min(arg7, v0);
        if (v1 == 0) {
            return 0x2::coin::zero<T0>(arg9)
        };
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = &arg0.coin_types;
        let v4 = 0;
        let v5;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(v3)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v3, v4) == &v2) {
                v5 = 0x1::option::some<u64>(v4);
                /* label 8 */
                if (0x1::option::is_none<u64>(&v5)) {
                    abort 13836185617341874185
                };
                return 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg8, arg3, arg1, arg2, *0x1::vector::borrow<u8>(&arg0.asset_ids, 0x1::option::extract<u64>(&mut v5)), v1, arg4, arg5, &arg0.account_cap, arg6, arg9), arg9)
            };
            v4 = v4 + 1;
        };
        v5 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    // decompiled from Move bytecode v6
}

