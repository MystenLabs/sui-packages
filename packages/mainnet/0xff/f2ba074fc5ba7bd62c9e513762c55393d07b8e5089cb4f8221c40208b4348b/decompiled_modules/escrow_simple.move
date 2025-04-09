module 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::escrow_simple {
    struct Offer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        owner: address,
        item: 0x2::object::ID,
        item_type: 0x1::string::String,
        price: u64,
        market_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        offer_cap: 0x2::object::ID,
    }

    struct OfferKey<phantom T0: store + key> has copy, drop, store {
        offer: 0x2::object::ID,
        item: 0x2::object::ID,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : 0x2::object::id<T0>(&arg2),
        };
        let v1 = 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::remove_from_marketplace<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let v2 = v1.market_fee;
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::add_balance(arg0, 0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v1.price, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<T0>(arg2, v1.owner);
        let Offer {
            id         : v3,
            owner      : v4,
            item       : v5,
            item_type  : v6,
            price      : v7,
            market_fee : _,
            balance    : v9,
            offer_cap  : v10,
        } = v1;
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::create_receipt<T0>(v10, v4, arg3);
        let v11 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v11), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, 0x2::tx_context::sender(arg3));
        0x2::object::delete(v3);
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::escrow::emit_accept_offer_event(0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace>(arg0), arg1, v5, v6, v7, 0, v2, v10);
    }

    public fun decline_offer<T0: store + key>(arg0: &mut 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: &T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : 0x2::object::id<T0>(arg2),
        };
        let v1 = 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::remove_from_marketplace<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let Offer {
            id         : v2,
            owner      : v3,
            item       : _,
            item_type  : v5,
            price      : v6,
            market_fee : v7,
            balance    : v8,
            offer_cap  : v9,
        } = v1;
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::create_receipt<T0>(v9, v3, arg3);
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::escrow::emit_decline_offer_event(0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace>(arg0), 0x2::object::id<Offer<T0>>(&v1), 0x2::object::id<T0>(arg2), v5, v6, 0, v7, v9);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v3);
        0x2::object::delete(v2);
    }

    fun new_offer<T0: store + key>(arg0: &0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (Offer<T0>, 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::OfferCap) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = (((0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg3)) as u128) * (v1 as u128) / 10000) as u64);
        assert!(v1 >= v2, 411);
        let v3 = Offer<T0>{
            id         : 0x2::object::new(arg3),
            owner      : 0x2::tx_context::sender(arg3),
            item       : arg1,
            item_type  : 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::utils::type_to_string<T0>(),
            price      : v1,
            market_fee : v2,
            balance    : v0,
            offer_cap  : arg1,
        };
        let v4 = 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::create_offer_cap<T0>(0x2::object::uid_to_inner(&v3.id), arg3);
        v3.offer_cap = 0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::OfferCap>(&v4);
        (v3, v4)
    }

    public fun offer<T0: store + key>(arg0: &mut 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_offer<T0>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::escrow::emit_offer_event(0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace>(arg0), 0x2::object::id<Offer<T0>>(&v3), 0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::OfferCap>(&v2), v3.item, v3.item_type, v3.price, 0, v3.market_fee);
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::transfer_offer_cap(v2, arg3);
        let v4 = OfferKey<T0>{
            offer : 0x2::object::id<Offer<T0>>(&v3),
            item  : arg1,
        };
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::add_to_marketplace<OfferKey<T0>, Offer<T0>>(arg0, v4, v3);
    }

    public fun revoke_offer<T0: store + key>(arg0: &mut 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::OfferCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::assert_offer_match(&arg3, arg1);
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : arg2,
        };
        let v1 = 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::remove_from_marketplace<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let Offer {
            id         : v2,
            owner      : _,
            item       : v4,
            item_type  : v5,
            price      : v6,
            market_fee : v7,
            balance    : v8,
            offer_cap  : _,
        } = v1;
        0x2::object::delete(v2);
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::delete_cap(arg3);
        0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::escrow::emit_revoke_offer_event(0x2::object::id<0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace::MarketPlace>(arg0), 0x2::object::id<Offer<T0>>(&v1), v4, v5, v6, 0, v7);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

