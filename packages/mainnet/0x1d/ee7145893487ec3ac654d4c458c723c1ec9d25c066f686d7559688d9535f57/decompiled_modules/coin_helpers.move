module 0x1dee7145893487ec3ac654d4c458c723c1ec9d25c066f686d7559688d9535f57::coin_helpers {
    public fun calculate_percentage_amount(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) : u64 {
        0x2::coin::value<0x2::sui::SUI>(arg0) * arg1 / 10000
    }

    public fun get_coin_value(arg0: &0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        0x2::coin::value<0x2::sui::SUI>(arg0)
    }

    public fun has_sufficient_balance(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64) : bool {
        0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1
    }

    public fun join_coins(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(arg0, arg1);
    }

    public fun split_by_percentage(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(arg0, calculate_percentage_amount(arg0, arg1), arg2)
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public fun transfer_to_sender(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun zero_coin(arg0: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::zero<0x2::sui::SUI>(arg0)
    }

    // decompiled from Move bytecode v6
}

