module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::bid_event {
    struct NewBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct ChangeBidPriceEvent has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct BidCompleteEvent has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    struct BidCancelEvent has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
    }

    public fun bid_cancel_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = BidCancelEvent{
            bid_id  : arg1,
            item_id : arg0,
            bidder  : arg2,
        };
        0x2::event::emit<BidCancelEvent>(v0);
    }

    public fun bid_complete_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = BidCompleteEvent{
            bid_id  : arg1,
            item_id : arg0,
            seller  : arg2,
            amount  : arg3,
        };
        0x2::event::emit<BidCompleteEvent>(v0);
    }

    public fun change_bid_price_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = ChangeBidPriceEvent{
            bid_id  : arg0,
            item_id : arg1,
            bidder  : arg2,
            amount  : arg3,
        };
        0x2::event::emit<ChangeBidPriceEvent>(v0);
    }

    public fun new_bid_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = NewBidEvent{
            bid_id  : arg0,
            item_id : arg1,
            bidder  : arg2,
            amount  : arg3,
        };
        0x2::event::emit<NewBidEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

