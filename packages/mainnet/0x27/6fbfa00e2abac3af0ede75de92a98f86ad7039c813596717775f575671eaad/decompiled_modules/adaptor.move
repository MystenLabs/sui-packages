module 0x276fbfa00e2abac3af0ede75de92a98f86ad7039c813596717775f575671eaad::adaptor {
    struct NaviAdaptor has drop {
        dummy_field: bool,
    }

    struct NaviDeposited has copy, drop {
        account_owner: address,
        asset_id: u8,
        amount: u64,
    }

    struct NaviWithdrawn has copy, drop {
        account_owner: address,
        asset_id: u8,
        amount: u64,
    }

    fun assert_owner(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: address) {
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg0) == arg1, 1);
    }

    public fun deposit<T0>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: address, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        assert_owner(arg1, arg2);
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::assert_external_account_bound_or_owner<NaviAdaptor>(arg0, arg2, arg10);
        let v0 = NaviAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_pay<NaviAdaptor, T0>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_payment<NaviAdaptor, T0>(v0, arg6, arg2), arg10);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg9, arg3, arg4, arg5, v1, arg7, arg8, arg1);
        let v3 = NaviAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_and_clear<NaviAdaptor, T0>(v2, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_receipt_sig<NaviAdaptor, T0>(v3, arg6, arg2));
        let v4 = NaviDeposited{
            account_owner : arg2,
            asset_id      : arg5,
            amount        : arg6,
        };
        0x2::event::emit<NaviDeposited>(v4);
    }

    public fun withdraw<T0>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: address, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: u64, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 > 0, 0);
        assert_owner(arg1, arg2);
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::assert_external_account_bound_or_owner<NaviAdaptor>(arg0, arg2, arg13);
        let v0 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg12, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg1, arg11, arg13), arg13);
        let v1 = 0x2::coin::value<T0>(&v0);
        assert!(v1 >= arg8, 2);
        let v2 = NaviAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::receive_from_service<NaviAdaptor, T0>(arg0, v0, v2);
        let v3 = NaviWithdrawn{
            account_owner : arg2,
            asset_id      : arg6,
            amount        : v1,
        };
        0x2::event::emit<NaviWithdrawn>(v3);
    }

    // decompiled from Move bytecode v7
}

