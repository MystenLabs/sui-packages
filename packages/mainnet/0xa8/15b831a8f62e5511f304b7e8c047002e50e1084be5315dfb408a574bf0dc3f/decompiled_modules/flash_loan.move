module 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::flash_loan {
    struct FlashLoan<phantom T0> {
        borrowed_amount: u64,
    }

    public fun borrow_x(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>, FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>) {
        let v0 = FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>{borrowed_amount: arg1};
        (0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::take_coin_x(arg0, arg1, arg2), v0)
    }

    public fun borrow_y(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>, FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>) {
        let v0 = FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>{borrowed_amount: arg1};
        (0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::take_coin_y(arg0, arg1, arg2), v0)
    }

    public fun repay_x(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>, arg2: FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>) {
        let FlashLoan { borrowed_amount: v0 } = arg2;
        assert!(v0 == 0x2::coin::value<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>(&arg1), 0);
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::put_coin_x(arg0, arg1);
    }

    public fun repay_y(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>, arg2: FlashLoan<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>) {
        let FlashLoan { borrowed_amount: v0 } = arg2;
        assert!(v0 == 0x2::coin::value<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>(&arg1), 0);
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::put_coin_y(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

