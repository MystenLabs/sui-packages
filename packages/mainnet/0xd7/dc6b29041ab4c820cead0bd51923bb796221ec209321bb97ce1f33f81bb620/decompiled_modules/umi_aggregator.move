module 0xd7dc6b29041ab4c820cead0bd51923bb796221ec209321bb97ce1f33f81bb620::umi_aggregator {
    public fun swap_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd7dc6b29041ab4c820cead0bd51923bb796221ec209321bb97ce1f33f81bb620::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun swpa_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0xd7dc6b29041ab4c820cead0bd51923bb796221ec209321bb97ce1f33f81bb620::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

