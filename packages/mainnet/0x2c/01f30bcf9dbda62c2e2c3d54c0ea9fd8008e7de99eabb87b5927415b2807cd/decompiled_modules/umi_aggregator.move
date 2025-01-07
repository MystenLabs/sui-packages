module 0x2c01f30bcf9dbda62c2e2c3d54c0ea9fd8008e7de99eabb87b5927415b2807cd::umi_aggregator {
    public fun trade_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c01f30bcf9dbda62c2e2c3d54c0ea9fd8008e7de99eabb87b5927415b2807cd::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun trade_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0x2c01f30bcf9dbda62c2e2c3d54c0ea9fd8008e7de99eabb87b5927415b2807cd::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

