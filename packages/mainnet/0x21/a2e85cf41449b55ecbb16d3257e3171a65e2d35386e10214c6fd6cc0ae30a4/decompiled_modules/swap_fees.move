module 0x21a2e85cf41449b55ecbb16d3257e3171a65e2d35386e10214c6fd6cc0ae30a4::swap_fees {
    struct SwapFeeCap has key {
        id: 0x2::object::UID,
    }

    struct Fees has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun fee_on_exact_sui_in(arg0: &mut Fees, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
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

    public fun take_fee_exact_sui_in(arg0: &mut Fees, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(v0, 0x2::balance::value<0x2::sui::SUI>(v0) * 100 / 10000));
    }

    public fun take_fee_sui_out(arg0: &mut Fees, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(v0, 0x2::balance::value<0x2::sui::SUI>(v0) * 100 / 10000));
    }

    public fun withdraw_fees(arg0: &SwapFeeCap, arg1: &mut Fees, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

