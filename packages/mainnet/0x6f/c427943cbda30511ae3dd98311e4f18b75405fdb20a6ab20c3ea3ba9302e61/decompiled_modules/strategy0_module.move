module 0x6fc427943cbda30511ae3dd98311e4f18b75405fdb20a6ab20c3ea3ba9302e61::strategy0_module {
    struct OpenPositionEvent has copy, drop {
        sender: address,
    }

    struct ClosePositionEvent has copy, drop {
        sender: address,
    }

    public fun close_position(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = ClosePositionEvent{sender: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<ClosePositionEvent>(v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun open_position(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>> {
        let v0 = OpenPositionEvent{sender: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<OpenPositionEvent>(v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

