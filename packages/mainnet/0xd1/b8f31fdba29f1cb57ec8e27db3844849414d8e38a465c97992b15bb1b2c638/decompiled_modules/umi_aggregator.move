module 0xd1b8f31fdba29f1cb57ec8e27db3844849414d8e38a465c97992b15bb1b2c638::umi_aggregator {
    public fun swap_begin<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd1b8f31fdba29f1cb57ec8e27db3844849414d8e38a465c97992b15bb1b2c638::utils::maybe_split_coins_and_transfer_rest<T0>(arg0, arg1, arg2, arg3)
    }

    public fun swap_end<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        0xd1b8f31fdba29f1cb57ec8e27db3844849414d8e38a465c97992b15bb1b2c638::utils::check_amount_sufficient<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

