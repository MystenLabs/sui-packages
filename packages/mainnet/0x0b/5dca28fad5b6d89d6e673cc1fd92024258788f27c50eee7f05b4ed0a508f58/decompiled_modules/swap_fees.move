module 0xb5dca28fad5b6d89d6e673cc1fd92024258788f27c50eee7f05b4ed0a508f58::swap_fees {
    struct SwapFeeCap has key {
        id: 0x2::object::UID,
    }

    struct Fees has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapFeeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SwapFeeCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Fees{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Fees>(v1);
    }

    public fun take_fee(arg0: &mut Fees, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
        let v1 = v0 * 100 / 10000;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(arg1, v0 - v1, 0x2::tx_context::sender(arg2), arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v1));
    }

    public fun take_fee_on_sui_out(arg0: &mut Fees, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0 - v0 * 100 / 10000, arg2), arg2);
    }

    public fun withdraw_fees(arg0: &SwapFeeCap, arg1: &mut Fees, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

