module 0x16bab6d1097bfec4191cd07880a245fae85810ed35c2b726ebacdc13cc0ced3e::trade_offer {
    struct TradeOffer has key {
        id: 0x2::object::UID,
        maker: address,
        recipient: address,
        expected_items: vector<0x2::object::ID>,
        items: 0x2::object_bag::ObjectBag,
        is_active: bool,
    }

    struct TradeReceipt {
        offer_id: 0x2::object::ID,
        maker: address,
        missing_items: vector<0x2::object::ID>,
        items_to_give: 0x2::object_bag::ObjectBag,
    }

    struct TradeLoot has store, key {
        id: 0x2::object::UID,
        items: 0x2::object_bag::ObjectBag,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        recipient: address,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
    }

    struct OfferRefused has copy, drop {
        offer_id: 0x2::object::ID,
    }

    public fun add_item<T0: store + key>(arg0: &mut TradeOffer, arg1: T0) {
        assert!(!arg0.is_active, 3);
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg0.items, 0x2::object::id<T0>(&arg1), arg1);
    }

    public fun cancel_offer(arg0: TradeOffer, arg1: &mut 0x2::tx_context::TxContext) : TradeLoot {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 2);
        let TradeOffer {
            id             : v0,
            maker          : _,
            recipient      : _,
            expected_items : _,
            items          : v4,
            is_active      : _,
        } = arg0;
        let v6 = v0;
        let v7 = TradeLoot{
            id    : 0x2::object::new(arg1),
            items : v4,
        };
        let v8 = OfferCancelled{offer_id: 0x2::object::uid_to_inner(&v6)};
        0x2::event::emit<OfferCancelled>(v8);
        0x2::object::delete(v6);
        v7
    }

    public fun destroy_empty_loot(arg0: TradeLoot) {
        let TradeLoot {
            id    : v0,
            items : v1,
        } = arg0;
        0x2::object_bag::destroy_empty(v1);
        0x2::object::delete(v0);
    }

    public fun extract_item<T0: store + key>(arg0: &mut TradeLoot, arg1: 0x2::object::ID) : T0 {
        0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg0.items, arg1)
    }

    public fun finalize_acceptance(arg0: TradeReceipt, arg1: &mut 0x2::tx_context::TxContext) : TradeLoot {
        assert!(0x1::vector::is_empty<0x2::object::ID>(&arg0.missing_items), 4);
        let TradeReceipt {
            offer_id      : v0,
            maker         : _,
            missing_items : v2,
            items_to_give : v3,
        } = arg0;
        0x1::vector::destroy_empty<0x2::object::ID>(v2);
        let v4 = TradeLoot{
            id    : 0x2::object::new(arg1),
            items : v3,
        };
        let v5 = OfferAccepted{offer_id: v0};
        0x2::event::emit<OfferAccepted>(v5);
        v4
    }

    public fun new_offer(arg0: address, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : TradeOffer {
        TradeOffer{
            id             : 0x2::object::new(arg2),
            maker          : 0x2::tx_context::sender(arg2),
            recipient      : arg0,
            expected_items : arg1,
            items          : 0x2::object_bag::new(arg2),
            is_active      : false,
        }
    }

    public fun provide_item<T0: store + key>(arg0: &mut TradeReceipt, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.missing_items, &v0);
        assert!(v1, 1);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.missing_items, v2);
        0x2::transfer::public_transfer<T0>(arg1, arg0.maker);
    }

    public fun refuse_offer(arg0: TradeOffer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 0);
        let TradeOffer {
            id             : v0,
            maker          : v1,
            recipient      : _,
            expected_items : _,
            items          : v4,
            is_active      : _,
        } = arg0;
        let v6 = v0;
        let v7 = TradeLoot{
            id    : 0x2::object::new(arg1),
            items : v4,
        };
        let v8 = OfferRefused{offer_id: 0x2::object::uid_to_inner(&v6)};
        0x2::event::emit<OfferRefused>(v8);
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<TradeLoot>(v7, v1);
    }

    public fun share_offer(arg0: TradeOffer) {
        let v0 = 0x2::object_bag::is_empty(&arg0.items) && 0x1::vector::is_empty<0x2::object::ID>(&arg0.expected_items);
        assert!(!v0, 5);
        arg0.is_active = true;
        let v1 = OfferCreated{
            offer_id  : 0x2::object::id<TradeOffer>(&arg0),
            maker     : arg0.maker,
            recipient : arg0.recipient,
        };
        0x2::event::emit<OfferCreated>(v1);
        0x2::transfer::share_object<TradeOffer>(arg0);
    }

    public fun start_acceptance(arg0: TradeOffer, arg1: &mut 0x2::tx_context::TxContext) : TradeReceipt {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 0);
        let TradeOffer {
            id             : v0,
            maker          : v1,
            recipient      : _,
            expected_items : v3,
            items          : v4,
            is_active      : _,
        } = arg0;
        let v6 = v0;
        0x2::object::delete(v6);
        TradeReceipt{
            offer_id      : 0x2::object::uid_to_inner(&v6),
            maker         : v1,
            missing_items : v3,
            items_to_give : v4,
        }
    }

    // decompiled from Move bytecode v7
}

