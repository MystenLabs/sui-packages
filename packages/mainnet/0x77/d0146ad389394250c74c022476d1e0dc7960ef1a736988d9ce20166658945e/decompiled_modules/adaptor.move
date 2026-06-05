module 0x77d0146ad389394250c74c022476d1e0dc7960ef1a736988d9ce20166658945e::adaptor {
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

    public fun begin_swap<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<SwapAggregatorAdaptor, T0, T1>) {
        assert!(arg1 > 0, 0);
        let v0 = SwapAggregatorAdaptor{dummy_field: false};
        let (v1, v2) = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::validate_and_swap_out<SwapAggregatorAdaptor, T0, T1>(arg0, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::request_swap<SwapAggregatorAdaptor, T0, T1>(v0, arg1, arg2), arg3);
        let v3 = AggregatorSwapBegan{
            amount_in      : arg1,
            min_amount_out : arg2,
        };
        0x2::event::emit<AggregatorSwapBegan>(v3);
        (v1, v2)
    }

    public fun finish_swap<T0, T1>(arg0: &mut 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet::Wallet, arg1: 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::WalletSwapWitness<SwapAggregatorAdaptor, T0, T1>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::wallet_swap_witness_amount_in<SwapAggregatorAdaptor, T0, T1>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SwapAggregatorAdaptor{dummy_field: false};
        0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::verify_swap_and_credit<SwapAggregatorAdaptor, T0, T1>(arg0, arg1, 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::intent::create_swap_receipt<SwapAggregatorAdaptor, T0, T1>(v2, v0, v1), arg2);
        let v3 = AggregatorSwapFinished{
            amount_in  : v0,
            amount_out : v1,
        };
        0x2::event::emit<AggregatorSwapFinished>(v3);
    }

    // decompiled from Move bytecode v7
}

