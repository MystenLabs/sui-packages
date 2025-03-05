module 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow_simple {
    struct CollectionOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        market_fee: u64,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        offer_cap: 0x2::object::ID,
    }

    struct OfferWrapper<phantom T0: store + key> {
        offer: CollectionOffer<T0>,
        item_id: 0x2::object::ID,
        seller: address,
    }

    struct OfferKey<phantom T0: store + key> has copy, drop, store {
        offer: 0x2::object::ID,
    }

    struct OfferCap<phantom T0> has key {
        id: 0x2::object::UID,
        offer: 0x2::object::ID,
    }

    struct Receipt<phantom T0> has key {
        id: 0x2::object::UID,
        offer_cap: 0x2::object::ID,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferKey<T0>{offer: arg2};
        let v1 = 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::remove_from_marketplace<OfferKey<T0>, CollectionOffer<T0>>(arg0, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.balance);
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::add_balance(arg0, 0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v1.market_fee, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<T0>(arg1, v1.owner);
        let CollectionOffer {
            id         : v3,
            market_fee : _,
            owner      : v5,
            balance    : v6,
            offer_cap  : v7,
        } = v1;
        let v8 = Receipt<T0>{
            id        : 0x2::object::new(arg3),
            offer_cap : v7,
        };
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow::emit_receipt_created_event<T0>(0x2::object::id<Receipt<T0>>(&v8), v7);
        0x2::transfer::transfer<Receipt<T0>>(v8, v5);
        let v9 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v9), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg3));
        0x2::object::delete(v3);
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow::emit_offer_accepted_event<T0>(arg2, 0x2::object::id<T0>(&arg1), 0x2::tx_context::sender(arg3), v5, v2, v7);
    }

    public fun destroy_offer_cap<T0: store + key>(arg0: OfferCap<T0>, arg1: Receipt<T0>) {
        let OfferCap {
            id    : v0,
            offer : _,
        } = arg0;
        let v2 = v0;
        let Receipt {
            id        : v3,
            offer_cap : v4,
        } = arg1;
        let v5 = v4;
        assert!(0x2::object::uid_as_inner(&v2) == &v5, 414);
        0x2::object::delete(v2);
        0x2::object::delete(v3);
    }

    public fun offer<T0: store + key>(arg0: &mut 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = (((0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg2)) as u128) * (v1 as u128) / 10000) as u64);
        assert!(v1 >= v2, 411);
        let v3 = CollectionOffer<T0>{
            id         : 0x2::object::new(arg2),
            market_fee : v2,
            owner      : 0x2::tx_context::sender(arg2),
            balance    : v0,
            offer_cap  : 0x2::object::id<0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace>(arg0),
        };
        let v4 = OfferCap<T0>{
            id    : 0x2::object::new(arg2),
            offer : 0x2::object::id<CollectionOffer<T0>>(&v3),
        };
        v3.offer_cap = 0x2::object::id<OfferCap<T0>>(&v4);
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow::emit_collection_offer_event<T0>(0x2::object::id<0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace>(arg0), 0x2::object::id<CollectionOffer<T0>>(&v3), 0x2::object::id<OfferCap<T0>>(&v4), v1, v2, 0x2::tx_context::sender(arg2));
        let v5 = OfferKey<T0>{offer: 0x2::object::id<CollectionOffer<T0>>(&v3)};
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::add_to_marketplace<OfferKey<T0>, CollectionOffer<T0>>(arg0, v5, v3);
        0x2::transfer::transfer<OfferCap<T0>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun revoke_offer<T0: store + key>(arg0: &mut 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: OfferCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.offer == arg1, 414);
        let v0 = OfferKey<T0>{offer: arg1};
        let v1 = 0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::marketplace::remove_from_marketplace<OfferKey<T0>, CollectionOffer<T0>>(arg0, v0);
        let CollectionOffer {
            id         : v2,
            market_fee : _,
            owner      : _,
            balance    : v5,
            offer_cap  : _,
        } = v1;
        0x2::object::delete(v2);
        let OfferCap {
            id    : v7,
            offer : _,
        } = arg2;
        0x2::object::delete(v7);
        let v9 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v9), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg3));
        0x84fe9cc034eb3d4bf4e50acd79cbe99974a21f6988a60e4ad1935d3964de4984::collection_escrow::emit_offer_revoked_event<T0>(0x2::object::id<CollectionOffer<T0>>(&v1), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

