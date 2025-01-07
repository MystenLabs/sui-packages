module 0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::credenza_loyalty {
    struct CREDENZA_LOYALTY has drop {
        dummy_field: bool,
    }

    struct LoyaltyConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        coin: 0x2::bag::Bag,
        rate: u64,
    }

    struct PointsAddedEvent has copy, drop {
        user: address,
        event_id: u64,
        amount: u64,
    }

    struct PointsAddedUserEvent has key {
        id: 0x2::object::UID,
        event_id: u64,
        amount: u64,
    }

    struct LoyaltyConfigCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct PointsRedeemedEvent has copy, drop {
        user: address,
        eventId: u64,
        amount: u64,
    }

    public fun add_points(arg0: &mut 0x2::coin::TreasuryCap<CREDENZA_LOYALTY>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<CREDENZA_LOYALTY>(arg0, 0x2::token::transfer<CREDENZA_LOYALTY>(0x2::token::mint<CREDENZA_LOYALTY>(arg0, arg2, arg4), arg1, arg4), arg4);
        let v4 = PointsAddedEvent{
            user     : arg1,
            event_id : arg3,
            amount   : arg2,
        };
        0x2::event::emit<PointsAddedEvent>(v4);
        let v5 = PointsAddedUserEvent{
            id       : 0x2::object::new(arg4),
            event_id : arg3,
            amount   : arg2,
        };
        0x2::transfer::transfer<PointsAddedUserEvent>(v5, arg1);
    }

    public fun convert_points_to_coins<T0>(arg0: &mut 0x2::token::TokenPolicy<CREDENZA_LOYALTY>, arg1: 0x2::token::Token<CREDENZA_LOYALTY>, arg2: &mut LoyaltyConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.rate > 0, 1);
        0x2::tx_context::sender(arg3);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<CREDENZA_LOYALTY>(arg0, 0x2::token::spend<CREDENZA_LOYALTY>(arg1, arg3), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg2.coin, 0x2::object::uid_to_inner(&arg2.id)), 0x2::token::value<CREDENZA_LOYALTY>(&arg1) / arg2.rate, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: CREDENZA_LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LoyaltyConfig{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            coin  : 0x2::bag::new(arg1),
            rate  : 0,
        };
        let v1 = LoyaltyConfigCreatedEvent{id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<LoyaltyConfigCreatedEvent>(v1);
        0x2::transfer::share_object<LoyaltyConfig>(v0);
        let (v2, v3) = 0x2::coin::create_currency<CREDENZA_LOYALTY>(arg0, 0, b"CLT", b"Credenza Loyalty Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        let (v5, v6) = 0x2::token::new_policy<CREDENZA_LOYALTY>(&v4, arg1);
        let v7 = v6;
        let v8 = v5;
        0x2::token::allow<CREDENZA_LOYALTY>(&mut v8, &v7, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREDENZA_LOYALTY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CREDENZA_LOYALTY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<CREDENZA_LOYALTY>>(v7, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<CREDENZA_LOYALTY>(v8);
    }

    public fun redeem_points<T0>(arg0: &mut 0x2::token::TokenPolicy<CREDENZA_LOYALTY>, arg1: 0x2::token::Token<CREDENZA_LOYALTY>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request_mut<CREDENZA_LOYALTY>(arg0, 0x2::token::spend<CREDENZA_LOYALTY>(arg1, arg2), arg2);
    }

    public fun set_coin<T0>(arg0: &mut LoyaltyConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0), 0x2::tx_context::sender(arg3));
        };
        arg0.rate = arg2;
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

