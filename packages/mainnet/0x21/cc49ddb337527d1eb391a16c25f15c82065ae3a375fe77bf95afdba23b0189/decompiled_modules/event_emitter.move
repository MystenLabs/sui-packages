module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter {
    struct OrderbookCreatedEvent has copy, drop, store {
        nft_type: 0x1::type_name::TypeName,
        ft_type: 0x1::type_name::TypeName,
        book_id: 0x2::object::ID,
    }

    struct OrderPlacedEvent has copy, drop, store {
        book_id: 0x2::object::ID,
        order_id: u64,
        offerer: address,
        offer: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
        consideration: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
    }

    struct OrderCanceledEvent has copy, drop, store {
        book_id: 0x2::object::ID,
        order_id: u64,
    }

    struct OrderFilledEvent has copy, drop, store {
        book_id: 0x2::object::ID,
        order_id: u64,
        offerer: address,
        filler: address,
        offer: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
        consideration: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
    }

    struct OrdersMatchedEvent has copy, drop, store {
        book_id: 0x2::object::ID,
        order_ids: vector<u64>,
    }

    struct PausedEvent has copy, drop, store {
        sender: address,
    }

    struct UnpausedEvent has copy, drop, store {
        sender: address,
    }

    struct UpgradedEvent has copy, drop, store {
        sender: address,
        prev_version: u64,
        new_version: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop, store {
        collection: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CollectRoyaltyFeeEvent has copy, drop, store {
        collection: 0x1::type_name::TypeName,
        beneficiary: address,
        amount: u64,
    }

    public fun emit_collect_protocol_fee_event<T0: store + key>(arg0: u64) {
        let v0 = CollectProtocolFeeEvent{
            collection : 0x1::type_name::get<T0>(),
            amount     : arg0,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v0);
    }

    public fun emit_collect_royalty_fee_event<T0: store + key>(arg0: address, arg1: u64) {
        let v0 = CollectRoyaltyFeeEvent{
            collection  : 0x1::type_name::get<T0>(),
            beneficiary : arg0,
            amount      : arg1,
        };
        0x2::event::emit<CollectRoyaltyFeeEvent>(v0);
    }

    public(friend) fun emit_order_canceled_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OrderCanceledEvent{
            book_id  : arg0,
            order_id : arg1,
        };
        0x2::event::emit<OrderCanceledEvent>(v0);
    }

    public(friend) fun emit_order_filled_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: address, arg4: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, arg5: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item) {
        let v0 = OrderFilledEvent{
            book_id       : arg0,
            order_id      : arg1,
            offerer       : arg2,
            filler        : arg3,
            offer         : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(arg4),
            consideration : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(arg5),
        };
        0x2::event::emit<OrderFilledEvent>(v0);
    }

    public(friend) fun emit_order_placed_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, arg4: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item) {
        let v0 = OrderPlacedEvent{
            book_id       : arg0,
            order_id      : arg1,
            offerer       : arg2,
            offer         : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(arg3),
            consideration : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::clone(arg4),
        };
        0x2::event::emit<OrderPlacedEvent>(v0);
    }

    public(friend) fun emit_orderbook_created_event<T0: store + key, T1>(arg0: 0x2::object::ID) {
        let v0 = OrderbookCreatedEvent{
            nft_type : 0x1::type_name::get<T0>(),
            ft_type  : 0x1::type_name::get<T1>(),
            book_id  : arg0,
        };
        0x2::event::emit<OrderbookCreatedEvent>(v0);
    }

    public(friend) fun emit_orders_matched_event(arg0: 0x2::object::ID, arg1: vector<u64>) {
        let v0 = OrdersMatchedEvent{
            book_id   : arg0,
            order_ids : arg1,
        };
        0x2::event::emit<OrdersMatchedEvent>(v0);
    }

    public fun emit_paused_event(arg0: address) {
        let v0 = PausedEvent{sender: arg0};
        0x2::event::emit<PausedEvent>(v0);
    }

    public fun emit_unpaused_event(arg0: address) {
        let v0 = UnpausedEvent{sender: arg0};
        0x2::event::emit<UnpausedEvent>(v0);
    }

    public fun emit_upgraded_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = UpgradedEvent{
            sender       : arg0,
            prev_version : arg1,
            new_version  : arg2,
        };
        0x2::event::emit<UpgradedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

