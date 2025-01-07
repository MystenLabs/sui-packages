module 0x2e7987a7f1ff7a18dc49a3a6f45274d197155619a38d044c72eea3d83c7085f6::umi_aggregator {
    public fun trade_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2e7987a7f1ff7a18dc49a3a6f45274d197155619a38d044c72eea3d83c7085f6::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun trade_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x2e7987a7f1ff7a18dc49a3a6f45274d197155619a38d044c72eea3d83c7085f6::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

