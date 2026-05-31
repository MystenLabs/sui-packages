module 0xfcfaf2e52be3f73b3a00ef1fab626fb0b7faca9bb1f729a60bc3cb0553692fad::adaptor {
    struct OsAccountAdaptor has drop {
        dummy_field: bool,
    }

    public fun assert_parent(arg0: &0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::OsAccount) {
        assert!(0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::parent_wallet_identity(arg1) == 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::identity(arg0), 0);
    }

    public fun create_os_account<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &mut 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry::WalletAccountRegistry, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::identity(arg0);
        if (arg4 == 0) {
            return 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::create_and_share_for(arg1, v0, arg2, arg3, arg5, arg6)
        };
        let v1 = 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::new(v0, arg2, arg3, arg5, arg6);
        let v2 = 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::signer_address(&v1);
        let v3 = OsAccountAdaptor{dummy_field: false};
        let (v4, v5) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_pay<OsAccountAdaptor, T0>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_payment<OsAccountAdaptor, T0>(v3, arg4, v2), arg6);
        let v6 = OsAccountAdaptor{dummy_field: false};
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::deposit_for_protocol<OsAccountAdaptor, T0>(&v1, v6, v4);
        let v7 = OsAccountAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_and_clear<OsAccountAdaptor, T0>(v5, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_receipt_sig<OsAccountAdaptor, T0>(v7, arg4, v2));
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::register_and_share(arg1, v1, v0);
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::id(&v1)
    }

    public fun deposit<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::OsAccount, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_parent(arg0, arg1);
        let v0 = 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::signer_address(arg1);
        let v1 = OsAccountAdaptor{dummy_field: false};
        let (v2, v3) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_pay<OsAccountAdaptor, T0>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_payment<OsAccountAdaptor, T0>(v1, arg2, v0), arg3);
        let v4 = OsAccountAdaptor{dummy_field: false};
        0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::deposit_for_protocol<OsAccountAdaptor, T0>(arg1, v4, v2);
        let v5 = OsAccountAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_and_clear<OsAccountAdaptor, T0>(v3, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_receipt_sig<OsAccountAdaptor, T0>(v5, arg2, v0));
    }

    public fun withdraw<T0>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: &mut 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::OsAccount, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_parent(arg0, arg1);
        if (!0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::has_permission(arg1, 0x2::tx_context::sender(arg3), 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::perm_withdraw())) {
            let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::sign(arg0, arg3);
            0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::assert_request(arg1, &v0, 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::perm_withdraw());
        };
        let v1 = OsAccountAdaptor{dummy_field: false};
        let v2 = OsAccountAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::receive_from_service<OsAccountAdaptor, T0>(arg0, 0x2::coin::from_balance<T0>(0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::account::withdraw_for_protocol<OsAccountAdaptor, T0>(arg1, v1, arg2), arg3), v2);
    }

    // decompiled from Move bytecode v7
}

