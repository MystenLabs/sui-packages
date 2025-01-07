module 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event_v2 {
    struct ListedEvent has copy, drop {
        tick: 0x1::ascii::String,
        id: 0x2::object::ID,
        operator: address,
        price: u64,
        inscription_amount: u64,
    }

    struct BuyEvent has copy, drop {
        tick: 0x1::ascii::String,
        beneficiary: address,
        fee: u64,
        id: 0x2::object::ID,
        from: address,
        to: address,
        price: u64,
        unit_price: u64,
    }

    struct DeListedEvent has copy, drop {
        tick: 0x1::ascii::String,
        id: 0x2::object::ID,
        operator: address,
        price: u64,
        amt: u64,
    }

    struct BurnFloorEvent has copy, drop {
        tick: 0x1::ascii::String,
        id: 0x2::object::ID,
        sender: address,
        amt: u64,
        acc: u64,
        cost_sui: u64,
    }

    struct CreateBidEvent has copy, drop {
        tick: 0x1::ascii::String,
        bidder: address,
        unit_price: u64,
        amt: u64,
    }

    struct CancelBidEvent has copy, drop {
        tick: 0x1::ascii::String,
        bidder: address,
        price: u64,
        amt: u64,
    }

    struct AcceptBidEvent has copy, drop {
        tick: 0x1::ascii::String,
        beneficiary: address,
        fee: u64,
        id: 0x2::object::ID,
        from: address,
        to: address,
        price: u64,
        unit_price: u64,
    }

    public(friend) fun accept_bid_event(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: u64, arg7: u64) {
        let v0 = AcceptBidEvent{
            tick        : arg0,
            beneficiary : arg1,
            fee         : arg2,
            id          : arg3,
            from        : arg4,
            to          : arg5,
            price       : arg6,
            unit_price  : arg7,
        };
        0x2::event::emit<AcceptBidEvent>(v0);
    }

    public(friend) fun burn_floor_event(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BurnFloorEvent{
            tick     : arg0,
            id       : arg1,
            sender   : arg2,
            amt      : arg3,
            acc      : arg4,
            cost_sui : arg5,
        };
        0x2::event::emit<BurnFloorEvent>(v0);
    }

    public(friend) fun buy_event(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: address, arg5: address, arg6: u64, arg7: u64) {
        let v0 = BuyEvent{
            tick        : arg0,
            beneficiary : arg1,
            fee         : arg2,
            id          : arg3,
            from        : arg4,
            to          : arg5,
            price       : arg6,
            unit_price  : arg7,
        };
        0x2::event::emit<BuyEvent>(v0);
    }

    public(friend) fun cancel_bid_event(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: u64) {
        let v0 = CancelBidEvent{
            tick   : arg0,
            bidder : arg1,
            price  : arg2,
            amt    : arg3,
        };
        0x2::event::emit<CancelBidEvent>(v0);
    }

    public(friend) fun create_bid_event(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: u64) {
        let v0 = CreateBidEvent{
            tick       : arg0,
            bidder     : arg1,
            unit_price : arg2,
            amt        : arg3,
        };
        0x2::event::emit<CreateBidEvent>(v0);
    }

    public(friend) fun delisted_event(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = DeListedEvent{
            tick     : arg0,
            id       : arg1,
            operator : arg2,
            price    : arg3,
            amt      : arg4,
        };
        0x2::event::emit<DeListedEvent>(v0);
    }

    public(friend) fun list_event(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = ListedEvent{
            tick               : arg0,
            id                 : arg1,
            operator           : arg2,
            price              : arg3,
            inscription_amount : arg4,
        };
        0x2::event::emit<ListedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

