module 0x7ae6301f0d0449672e1e2e56f80a3e98a96f3a3fdef2982d29f923400067240f::adaptor {
    struct SuilendAdaptor has drop {
        dummy_field: bool,
    }

    struct SuilendDepositBegan has copy, drop {
        amount_in: u64,
        min_ctoken_out: u64,
    }

    struct SuilendDepositFinished has copy, drop {
        amount_in: u64,
        ctoken_out: u64,
    }

    struct SuilendWithdrawBegan has copy, drop {
        ctoken_in: u64,
        min_amount_out: u64,
    }

    struct SuilendWithdrawFinished has copy, drop {
        ctoken_in: u64,
        amount_out: u64,
    }

    public fun begin_deposit<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SuilendAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<SuilendAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<SuilendAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = SuilendDepositBegan{
            amount_in      : arg1,
            min_ctoken_out : arg2,
        };
        0x2::event::emit<SuilendDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_withdraw<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SuilendAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<SuilendAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<SuilendAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = SuilendWithdrawBegan{
            ctoken_in      : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<SuilendWithdrawBegan>(v3);
        (v1, v2)
    }

    public fun finish_deposit<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::wallet_swap_witness_amount_in<SuilendAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SuilendAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<SuilendAdaptor, T0, T1>(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<SuilendAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = SuilendDepositFinished{
            amount_in  : v0,
            ctoken_out : v1,
        };
        0x2::event::emit<SuilendDepositFinished>(v3);
    }

    public fun finish_withdraw<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::wallet_swap_witness_amount_in<SuilendAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SuilendAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<SuilendAdaptor, T0, T1>(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<SuilendAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = SuilendWithdrawFinished{
            ctoken_in  : v0,
            amount_out : v1,
        };
        0x2::event::emit<SuilendWithdrawFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

