module 0x62bab40d730d86d485b27683ae97def1b5839f8f8d47f9e9fad4d00da239a28b::umi_aggregator {
    public fun swap_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x62bab40d730d86d485b27683ae97def1b5839f8f8d47f9e9fad4d00da239a28b::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun swpa_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x62bab40d730d86d485b27683ae97def1b5839f8f8d47f9e9fad4d00da239a28b::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

