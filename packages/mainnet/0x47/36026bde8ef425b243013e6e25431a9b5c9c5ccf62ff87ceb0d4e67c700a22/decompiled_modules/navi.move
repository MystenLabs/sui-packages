module 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::navi {
    struct AccountKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun borrow<T0>(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = authorize<T0>(arg0, arg3, arg4, 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::borrow(), arg8, arg9);
        let v1 = account_cap(arg0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap_v2<T0>(arg9, arg1, arg2, arg3, arg4, arg8, arg5, arg6, v1, arg7, arg10);
        assert_health(v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v1), arg9, arg1, arg2);
        v2
    }

    fun authorize<T0>(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : u256 {
        let v0 = 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::policies::borrow_mut<0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::LendingPolicy<T0>>(0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::policies_mut(arg0));
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::authorize<T0>(v0, 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::controller(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>>(arg1), arg2, arg3, arg4, arg5);
        0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::min_health_factor<T0>(v0)
    }

    public(friend) fun repay<T0>(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0x2::balance::Balance<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        authorize<T0>(arg0, arg3, arg4, 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::repay(), 0x2::balance::value<T0>(&arg7), arg8);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T0>(arg8, arg1, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(arg7, arg9), arg5, arg6, account_cap(arg0))
    }

    public(friend) fun supply<T0>(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg2, arg3, 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::supply(), 0x2::balance::value<T0>(&arg6), arg7);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg6, arg8), arg4, arg5, account_cap(arg0));
    }

    public(friend) fun withdraw<T0>(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = authorize<T0>(arg0, arg3, arg4, 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::lending_policy::withdraw(), arg8, arg9);
        let v1 = account_cap(arg0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg9, arg1, arg2, arg3, arg4, arg8, arg5, arg6, v1, arg7, arg10);
        assert_health(v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v1), arg9, arg1, arg2);
        v2
    }

    fun account_cap(arg0: &0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control) : &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        let v0 = 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::positions(arg0);
        let v1 = AccountKey{dummy_field: false};
        assert!(0x2::bag::contains_with_type<AccountKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0, v1), 2);
        let v2 = AccountKey{dummy_field: false};
        0x2::bag::borrow<AccountKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0, v2)
    }

    public fun account_key() : AccountKey {
        AccountKey{dummy_field: false}
    }

    fun assert_health(arg0: u256, arg1: address, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) {
        if (arg0 > 0) {
            assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg2, arg4, arg3, arg1) >= arg0, 0);
        };
    }

    public(friend) fun open(arg0: &mut 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::positions_mut(arg0);
        let v1 = AccountKey{dummy_field: false};
        assert!(!0x2::bag::contains<AccountKey>(v0, v1), 1);
        let v2 = AccountKey{dummy_field: false};
        0x2::bag::add<AccountKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0, v2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1));
    }

    public fun position(arg0: &0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::Control) : 0x1::option::Option<address> {
        let v0 = 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::control::positions(arg0);
        let v1 = AccountKey{dummy_field: false};
        if (0x2::bag::contains_with_type<AccountKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0, v1)) {
            let v3 = AccountKey{dummy_field: false};
            0x1::option::some<address>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x2::bag::borrow<AccountKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v0, v3)))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v7
}

