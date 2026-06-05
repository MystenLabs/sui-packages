module 0xd4bc41e021c2e1cf5c1d914c340cea3c69339f392ce7964645d383bdebf24ef::adaptor {
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

    public fun begin_deposit<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SuilendAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<SuilendAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<SuilendAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = SuilendDepositBegan{
            amount_in      : arg1,
            min_ctoken_out : arg2,
        };
        0x2::event::emit<SuilendDepositBegan>(v3);
        (v1, v2)
    }

    public fun begin_withdraw<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SuilendAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<SuilendAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<SuilendAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = SuilendWithdrawBegan{
            ctoken_in      : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<SuilendWithdrawBegan>(v3);
        (v1, v2)
    }

    public fun finish_deposit<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::wallet_swap_witness_amount_in<SuilendAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SuilendAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<SuilendAdaptor, T0, T1>(arg0, arg1, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<SuilendAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = SuilendDepositFinished{
            amount_in  : v0,
            ctoken_out : v1,
        };
        0x2::event::emit<SuilendDepositFinished>(v3);
    }

    public fun finish_withdraw<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::WalletSwapWitness<SuilendAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::wallet_swap_witness_amount_in<SuilendAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SuilendAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<SuilendAdaptor, T0, T1>(arg0, arg1, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<SuilendAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = SuilendWithdrawFinished{
            ctoken_in  : v0,
            amount_out : v1,
        };
        0x2::event::emit<SuilendWithdrawFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

