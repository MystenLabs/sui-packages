module 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::escrow_simple {
    struct Offer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        owner: address,
        item: 0x2::object::ID,
        price: u64,
        market_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        state: u16,
    }

    struct OfferKey<phantom T0: store + key> has copy, drop, store {
        offer: 0x2::object::ID,
        item: 0x2::object::ID,
    }

    struct OfferCap<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        offer: 0x2::object::ID,
    }

    struct Ext has drop {
        dummy_field: bool,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : 0x2::object::id<T0>(&arg2),
        };
        let v1 = 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::remove_simple_offer<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let v2 = v1.market_fee;
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::add_balance(arg0, 0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, v1.price, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<T0>(arg2, v1.owner);
        let Offer {
            id         : v3,
            owner      : v4,
            item       : v5,
            price      : v6,
            market_fee : _,
            balance    : v8,
            state      : _,
        } = v1;
        0x2::object::delete(v3);
        let v10 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v4);
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::escrow::emit_accept_offer_event(0x2::object::id<0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace>(arg0), arg1, v5, v6, 0, v2);
    }

    public fun decline_offer<T0: store + key>(arg0: &mut 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: &T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : 0x2::object::id<T0>(arg2),
        };
        let v1 = 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::remove_simple_offer<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let v2 = 0x2::object::id<Offer<T0>>(&v1);
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::escrow::emit_decline_offer_event(0x2::object::id<0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace>(arg0), v2, 0x2::object::id<T0>(arg2), v1.price, 0, v1.market_fee);
        v1.state = 1;
        let v3 = OfferKey<T0>{
            offer : v2,
            item  : 0x2::object::id<T0>(arg2),
        };
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::add_simple_offer<OfferKey<T0>, Offer<T0>>(arg0, v3, v1);
    }

    public fun new_offer<T0: store + key>(arg0: &mut 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (Offer<T0>, OfferCap<T0>) {
        let v0 = (((0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg4)) as u128) * (arg2 as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg2 + v0, 411);
        let v1 = Offer<T0>{
            id         : 0x2::object::new(arg4),
            owner      : 0x2::tx_context::sender(arg4),
            item       : arg1,
            price      : arg2,
            market_fee : v0,
            balance    : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            state      : 0,
        };
        let v2 = OfferCap<T0>{
            id    : 0x2::object::new(arg4),
            offer : 0x2::object::id<Offer<T0>>(&v1),
        };
        (v1, v2)
    }

    public fun offer<T0: store + key>(arg0: &mut 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_offer<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::escrow::emit_offer_event(0x2::object::id<0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace>(arg0), 0x2::object::id<Offer<T0>>(&v3), 0x2::object::id<OfferCap<T0>>(&v2), v3.item, v3.price, 0, v3.market_fee);
        let v4 = OfferKey<T0>{
            offer : 0x2::object::id<Offer<T0>>(&v3),
            item  : arg1,
        };
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::add_simple_offer<OfferKey<T0>, Offer<T0>>(arg0, v4, v3);
        0x2::transfer::transfer<OfferCap<T0>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun revoke_offer<T0: store + key>(arg0: &mut 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: OfferCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.offer == arg1, 100);
        let v0 = OfferKey<T0>{
            offer : arg1,
            item  : arg2,
        };
        let v1 = 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::remove_simple_offer<OfferKey<T0>, Offer<T0>>(arg0, v0);
        let Offer {
            id         : v2,
            owner      : _,
            item       : v4,
            price      : v5,
            market_fee : v6,
            balance    : v7,
            state      : _,
        } = v1;
        0x2::object::delete(v2);
        let OfferCap {
            id    : v9,
            offer : _,
        } = arg3;
        0x2::object::delete(v9);
        0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::escrow::emit_revoke_offer_event(0x2::object::id<0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace::MarketPlace>(arg0), 0x2::object::id<Offer<T0>>(&v1), v4, v5, 0, v6);
        let v11 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v11), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

