module 0xb88f9149c55d6314b7ae436a730cfbf3a5d53522f37e2d56288531bb8adc7071::market_event {
    struct MarketCreatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        owner: address,
    }

    struct ListedEvent has copy, drop {
        id: 0x2::object::ID,
        operator: address,
        price: u64,
        inscription_amount: u64,
    }

    struct BuyEvent has copy, drop {
        id: 0x2::object::ID,
        from: address,
        to: address,
        price: u64,
        per_price: u64,
    }

    struct CollectionWithdrawalEvent has copy, drop {
        collection_id: 0x2::object::ID,
        from: address,
        to: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    struct DeListedEvent has copy, drop {
        id: 0x2::object::ID,
        operator: address,
        price: u64,
    }

    struct BurnFloorEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        amt: u64,
        acc: u64,
        cost_sui: u64,
    }

    struct ModifyPriceEvent has copy, drop {
        id: 0x2::object::ID,
        operator: address,
        price: u64,
    }

    struct FloorPriceEvent has copy, drop {
        price: vector<u64>,
        seller: vector<address>,
        object_id: vector<0x2::object::ID>,
        unit_price: vector<u64>,
        amt: vector<u64>,
        acc: vector<u64>,
    }

    struct ListingInfoEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public(friend) fun burn_floor_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BurnFloorEvent{
            id       : arg0,
            sender   : arg1,
            amt      : arg2,
            acc      : arg3,
            cost_sui : arg4,
        };
        0x2::event::emit<BurnFloorEvent>(v0);
    }

    public(friend) fun buy_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = BuyEvent{
            id        : arg0,
            from      : arg1,
            to        : arg2,
            price     : arg3,
            per_price : arg4,
        };
        0x2::event::emit<BuyEvent>(v0);
    }

    public(friend) fun collection_withdrawal(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64) {
        let v0 = CollectionWithdrawalEvent{
            collection_id : arg0,
            from          : arg1,
            to            : arg2,
            nft_type      : arg3,
            ft_type       : arg4,
            price         : arg5,
        };
        0x2::event::emit<CollectionWithdrawalEvent>(v0);
    }

    public(friend) fun delisted_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = DeListedEvent{
            id       : arg0,
            operator : arg1,
            price    : arg2,
        };
        0x2::event::emit<DeListedEvent>(v0);
    }

    public(friend) fun floor_price_event(arg0: vector<u64>, arg1: vector<address>, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        let v0 = FloorPriceEvent{
            price      : arg0,
            seller     : arg1,
            object_id  : arg2,
            unit_price : arg3,
            amt        : arg4,
            acc        : arg5,
        };
        0x2::event::emit<FloorPriceEvent>(v0);
    }

    public(friend) fun list_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ListedEvent{
            id                 : arg0,
            operator           : arg1,
            price              : arg2,
            inscription_amount : arg3,
        };
        0x2::event::emit<ListedEvent>(v0);
    }

    public(friend) fun listing_info_event(arg0: 0x2::object::ID) {
        let v0 = ListingInfoEvent{id: arg0};
        0x2::event::emit<ListingInfoEvent>(v0);
    }

    public(friend) fun market_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = MarketCreatedEvent{
            market_id : arg0,
            owner     : arg1,
        };
        0x2::event::emit<MarketCreatedEvent>(v0);
    }

    public(friend) fun modify_price_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ModifyPriceEvent{
            id       : arg0,
            operator : arg1,
            price    : arg2,
        };
        0x2::event::emit<ModifyPriceEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

