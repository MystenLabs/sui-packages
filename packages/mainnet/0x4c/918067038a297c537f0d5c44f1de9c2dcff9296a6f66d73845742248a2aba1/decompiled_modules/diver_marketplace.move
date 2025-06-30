module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver_marketplace {
    struct DiverMarketplaceListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        diver_id: 0x2::object::ID,
        seller: address,
        price_in_mist: u64,
    }

    struct DiverMarketplaceDelistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        diver_id: 0x2::object::ID,
        seller: address,
        price_in_mist: u64,
    }

    struct DiverMarketplaceBuyEvent has copy, drop {
        listing_id: 0x2::object::ID,
        diver_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price_in_mist: u64,
    }

    struct DIVER_MARKETPLACE has drop {
        dummy_field: bool,
    }

    public fun buy(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::assert_marketplace_state(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_marketplace_type());
        let (v0, v1, v2) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::buy<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(arg0, arg1, arg2, arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::borrow_mut_diver_marketplace_trade_info(arg4), arg6);
        let v3 = DiverMarketplaceBuyEvent{
            listing_id    : v0,
            diver_id      : arg1,
            seller        : v1,
            buyer         : 0x2::tx_context::sender(arg6),
            price_in_mist : v2,
        };
        0x2::event::emit<DiverMarketplaceBuyEvent>(v3);
    }

    public fun delist(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::assert_marketplace_state(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_marketplace_type());
        let (v0, v1, v2) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::delist<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(arg0, arg1, arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::borrow_mut_diver_marketplace_trade_info(arg3), arg5);
        let v3 = DiverMarketplaceDelistEvent{
            listing_id    : v0,
            diver_id      : arg1,
            seller        : v1,
            price_in_mist : v2,
        };
        0x2::event::emit<DiverMarketplaceDelistEvent>(v3);
    }

    fun init(arg0: DIVER_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::init_marketplace(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_marketplace_type(), 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_marketplace_fee(), arg1);
    }

    public fun list(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::Marketplace, arg1: 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver, arg2: u64, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::assert_marketplace_state(arg0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_marketplace_type());
        let (v0, v1) = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::marketplace_base::list<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver::Diver>(arg0, arg1, arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::borrow_mut_diver_marketplace_trade_info(arg3), arg5, arg6);
        let v2 = DiverMarketplaceListEvent{
            listing_id    : v0,
            diver_id      : v1,
            seller        : 0x2::tx_context::sender(arg6),
            price_in_mist : arg2,
        };
        0x2::event::emit<DiverMarketplaceListEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

