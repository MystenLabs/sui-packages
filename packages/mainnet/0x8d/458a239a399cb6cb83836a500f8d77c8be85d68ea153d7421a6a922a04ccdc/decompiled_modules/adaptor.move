module 0x8d458a239a399cb6cb83836a500f8d77c8be85d68ea153d7421a6a922a04ccdc::adaptor {
    struct ZoBudgetAdaptor has drop {
        dummy_field: bool,
    }

    struct ZoTradingBudget has key {
        id: 0x2::object::UID,
        parent_wallet_identity: address,
        trading_account: address,
    }

    public fun adopt(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        let v0 = ZoTradingBudget{
            id                     : 0x2::object::new(arg2),
            parent_wallet_identity : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0),
            trading_account        : arg1,
        };
        0x2::transfer::share_object<ZoTradingBudget>(v0);
        0x2::object::id<ZoTradingBudget>(&v0)
    }

    public fun assert_parent(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &ZoTradingBudget) {
        assert!(arg1.parent_wallet_identity == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::identity(arg0), 1);
    }

    public fun fund<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &ZoTradingBudget, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert_parent(arg0, arg1);
        let v0 = arg1.trading_account;
        let v1 = ZoBudgetAdaptor{dummy_field: false};
        let (v2, v3) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<ZoBudgetAdaptor, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<ZoBudgetAdaptor, T0>(v1, arg2, v0), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg1.trading_account);
        let v4 = ZoBudgetAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<ZoBudgetAdaptor, T0>(v3, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<ZoBudgetAdaptor, T0>(v4, arg2, v0));
    }

    public fun parent_identity(arg0: &ZoTradingBudget) : address {
        arg0.parent_wallet_identity
    }

    public fun reclaim(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: ZoTradingBudget, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, &arg1);
        let ZoTradingBudget {
            id                     : v0,
            parent_wallet_identity : _,
            trading_account        : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun set_account(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &mut ZoTradingBudget, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0), 0);
        assert_parent(arg0, arg1);
        arg1.trading_account = arg2;
    }

    public fun trading_account(arg0: &ZoTradingBudget) : address {
        arg0.trading_account
    }

    // decompiled from Move bytecode v7
}

