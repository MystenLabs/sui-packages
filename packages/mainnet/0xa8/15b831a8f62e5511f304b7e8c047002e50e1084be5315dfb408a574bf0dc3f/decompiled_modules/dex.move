module 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::dex {
    public fun swap_from_x_to_y(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y> {
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::put_coin_x(arg0, arg1);
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::take_coin_y(arg0, 0x2::coin::value<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X>(&arg1) * 1, arg2)
    }

    public fun swap_from_y_to_x(arg0: &mut 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::Pool, arg1: 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_X> {
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::put_coin_y(arg0, arg1);
        0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::take_coin_x(arg0, 0x2::coin::value<0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool::COIN_Y>(&arg1) * 2, arg2)
    }

    // decompiled from Move bytecode v6
}

