module 0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid {
    struct Bid<phantom T0> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        bidder: address,
        funds: 0x2::coin::Coin<T0>,
    }

    public entry fun accept_bid<T0: store + key, T1>(arg0: T0, arg1: &mut Bid<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(&arg0) == arg1.item_id, 0);
        let v0 = 0x2::coin::value<T1>(&arg1.funds);
        0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid_event::bid_complete_event(0x2::object::id<T0>(&arg0), 0x2::object::id<Bid<T1>>(arg1), 0x2::tx_context::sender(arg2), v0);
        0x2::transfer::public_transfer<T0>(arg0, arg1.bidder);
        let v1 = v0 * 150 / 10000;
        0x2::pay::split_and_transfer<T1>(&mut arg1.funds, v1, @0xc9e10333b3360656b67040e121deefbce960ad43cd4c5662e8043ff00da507bf, arg2);
        0x2::pay::split_and_transfer<T1>(&mut arg1.funds, v0 - v1, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun accept_bid_from_market<T0: store + key, T1>(arg0: &mut 0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::market::Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut Bid<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::market::delist<T0, T1>(arg0, arg1, arg3);
        accept_bid<T0, T1>(v0, arg2, arg3);
    }

    public entry fun add_bid_price<T0>(arg0: &mut Bid<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bidder == 0x2::tx_context::sender(arg2), 4);
        0x2::pay::join<T0>(&mut arg0.funds, arg1);
        0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid_event::change_bid_price_event(0x2::object::id<Bid<T0>>(arg0), arg0.item_id, 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg0.funds));
    }

    public entry fun cancel_bid<T0>(arg0: &mut Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bidder == 0x2::tx_context::sender(arg1), 4);
        0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid_event::bid_cancel_event(arg0.item_id, 0x2::object::id<Bid<T0>>(arg0), 0x2::tx_context::sender(arg1));
        0x2::pay::split_and_transfer<T0>(&mut arg0.funds, 0x2::coin::value<T0>(&arg0.funds), 0x2::tx_context::sender(arg1), arg1);
    }

    public entry fun new_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bid<T0>{
            id      : 0x2::object::new(arg2),
            item_id : arg0,
            bidder  : 0x2::tx_context::sender(arg2),
            funds   : arg1,
        };
        0x2::transfer::public_share_object<Bid<T0>>(v0);
        0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid_event::new_bid_event(0x2::object::id<Bid<T0>>(&v0), arg0, 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1));
    }

    public entry fun reduce_bid_price<T0>(arg0: &mut Bid<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.bidder == v0, 4);
        0x2::pay::split_and_transfer<T0>(&mut arg0.funds, arg1, v0, arg2);
        0x61e69e6c64414f86fbdec97e74686736843fb4acfee7aa78f9c3df5c5190d14b::bid_event::change_bid_price_event(0x2::object::id<Bid<T0>>(arg0), arg0.item_id, v0, 0x2::coin::value<T0>(&arg0.funds));
    }

    // decompiled from Move bytecode v6
}

