module 0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction {
    struct Bid has key {
        id: 0x2::object::UID,
        bidder: address,
        auction_id: 0x2::object::ID,
        bid: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun bid(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Bid{
            id         : 0x2::object::new(arg3),
            bidder     : 0x2::tx_context::sender(arg3),
            auction_id : arg1,
            bid        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<Bid>(v0, arg2);
    }

    public fun create_auction<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::create_auction<T0>(arg0, arg2);
        0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::transfer<T0>(v0, arg1);
        0x2::object::id<0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::Auction<T0>>(&v0)
    }

    public entry fun end_auction<T0: store + key>(arg0: 0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::Auction<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::end_and_destroy_auction<T0>(arg0, arg1);
    }

    public entry fun update_auction<T0: store + key>(arg0: &mut 0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::Auction<T0>, arg1: Bid, arg2: &mut 0x2::tx_context::TxContext) {
        let Bid {
            id         : v0,
            bidder     : v1,
            auction_id : v2,
            bid        : v3,
        } = arg1;
        let v4 = v2;
        assert!(0x2::object::borrow_id<0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::Auction<T0>>(arg0) == &v4, 1);
        0xf7e83bdff289b61a3f3b794943c4f809f950b22abb4938e92a9b96c4b56ea30a::auction_lib::update_auction<T0>(arg0, v1, v3, arg2);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

