module 0xf7b154d5be5674b1f6e2da59d29d1ef5296103effba7ac32a010b6af02e2482f::bid {
    struct Bid has key {
        id: 0x2::object::UID,
        current_bid_id: u64,
    }

    struct Bidding has store, key {
        id: 0x2::object::UID,
        ask: u64,
        size: u64,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        type: 0x1::string::String,
        owner: address,
    }

    struct AddBidEvent has copy, drop {
        bid_id: u64,
        bidder: address,
        ask: u64,
        size: u64,
        type: 0x1::string::String,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: u64,
        bidder: address,
        ask: u64,
        size: u64,
        type: 0x1::string::String,
    }

    struct ConfirmBidEvent has copy, drop {
        bid_id: u64,
        bidder: address,
        confirmer: address,
        ask: u64,
        remain_size: u64,
        type: 0x1::string::String,
        item_id: 0x2::object::ID,
    }

    public entry fun add_bid<T0>(arg0: &mut Bid, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 * arg2 == 0x2::coin::value<0x2::sui::SUI>(&arg3), 0);
        arg0.current_bid_id = arg0.current_bid_id + 1;
        let v1 = get_type_string<T0>();
        let v2 = Bidding{
            id    : 0x2::object::new(arg4),
            ask   : arg1,
            size  : arg2,
            coin  : arg3,
            type  : v1,
            owner : v0,
        };
        0x2::dynamic_object_field::add<u64, Bidding>(&mut arg0.id, arg0.current_bid_id, v2);
        let v3 = AddBidEvent{
            bid_id : arg0.current_bid_id,
            bidder : v0,
            ask    : arg1,
            size   : arg2,
            type   : v1,
        };
        0x2::event::emit<AddBidEvent>(v3);
    }

    public entry fun cancel_bid<T0>(arg0: &mut Bid, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let Bidding {
            id    : v1,
            ask   : v2,
            size  : v3,
            coin  : v4,
            type  : v5,
            owner : v6,
        } = 0x2::dynamic_object_field::remove<u64, Bidding>(&mut arg0.id, arg1);
        assert!(v0 == v6, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
        0x2::object::delete(v1);
        let v7 = CancelBidEvent{
            bid_id : arg1,
            bidder : v0,
            ask    : v2,
            size   : v3,
            type   : v5,
        };
        0x2::event::emit<CancelBidEvent>(v7);
    }

    public entry fun confirm_bid<T0: store + key>(arg0: &mut 0xf7b154d5be5674b1f6e2da59d29d1ef5296103effba7ac32a010b6af02e2482f::marketplace::Marketplace, arg1: &mut Bid, arg2: u64, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_type_string<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Bidding>(&mut arg1.id, arg2);
        assert!(v2.size > 0, 0);
        assert!(v2.type == v1, 2);
        0xf7b154d5be5674b1f6e2da59d29d1ef5296103effba7ac32a010b6af02e2482f::marketplace::pay<T0>(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v2.coin, v2.ask, arg4), v0, arg4);
        v2.size = v2.size - 1;
        let v3 = ConfirmBidEvent{
            bid_id      : arg2,
            bidder      : v2.owner,
            confirmer   : v0,
            ask         : v2.ask,
            remain_size : v2.size,
            type        : v1,
            item_id     : 0x2::object::id<T0>(&arg3),
        };
        0x2::event::emit<ConfirmBidEvent>(v3);
        0x2::transfer::public_transfer<T0>(arg3, v2.owner);
        if (v2.size == 0) {
            let Bidding {
                id    : v4,
                ask   : _,
                size  : _,
                coin  : v7,
                type  : _,
                owner : _,
            } = 0x2::dynamic_object_field::remove<u64, Bidding>(&mut arg1.id, arg2);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
            0x2::object::delete(v4);
        };
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bid{
            id             : 0x2::object::new(arg0),
            current_bid_id : 0,
        };
        0x2::transfer::share_object<Bid>(v0);
    }

    // decompiled from Move bytecode v6
}

