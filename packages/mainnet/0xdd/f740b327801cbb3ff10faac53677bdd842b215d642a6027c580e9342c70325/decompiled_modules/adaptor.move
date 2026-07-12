module 0xddf740b327801cbb3ff10faac53677bdd842b215d642a6027c580e9342c70325::adaptor {
    struct BrokerFinanceAdaptor has drop {
        dummy_field: bool,
    }

    public fun create_buy<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::config::GlobalConfig, arg2: &mut 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::registry::OrderRegistry, arg3: u64, arg4: u64, arg5: 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::order::Expiry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = BrokerFinanceAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BrokerFinanceAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BrokerFinanceAdaptor, T0>(v1, arg3, v0), arg7);
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::order::create_buy<T0, T1>(arg1, arg2, v2, v0, v0, arg4, arg5, arg6, arg7);
        let v4 = BrokerFinanceAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BrokerFinanceAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BrokerFinanceAdaptor, T0>(v4, arg3, v0));
    }

    public fun create_sell<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::config::GlobalConfig, arg2: &mut 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::registry::OrderRegistry, arg3: u64, arg4: u64, arg5: 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::order::Expiry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = BrokerFinanceAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BrokerFinanceAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BrokerFinanceAdaptor, T0>(v1, arg3, v0), arg7);
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::order::create_sell<T0, T1>(arg1, arg2, v2, v0, v0, arg4, arg5, arg6, arg7);
        let v4 = BrokerFinanceAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BrokerFinanceAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BrokerFinanceAdaptor, T0>(v4, arg3, v0));
    }

    // decompiled from Move bytecode v7
}

