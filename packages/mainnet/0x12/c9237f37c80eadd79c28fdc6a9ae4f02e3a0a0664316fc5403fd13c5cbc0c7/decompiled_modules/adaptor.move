module 0x12c9237f37c80eadd79c28fdc6a9ae4f02e3a0a0664316fc5403fd13c5cbc0c7::adaptor {
    struct DeepbookMarginAdaptor has drop {
        dummy_field: bool,
    }

    public fun return_to_vault<T0>(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0x2::coin::Coin<T0>) {
        let v0 = DeepbookMarginAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service<DeepbookMarginAdaptor, T0>(arg0, arg1, v0);
    }

    public fun take_collateral<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 0);
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0);
        let v1 = DeepbookMarginAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<DeepbookMarginAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<DeepbookMarginAdaptor, T0>(v1, arg1, v0), arg2);
        let v4 = DeepbookMarginAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<DeepbookMarginAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<DeepbookMarginAdaptor, T0>(v4, arg1, v0));
        v2
    }

    // decompiled from Move bytecode v7
}

