module 0xd51709b7966e43413f17ca44566995bcbc9c298cd0930bd86878539ca6d47c16::adaptor {
    struct SwapAggregatorAdaptor has drop {
        dummy_field: bool,
    }

    struct AggregatorSwapBegan has copy, drop {
        amount_in: u64,
        min_amount_out: u64,
    }

    struct AggregatorSwapFinished has copy, drop {
        amount_in: u64,
        amount_out: u64,
    }

    public fun begin_swap<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SwapAggregatorAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SwapAggregatorAdaptor{dummy_field: false};
        let (v1, v2) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_swap_out<SwapAggregatorAdaptor, T0, T1>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_swap<SwapAggregatorAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = AggregatorSwapBegan{
            amount_in      : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<AggregatorSwapBegan>(v3);
        (v1, v2)
    }

    public fun finish_swap<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::WalletSwapWitness<SwapAggregatorAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::wallet_swap_witness_amount_in<SwapAggregatorAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SwapAggregatorAdaptor{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_swap_and_credit<SwapAggregatorAdaptor, T0, T1>(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_swap_receipt<SwapAggregatorAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = AggregatorSwapFinished{
            amount_in  : v0,
            amount_out : v1,
        };
        0x2::event::emit<AggregatorSwapFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

