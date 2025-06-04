module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::navi_adapter {
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
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolBorrowReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::MultiAssetReceipt,
    }

    struct NaviProtocolSupplyReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolRepayReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::SingleAssetReceipt,
    }

    struct NaviProtocolWithdrawReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::MultiAssetReceipt,
    }

    struct NaviProtocolClaimReceipt {
        info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::MultiAssetReceipt,
    }

    public fun borrow<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolBorrowRequest, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u64, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolBorrowReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_account_cap<NaviProtocolBorrowRequest>(arg0, &arg1, true);
        drop_borrow_request(arg1);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<T0>(arg9, arg7, arg2, arg3, arg8, arg4, arg5, arg6, &v1);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_borrow_receipt(v0);
        let v5 = &mut v4;
        fill_borrow_receipt<T0>(v5, &v1, &v2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolBorrowReceipt>(&mut v3, &v4, v1, arg10);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, NaviProtocolBorrowReceipt>(&mut v3, &v4, v2, arg10);
        (v3, v4)
    }

    public fun borrow_receipt_amounts(arg0: &NaviProtocolBorrowReceipt) : vector<u64> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun borrow_receipt_asset_types(arg0: &NaviProtocolBorrowReceipt) : vector<0x1::type_name::TypeName> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun borrow_receipt_vault_id(arg0: &NaviProtocolBorrowReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    public fun claim<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolClaimRequest, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg6: vector<0x1::ascii::String>, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolClaimReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_account_cap<NaviProtocolClaimRequest>(arg0, &arg1, true);
        drop_claim_request(arg1);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg2, arg4, arg3, arg5, arg6, arg7, &v1);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_claim_receipt(v0);
        let v5 = &mut v4;
        fill_claim_receipt<T0>(v5, &v1, &v2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolClaimReceipt>(&mut v3, &v4, v1, arg8);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, NaviProtocolClaimReceipt>(&mut v3, &v4, v2, arg8);
        (v3, v4)
    }

    public fun claim_receipt_amounts(arg0: &NaviProtocolClaimReceipt) : vector<u64> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun claim_receipt_asset_types(arg0: &NaviProtocolClaimReceipt) : vector<0x1::type_name::TypeName> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun claim_receipt_vault_id(arg0: &NaviProtocolClaimReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    public fun create_account_cap(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolCreateAccountRequest, arg2: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolCreateAccountReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        drop_empty<NaviProtocolCreateAccountRequest>(arg0, &arg1, true);
        drop_create_account_request(arg1);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v3 = new_create_account_receipt(v0);
        let v4 = &mut v3;
        fill_create_account_receipt(v4, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolCreateAccountReceipt>(&mut v2, &v3, v1, arg2);
        (v2, v3)
    }

    public fun create_account_receipt_amount(arg0: &NaviProtocolCreateAccountReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun create_account_receipt_asset_type(arg0: &NaviProtocolCreateAccountReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun create_account_receipt_vault_id(arg0: &NaviProtocolCreateAccountReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public(friend) fun drop_borrow_receipt(arg0: NaviProtocolBorrowReceipt) {
        let NaviProtocolBorrowReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_borrow_request(arg0: NaviProtocolBorrowRequest) {
        let NaviProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: NaviProtocolClaimReceipt) {
        let NaviProtocolClaimReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_claim_request(arg0: NaviProtocolClaimRequest) {
        let NaviProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_create_account_receipt(arg0: NaviProtocolCreateAccountReceipt) {
        let NaviProtocolCreateAccountReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_create_account_request(arg0: NaviProtocolCreateAccountRequest) {
        let NaviProtocolCreateAccountRequest {  } = arg0;
    }

    public(friend) fun drop_empty<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Empty>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::drop_empty_item(v3);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
    }

    public(friend) fun drop_repay_receipt(arg0: NaviProtocolRepayReceipt) {
        let NaviProtocolRepayReceipt {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: NaviProtocolRepayRequest) {
        let NaviProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_receipt(arg0: NaviProtocolSupplyReceipt) {
        let NaviProtocolSupplyReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_single_receipt(v0);
    }

    public(friend) fun drop_supply_request(arg0: NaviProtocolSupplyRequest) {
        let NaviProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: NaviProtocolWithdrawReceipt) {
        let NaviProtocolWithdrawReceipt { info: v0 } = arg0;
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::drop_multiple_receipt(v0);
    }

    public(friend) fun drop_withdraw_request(arg0: NaviProtocolWithdrawRequest) {
        let NaviProtocolWithdrawRequest {  } = arg0;
    }

    fun err_over_repay() {
        abort 1001
    }

    fun err_remaining_unused_asset() {
        abort 1000
    }

    public(friend) fun extract_account_cap<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_inner_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(v3)
    }

    public(friend) fun extract_balance<T0, T1>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: &T0, arg2: bool) : 0x2::balance::Balance<T1> {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::extract_inner_asset<0x2::balance::Balance<T1>>(v3)
    }

    public(friend) fun fill_borrow_receipt<T0>(arg0: &mut NaviProtocolBorrowReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_claim_receipt<T0>(arg0: &mut NaviProtocolClaimReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun fill_create_account_receipt(arg0: &mut NaviProtocolCreateAccountReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_repay_receipt(arg0: &mut NaviProtocolRepayReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_supply_receipt(arg0: &mut NaviProtocolSupplyReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::set_single_receipt_amount(&mut arg0.info, 1);
    }

    public(friend) fun fill_withdraw_receipt<T0>(arg0: &mut NaviProtocolWithdrawReceipt, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg2: &0x2::balance::Balance<T0>) {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_amount(&mut arg0.info, 0x2::balance::value<T0>(arg2));
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>());
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::add_multiple_receipt_asset_type(&mut arg0.info, 0x1::type_name::get<0x2::balance::Balance<T0>>());
    }

    public(friend) fun new_borrow_receipt(arg0: 0x2::object::ID) : NaviProtocolBorrowReceipt {
        NaviProtocolBorrowReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_borrow_request() : NaviProtocolBorrowRequest {
        NaviProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt(arg0: 0x2::object::ID) : NaviProtocolClaimReceipt {
        NaviProtocolClaimReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_claim_request() : NaviProtocolClaimRequest {
        NaviProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_create_account_receipt(arg0: 0x2::object::ID) : NaviProtocolCreateAccountReceipt {
        NaviProtocolCreateAccountReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_create_account_request() : NaviProtocolCreateAccountRequest {
        NaviProtocolCreateAccountRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt(arg0: 0x2::object::ID) : NaviProtocolRepayReceipt {
        NaviProtocolRepayReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_repay_request() : NaviProtocolRepayRequest {
        NaviProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_receipt(arg0: 0x2::object::ID) : NaviProtocolSupplyReceipt {
        NaviProtocolSupplyReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_single_asset_receipt(arg0, 0x1::type_name::get<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(), 0x1::option::none<u64>())}
    }

    public(friend) fun new_supply_request() : NaviProtocolSupplyRequest {
        NaviProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt(arg0: 0x2::object::ID) : NaviProtocolWithdrawReceipt {
        NaviProtocolWithdrawReceipt{info: 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::new_multiple_asset_receipt(arg0, 0x1::option::none<vector<0x1::type_name::TypeName>>(), 0x1::option::none<vector<u64>>())}
    }

    public(friend) fun new_withdraw_request() : NaviProtocolWithdrawRequest {
        NaviProtocolWithdrawRequest{dummy_field: false}
    }

    public fun repay<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolRepayRequest, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolRepayReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_account_cap<NaviProtocolRepayRequest>(arg0, &arg1, false);
        drop_repay_request(arg1);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T0>(arg8, arg6, arg2, arg3, arg7, 0x2::coin::from_balance<T0>(extract_balance<NaviProtocolRepayRequest, T0>(arg0, &arg1, true), arg9), arg4, arg5, &v1);
        if (0x2::balance::value<T0>(&v2) != 0) {
            err_over_repay();
        };
        0x2::balance::destroy_zero<T0>(v2);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_repay_receipt(v0);
        let v5 = &mut v4;
        fill_repay_receipt(v5, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolRepayReceipt>(&mut v3, &v4, v1, arg9);
        (v3, v4)
    }

    public fun repay_receipt_amount(arg0: &NaviProtocolRepayReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun repay_receipt_asset_type(arg0: &NaviProtocolRepayReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun repay_receipt_vault_id(arg0: &NaviProtocolRepayReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun supply<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolSupplyRequest, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolSupplyReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_account_cap<NaviProtocolSupplyRequest>(arg0, &arg1, false);
        drop_supply_request(arg1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg7, arg2, arg3, arg4, 0x2::coin::from_balance<T0>(extract_balance<NaviProtocolSupplyRequest, T0>(arg0, &arg1, true), arg8), arg5, arg6, &v1);
        let v2 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v3 = new_supply_receipt(v0);
        let v4 = &mut v3;
        fill_supply_receipt(v4, &v1);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolSupplyReceipt>(&mut v2, &v3, v1, arg8);
        (v2, v3)
    }

    public fun supply_receipt_amount(arg0: &NaviProtocolSupplyReceipt) : u64 {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_amount(arg0.info)
    }

    public fun supply_receipt_asset_type(arg0: &NaviProtocolSupplyReceipt) : 0x1::type_name::TypeName {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_asset_type(arg0.info)
    }

    public fun supply_receipt_vault_id(arg0: &NaviProtocolSupplyReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::single_asset_receipt_vault_id(arg0.info)
    }

    public fun withdraw<T0>(arg0: &mut 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, arg1: NaviProtocolWithdrawRequest, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::Collector, NaviProtocolWithdrawReceipt) {
        let v0 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::vault_id(arg0);
        let v1 = extract_account_cap<NaviProtocolWithdrawRequest>(arg0, &arg1, true);
        drop_withdraw_request(arg1);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg9, arg6, arg2, arg3, arg8, arg7, arg4, arg5, &v1);
        let v3 = 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::new(v0);
        let v4 = new_withdraw_receipt(v0);
        let v5 = &mut v4;
        fill_withdraw_receipt<T0>(v5, &v1, &v2);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, NaviProtocolWithdrawReceipt>(&mut v3, &v4, v1, arg10);
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector::collect_asset<0x2::balance::Balance<T0>, NaviProtocolWithdrawReceipt>(&mut v3, &v4, v2, arg10);
        (v3, v4)
    }

    public fun withdraw_receipt_amounts(arg0: &NaviProtocolWithdrawReceipt) : vector<u64> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_amounts(arg0.info)
    }

    public fun withdraw_receipt_asset_types(arg0: &NaviProtocolWithdrawReceipt) : vector<0x1::type_name::TypeName> {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_asset_type(arg0.info)
    }

    public fun withdraw_receipt_vault_id(arg0: &NaviProtocolWithdrawReceipt) : 0x2::object::ID {
        0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt::multiple_asset_receipt_vault_id(arg0.info)
    }

    // decompiled from Move bytecode v6
}

