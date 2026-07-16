module 0xbbbd941d7a1e257ae1efa9f8c19e562da571479306ce495f6b11ced919b90df7::adaptor {
    struct BluefinMarginAdaptor has drop {
        dummy_field: bool,
    }

    struct BluefinMarginAccount has key {
        id: 0x2::object::UID,
        parent_wallet_identity: address,
        bluefin_account: address,
    }

    struct BluefinMarginAccountAdopted has copy, drop {
        wallet_id: 0x2::object::ID,
        binding_id: 0x2::object::ID,
        bluefin_account: address,
    }

    public fun adopt(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        let v0 = BluefinMarginAccount{
            id                     : 0x2::object::new(arg2),
            parent_wallet_identity : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0),
            bluefin_account        : arg1,
        };
        let v1 = 0x2::object::id<BluefinMarginAccount>(&v0);
        let v2 = BluefinMarginAccountAdopted{
            wallet_id       : 0x2::object::id<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet>(arg0),
            binding_id      : v1,
            bluefin_account : arg1,
        };
        0x2::event::emit<BluefinMarginAccountAdopted>(v2);
        0x2::transfer::share_object<BluefinMarginAccount>(v0);
        v1
    }

    public fun assert_parent(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &BluefinMarginAccount) {
        assert!(arg1.parent_wallet_identity == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), 1);
    }

    public fun bluefin_account(arg0: &BluefinMarginAccount) : address {
        arg0.bluefin_account
    }

    public fun deposit_margin<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &BluefinMarginAccount, arg2: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 2);
        assert_parent(arg0, arg1);
        let v0 = arg1.parent_wallet_identity;
        let v1 = BluefinMarginAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BluefinMarginAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BluefinMarginAdaptor, T0>(v1, arg4, v0), arg5);
        let v4 = v2;
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::exchange::deposit_to_asset_bank<T0>(arg2, arg3, arg1.bluefin_account, arg4, &mut v4, arg5);
        0x2::coin::destroy_zero<T0>(v4);
        let v5 = BluefinMarginAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BluefinMarginAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BluefinMarginAdaptor, T0>(v5, arg4, v0));
    }

    public fun deposit_margin_e9<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &BluefinMarginAccount, arg2: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 2);
        assert_parent(arg0, arg1);
        let v0 = arg1.parent_wallet_identity;
        let v1 = BluefinMarginAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<BluefinMarginAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<BluefinMarginAdaptor, T0>(v1, arg4, v0), arg6);
        let v4 = v2;
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::exchange::deposit_to_asset_bank<T0>(arg2, arg3, arg1.bluefin_account, arg5, &mut v4, arg6);
        0x2::coin::destroy_zero<T0>(v4);
        let v5 = BluefinMarginAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<BluefinMarginAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<BluefinMarginAdaptor, T0>(v5, arg4, v0));
    }

    public fun parent_identity(arg0: &BluefinMarginAccount) : address {
        arg0.parent_wallet_identity
    }

    public fun reclaim(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: BluefinMarginAccount, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, &arg1);
        let BluefinMarginAccount {
            id                     : v0,
            parent_wallet_identity : _,
            bluefin_account        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun set_account(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut BluefinMarginAccount, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, arg1);
        arg1.bluefin_account = arg2;
    }

    // decompiled from Move bytecode v7
}

