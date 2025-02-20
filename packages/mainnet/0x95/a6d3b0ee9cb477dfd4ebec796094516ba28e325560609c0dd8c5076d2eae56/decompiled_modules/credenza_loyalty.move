module 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::credenza_loyalty {
    struct CREDENZA_LOYALTY has drop {
        dummy_field: bool,
    }

    struct LoyaltyConfig has store, key {
        id: 0x2::object::UID,
        ownership: 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::CredenzaOwnership,
        treasury_cap: 0x2::coin::TreasuryCap<CREDENZA_LOYALTY>,
        lifetime_points: 0x2::table::Table<address, u64>,
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
        amount: u64,
        event_id: u64,
    }

    public fun add_points(arg0: &mut LoyaltyConfig, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg4));
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<CREDENZA_LOYALTY>(&mut arg0.treasury_cap, 0x2::token::transfer<CREDENZA_LOYALTY>(0x2::token::mint<CREDENZA_LOYALTY>(&mut arg0.treasury_cap, arg2, arg4), arg1, arg4), arg4);
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
        let v6 = 0;
        if (0x2::table::contains<address, u64>(&arg0.lifetime_points, arg1)) {
            v6 = 0x2::table::remove<address, u64>(&mut arg0.lifetime_points, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.lifetime_points, arg1, v6 + arg2);
    }

    public fun convert_points_to_coins<T0>(arg0: &mut 0x2::token::TokenPolicy<CREDENZA_LOYALTY>, arg1: 0x2::token::Token<CREDENZA_LOYALTY>, arg2: &mut LoyaltyConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.rate > 0, 1);
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg3),
            amount   : 0x2::token::value<CREDENZA_LOYALTY>(&arg1),
            event_id : 100000000,
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<CREDENZA_LOYALTY>(arg0, 0x2::token::spend<CREDENZA_LOYALTY>(arg1, arg3), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg2.coin, 0x2::object::uid_to_inner(&arg2.id)), 0x2::token::value<CREDENZA_LOYALTY>(&arg1) / arg2.rate, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: CREDENZA_LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREDENZA_LOYALTY>(arg0, 0, b"CLT", b"Credenza Loyalty Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<CREDENZA_LOYALTY>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<CREDENZA_LOYALTY>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        let v7 = 0x2::object::new(arg1);
        let v8 = LoyaltyConfig{
            id              : v7,
            ownership       : 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::create_ownership(0x2::object::uid_to_inner(&v7), arg1),
            treasury_cap    : v2,
            lifetime_points : 0x2::table::new<address, u64>(arg1),
            coin            : 0x2::bag::new(arg1),
            rate            : 0,
        };
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::add_owner(&mut v8.ownership, 0x2::tx_context::sender(arg1));
        let v9 = LoyaltyConfigCreatedEvent{id: 0x2::object::uid_to_inner(&v8.id)};
        0x2::event::emit<LoyaltyConfigCreatedEvent>(v9);
        0x2::transfer::share_object<LoyaltyConfig>(v8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CREDENZA_LOYALTY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<CREDENZA_LOYALTY>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<CREDENZA_LOYALTY>(v6);
    }

    public fun redeem_points(arg0: &mut 0x2::token::TokenPolicy<CREDENZA_LOYALTY>, arg1: 0x2::token::Token<CREDENZA_LOYALTY>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg2),
            amount   : 0x2::token::value<CREDENZA_LOYALTY>(&arg1),
            event_id : 0,
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<CREDENZA_LOYALTY>(arg0, 0x2::token::spend<CREDENZA_LOYALTY>(arg1, arg2), arg2);
    }

    public fun redeem_points_with_event(arg0: &mut 0x2::token::TokenPolicy<CREDENZA_LOYALTY>, arg1: 0x2::token::Token<CREDENZA_LOYALTY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsRedeemedEvent{
            user     : 0x2::tx_context::sender(arg3),
            amount   : 0x2::token::value<CREDENZA_LOYALTY>(&arg1),
            event_id : arg2,
        };
        0x2::event::emit<PointsRedeemedEvent>(v0);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<CREDENZA_LOYALTY>(arg0, 0x2::token::spend<CREDENZA_LOYALTY>(arg1, arg3), arg3);
    }

    public fun set_coin<T0>(arg0: &mut LoyaltyConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        if (0x2::bag::contains<0x2::object::ID>(&arg0.coin, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0), 0x2::tx_context::sender(arg3));
        };
        arg0.rate = arg2;
        0x2::bag::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.coin, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

