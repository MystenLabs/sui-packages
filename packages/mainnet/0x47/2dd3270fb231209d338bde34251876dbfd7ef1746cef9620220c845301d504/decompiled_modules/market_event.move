module 0xadc12adb4c58a18fe371e01bcddc0a17d6bfbd9818635dd2727e5eb1dacce50f::market_event {
    struct MarketCreatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        owner: address,
    }

    struct MistListedEvent has copy, drop {
        mist_id: 0x2::object::ID,
        operator: address,
        thousand_per_price: u64,
        mist_balance: u64,
    }

    struct MistBuyEvent has copy, drop {
        mist_id: 0x2::object::ID,
        from: address,
        to: address,
        price: u64,
        thousand_per_price: u64,
    }

    struct CollectionWithdrawalEvent has copy, drop {
        collection_id: 0x2::object::ID,
        from: address,
        to: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        price: u64,
    }

    struct MistDeListedEvent has copy, drop {
        mist_id: 0x2::object::ID,
        operator: address,
        price: u64,
    }

    struct MistModifyPriceEvent has copy, drop {
        mist_id: 0x2::object::ID,
        operator: address,
        price: u64,
    }

    struct MistFloorPriceEvent has copy, drop {
        price: vector<u64>,
        seller: vector<address>,
        mist_id: vector<0x2::object::ID>,
        mist_price: vector<u64>,
        amt: vector<u64>,
    }

    public fun collection_withdrawal(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64) {
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

    public fun market_created_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = MarketCreatedEvent{
            market_id : arg0,
            owner     : arg1,
        };
        0x2::event::emit<MarketCreatedEvent>(v0);
    }

    public fun mist_buy_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = MistBuyEvent{
            mist_id            : arg0,
            from               : arg1,
            to                 : arg2,
            price              : arg3,
            thousand_per_price : arg4,
        };
        0x2::event::emit<MistBuyEvent>(v0);
    }

    public fun mist_delisted_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = MistDeListedEvent{
            mist_id  : arg0,
            operator : arg1,
            price    : arg2,
        };
        0x2::event::emit<MistDeListedEvent>(v0);
    }

    public fun mist_floor_price_event(arg0: vector<u64>, arg1: vector<address>, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: vector<u64>) {
        let v0 = MistFloorPriceEvent{
            price      : arg0,
            seller     : arg1,
            mist_id    : arg2,
            mist_price : arg3,
            amt        : arg4,
        };
        0x2::event::emit<MistFloorPriceEvent>(v0);
    }

    public fun mist_list_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MistListedEvent{
            mist_id            : arg0,
            operator           : arg1,
            thousand_per_price : arg2,
            mist_balance       : arg3,
        };
        0x2::event::emit<MistListedEvent>(v0);
    }

    public fun mist_modify_price_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = MistModifyPriceEvent{
            mist_id  : arg0,
            operator : arg1,
            price    : arg2,
        };
        0x2::event::emit<MistModifyPriceEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

