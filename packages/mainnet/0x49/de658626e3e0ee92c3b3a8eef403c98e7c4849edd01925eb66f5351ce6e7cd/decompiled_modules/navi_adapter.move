module 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::navi_adapter {
    struct NaviProtocolCreateAccountRequest {
        dummy_field: bool,
    }

    struct NaviProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct NaviProtocolSupplyRequest {
        dummy_field: bool,
    }

    struct NaviProtocolRepayRequest {
        dummy_field: bool,
    }

    struct NaviProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct NaviProtocolClaimRequest {
        dummy_field: bool,
    }

    struct NaviProtocolCreateAccountReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolBorrowReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::MultiAssetReceipt,
    }

    struct NaviProtocolSupplyReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolRepayReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolWithdrawReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::MultiAssetReceipt,
    }

    struct NaviProtocolClaimReceipt {
        info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::MultiAssetReceipt,
    }

    public fun borrow<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u64, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: u8, arg8: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<T0>(arg8, arg6, arg1, arg2, arg7, arg3, arg4, arg5, arg0)
    }

    public fun claim<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: vector<0x1::ascii::String>, arg6: vector<address>) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg1, arg3, arg2, arg4, arg5, arg6, arg0)
    }

    public fun create_account_cap(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public(friend) fun drop_borrow_receipt(arg0: NaviProtocolBorrowReceipt) {
        let NaviProtocolBorrowReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_borrow_request(arg0: NaviProtocolBorrowRequest) {
        let NaviProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: NaviProtocolClaimReceipt) {
        let NaviProtocolClaimReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_claim_request(arg0: NaviProtocolClaimRequest) {
        let NaviProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_create_account_receipt(arg0: NaviProtocolCreateAccountReceipt) {
        let NaviProtocolCreateAccountReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_repay_receipt(arg0: NaviProtocolRepayReceipt) {
        let NaviProtocolRepayReceipt {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: NaviProtocolRepayRequest) {
        let NaviProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_receipt(arg0: NaviProtocolSupplyReceipt) {
        let NaviProtocolSupplyReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_supply_request(arg0: NaviProtocolSupplyRequest) {
        let NaviProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: NaviProtocolWithdrawReceipt) {
        let NaviProtocolWithdrawReceipt { info: v0 } = arg0;
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_withdraw_request(arg0: NaviProtocolWithdrawRequest) {
        let NaviProtocolWithdrawRequest {  } = arg0;
    }

    public(friend) fun fill_borrow_receipt<T0>(arg0: &mut NaviProtocolBorrowReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_claim_receipt<T0, T1>(arg0: &mut NaviProtocolClaimReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>, arg3: &0x2::balance::Balance<T1>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T1>(arg3));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T1>>());
    }

    public(friend) fun fill_create_account_receipt(arg0: &mut NaviProtocolCreateAccountReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_repay_receipt(arg0: &mut NaviProtocolRepayReceipt) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_supply_receipt(arg0: &mut NaviProtocolSupplyReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_withdraw_receipt<T0>(arg0: &mut NaviProtocolWithdrawReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>) {
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun new_borrow_receipt(arg0: 0x2::object::ID) : NaviProtocolBorrowReceipt {
        NaviProtocolBorrowReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_borrow_request() : NaviProtocolBorrowRequest {
        NaviProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt(arg0: 0x2::object::ID) : NaviProtocolClaimReceipt {
        NaviProtocolClaimReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_claim_request() : NaviProtocolClaimRequest {
        NaviProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_create_account_receipt(arg0: 0x2::object::ID) : NaviProtocolCreateAccountReceipt {
        NaviProtocolCreateAccountReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_create_account_request() : NaviProtocolCreateAccountRequest {
        NaviProtocolCreateAccountRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt(arg0: 0x2::object::ID) : NaviProtocolRepayReceipt {
        NaviProtocolRepayReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_repay_request() : NaviProtocolRepayRequest {
        NaviProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_receipt(arg0: 0x2::object::ID) : NaviProtocolSupplyReceipt {
        NaviProtocolSupplyReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_supply_request() : NaviProtocolSupplyRequest {
        NaviProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt(arg0: 0x2::object::ID) : NaviProtocolWithdrawReceipt {
        NaviProtocolWithdrawReceipt{info: 0x49de658626e3e0ee92c3b3a8eef403c98e7c4849edd01925eb66f5351ce6e7cd::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_withdraw_request() : NaviProtocolWithdrawRequest {
        NaviProtocolWithdrawRequest{dummy_field: false}
    }

    public fun repay<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: 0x2::balance::Balance<T0>, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::balance::destroy_zero<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T0>(arg8, arg5, arg1, arg2, arg7, 0x2::coin::from_balance<T0>(arg6, arg9), arg3, arg4, arg0));
    }

    public fun supply<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: u8, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg1, arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg8), arg5, arg6, arg0);
    }

    public fun withdraw<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg8, arg5, arg1, arg2, arg7, arg6, arg3, arg4, arg0)
    }

    // decompiled from Move bytecode v6
}

