module 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::escrow {
    struct Offer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        kiosk: 0x2::object::ID,
        owner: address,
        item: 0x2::object::ID,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct OfferWrapper<phantom T0: store + key> {
        offer: Offer<T0>,
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

    struct OfferEvent has copy, drop {
        kiosk: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        offer_cap: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
    }

    struct RevokeOfferEvent has copy, drop {
        kiosk: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
    }

    struct AcceptOfferEvent has copy, drop {
        kiosk: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
    }

    struct DeclineOfferEvent has copy, drop {
        kiosk: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        royalty_fee: u64,
        market_fee: u64,
    }

    public fun accept_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg7: &mut 0x2::tx_context::TxContext) : (OfferWrapper<T0>, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Ext{dummy_field: false};
        let v1 = OfferKey<T0>{
            offer : arg1,
            item  : arg4,
        };
        let v2 = 0x2::bag::remove<OfferKey<T0>, Offer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v0, arg0), v1);
        let v3 = v2.royalty_fee;
        let v4 = v2.price;
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::add_balance(arg6, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, v2.market_fee, arg7));
        0x2::kiosk::list<T0>(arg2, arg3, arg4, v4);
        let (v5, v6) = 0x2::kiosk::purchase<T0>(arg2, arg4, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, v4, arg7));
        let v7 = v6;
        if (v3 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v7, 0x2::coin::take<0x2::sui::SUI>(&mut v2.balance, v3, arg7));
        };
        assert!(0x2::kiosk_extension::can_place<Ext>(arg0), 410);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg5)) {
            let v8 = Ext{dummy_field: false};
            0x2::kiosk_extension::lock<Ext, T0>(v8, arg0, v5, arg5);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v7, arg0);
        } else {
            let v9 = Ext{dummy_field: false};
            0x2::kiosk_extension::place<Ext, T0>(v9, arg0, v5, arg5);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg5)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg5, &mut v7);
        };
        let v10 = OfferWrapper<T0>{offer: v2};
        (v10, v7)
    }

    public fun confirm_offer_accepted<T0: store + key>(arg0: OfferWrapper<T0>, arg1: 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, arg1);
        let OfferWrapper { offer: v3 } = arg0;
        emit_accept_offer_event(v3.kiosk, 0x2::object::id<Offer<T0>>(&v3), v3.item, v3.price, v3.royalty_fee, v3.market_fee);
        let Offer {
            id          : v4,
            kiosk       : _,
            owner       : v6,
            item        : _,
            price       : _,
            royalty_fee : _,
            market_fee  : _,
            balance     : v11,
        } = v3;
        let v12 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, v6);
        0x2::object::delete(v4);
    }

    public fun decline_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ext{dummy_field: false};
        let v1 = OfferKey<T0>{
            offer : arg1,
            item  : 0x2::object::id<T0>(arg2),
        };
        let v2 = 0x2::bag::remove<OfferKey<T0>, Offer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v0, arg0), v1);
        let Offer {
            id          : v3,
            kiosk       : v4,
            owner       : v5,
            item        : v6,
            price       : v7,
            royalty_fee : v8,
            market_fee  : v9,
            balance     : v10,
        } = v2;
        let v11 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        emit_decline_offer_event(v4, 0x2::object::id<Offer<T0>>(&v2), v6, v7, v8, v9);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v11), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v11, v5);
        0x2::object::delete(v3);
    }

    public(friend) fun emit_accept_offer_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = AcceptOfferEvent{
            kiosk       : arg0,
            offer_id    : arg1,
            item        : arg2,
            price       : arg3,
            royalty_fee : arg4,
            market_fee  : arg5,
        };
        0x2::event::emit<AcceptOfferEvent>(v0);
    }

    public(friend) fun emit_decline_offer_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = DeclineOfferEvent{
            kiosk       : arg0,
            offer_id    : arg1,
            item        : arg2,
            price       : arg3,
            royalty_fee : arg4,
            market_fee  : arg5,
        };
        0x2::event::emit<DeclineOfferEvent>(v0);
    }

    public(friend) fun emit_offer_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = OfferEvent{
            kiosk       : arg0,
            offer_id    : arg1,
            offer_cap   : arg2,
            item        : arg3,
            price       : arg4,
            royalty_fee : arg5,
            market_fee  : arg6,
        };
        0x2::event::emit<OfferEvent>(v0);
    }

    public(friend) fun emit_revoke_offer_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RevokeOfferEvent{
            kiosk       : arg0,
            offer_id    : arg1,
            item        : arg2,
            price       : arg3,
            royalty_fee : arg4,
            market_fee  : arg5,
        };
        0x2::event::emit<RevokeOfferEvent>(v0);
    }

    fun new_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg7: &mut 0x2::tx_context::TxContext) : (Offer<T0>, OfferCap<T0>) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 100);
        let v0 = (((0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::get_fee(arg6, 0x2::tx_context::sender(arg7)) as u128) * (arg3 as u128) / 10000) as u64);
        let v1 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg5)) {
            v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg5, arg3);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg3 + v0 + v1, 411);
        let v2 = Offer<T0>{
            id          : 0x2::object::new(arg7),
            kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner       : 0x2::tx_context::sender(arg7),
            item        : arg2,
            price       : arg3,
            royalty_fee : v1,
            market_fee  : v0,
            balance     : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
        };
        let v3 = OfferCap<T0>{
            id    : 0x2::object::new(arg7),
            offer : 0x2::object::id<Offer<T0>>(&v2),
        };
        (v2, v3)
    }

    public fun offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_offer<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        if (0x2::kiosk_extension::is_installed<Ext>(arg0) == false) {
            let v4 = Ext{dummy_field: false};
            0x2::kiosk_extension::add<Ext>(v4, arg0, arg1, 3, arg7);
        } else if (0x2::kiosk_extension::is_enabled<Ext>(arg0) == false) {
            0x2::kiosk_extension::enable<Ext>(arg0, arg1);
        };
        emit_offer_event(v3.kiosk, 0x2::object::id<Offer<T0>>(&v3), 0x2::object::id<OfferCap<T0>>(&v2), v3.item, v3.price, v3.royalty_fee, v3.market_fee);
        let v5 = Ext{dummy_field: false};
        let v6 = OfferKey<T0>{
            offer : 0x2::object::id<Offer<T0>>(&v3),
            item  : arg2,
        };
        0x2::bag::add<OfferKey<T0>, Offer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v5, arg0), v6, v3);
        0x2::transfer::transfer<OfferCap<T0>>(v2, 0x2::tx_context::sender(arg7));
    }

    public fun revoke_offer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: OfferCap<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.offer == arg2, 100);
        assert!(0x2::kiosk::has_access(arg0, arg1), 100);
        let v0 = Ext{dummy_field: false};
        let v1 = OfferKey<T0>{
            offer : arg2,
            item  : arg3,
        };
        let v2 = 0x2::bag::remove<OfferKey<T0>, Offer<T0>>(0x2::kiosk_extension::storage_mut<Ext>(v0, arg0), v1);
        let Offer {
            id          : v3,
            kiosk       : v4,
            owner       : _,
            item        : v6,
            price       : v7,
            royalty_fee : v8,
            market_fee  : v9,
            balance     : v10,
        } = v2;
        0x2::object::delete(v3);
        let OfferCap {
            id    : v11,
            offer : _,
        } = arg4;
        0x2::object::delete(v11);
        emit_revoke_offer_event(v4, 0x2::object::id<Offer<T0>>(&v2), v6, v7, v8, v9);
        let v13 = 0x2::coin::zero<0x2::sui::SUI>(arg5);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v13), v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v13, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

