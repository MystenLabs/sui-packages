module 0xd226ad62dbaab90f4adae49ec96527a2bcff5549945e2e381d9d3a55472ee44f::swap_v2 {
    struct CapKey has copy, drop, store {
        who: u8,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
        wanted_from_taker: u64,
        payout_to_taker: u64,
        expected_taker_ids: vector<0x2::object::ID>,
        expires_at: u64,
        note: 0x1::string::String,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
    }

    struct OfferV2 has store, key {
        id: 0x2::object::UID,
        maker: address,
        taker: address,
        sponsor: address,
        maker_kiosk_id: 0x2::object::ID,
        maker_item_ids: vector<0x2::object::ID>,
        taker_kiosk_id: 0x2::object::ID,
        taker_item_ids: vector<0x2::object::ID>,
        maker_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        wanted_from_taker: u64,
        payout_to_taker: u64,
        expected_taker_ids: vector<0x2::object::ID>,
        subsidy_mist: u64,
        note: 0x1::string::String,
        expires_at: u64,
        status: u8,
    }

    public fun accept_v2(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg5) == arg0.taker, 2);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg5), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_kiosk_id, 7);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg0.taker_kiosk_id, 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.expected_taker_ids)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg0.expected_taker_ids, v0);
            assert!(vec_contains_id(&arg0.taker_item_ids, &v1), 6);
            v0 = v0 + 1;
        };
        let v2 = arg0.wanted_from_taker;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg5), arg0.maker);
        };
        let v3 = arg0.payout_to_taker;
        if (v3 > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.maker_sui) >= v3, 42);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.maker_sui, v3), arg5), arg0.taker);
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.maker_sui);
        if (v4 > 0) {
            let v5 = if (arg4 < arg0.subsidy_mist) {
                arg4
            } else {
                arg0.subsidy_mist
            };
            let v6 = v5;
            if (v5 > v4) {
                v6 = v4;
            };
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.maker_sui, v6), arg5), arg0.taker);
            };
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&arg0.maker_sui);
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.maker_sui, v7), arg5), arg0.sponsor);
            };
        };
        let v8 = CapKey{who: 0};
        let v9 = CapKey{who: 1};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v8), arg0.taker);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v9), arg0.maker);
        let v10 = OfferAccepted{
            offer_id : 0x2::object::id<OfferV2>(arg0),
            maker    : arg0.maker,
            taker    : arg0.taker,
        };
        0x2::event::emit<OfferAccepted>(v10);
        arg0.status = 1;
        arg3
    }

    public fun cancel(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_kiosk_id, 7);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg0.taker_kiosk_id, 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.maker_sui);
        if (v0 > 0) {
            let v1 = arg0.payout_to_taker;
            if (v1 > 0 && v0 >= v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.maker_sui, v1), arg3), arg0.maker);
            };
            let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.maker_sui);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.maker_sui, v2), arg3), arg0.sponsor);
            };
        };
        let v3 = CapKey{who: 0};
        let v4 = CapKey{who: 1};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v3), arg0.maker);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_object_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v4), arg0.taker);
        let v5 = OfferCancelled{
            offer_id : 0x2::object::id<OfferV2>(arg0),
            maker    : arg0.maker,
        };
        0x2::event::emit<OfferCancelled>(v5);
        arg0.status = 2;
    }

    public fun create_offer_draft(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x2::object::ID>, arg4: u64, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (OfferV2, 0x2::kiosk::Kiosk, 0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap, 0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v0;
        let (v3, v4) = 0x2::kiosk::new(arg8);
        let v5 = v3;
        let v6 = OfferV2{
            id                 : 0x2::object::new(arg8),
            maker              : 0x2::tx_context::sender(arg8),
            taker              : arg0,
            sponsor            : arg6,
            maker_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            maker_item_ids     : 0x1::vector::empty<0x2::object::ID>(),
            taker_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v5),
            taker_item_ids     : 0x1::vector::empty<0x2::object::ID>(),
            maker_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            wanted_from_taker  : arg1,
            payout_to_taker    : arg2,
            expected_taker_ids : arg3,
            subsidy_mist       : arg7,
            note               : arg5,
            expires_at         : arg4,
            status             : 0,
        };
        (v6, v2, v5, v1, v4)
    }

    public fun create_offer_v2(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x2::object::ID>, arg4: u64, arg5: 0x1::string::String, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = 0x2::kiosk::new(arg8);
        let v3 = v1;
        let (v4, v5) = 0x2::kiosk::new(arg8);
        let v6 = v4;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        let v7 = OfferV2{
            id                 : 0x2::object::new(arg8),
            maker              : v0,
            taker              : arg0,
            sponsor            : arg6,
            maker_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            maker_item_ids     : 0x1::vector::empty<0x2::object::ID>(),
            taker_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v6),
            taker_item_ids     : 0x1::vector::empty<0x2::object::ID>(),
            maker_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            wanted_from_taker  : arg1,
            payout_to_taker    : arg2,
            expected_taker_ids : arg3,
            subsidy_mist       : arg7,
            note               : arg5,
            expires_at         : arg4,
            status             : 0,
        };
        let v8 = CapKey{who: 0};
        0x2::dynamic_object_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut v7.id, v8, v2);
        let v9 = CapKey{who: 1};
        0x2::dynamic_object_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut v7.id, v9, v5);
        let v10 = OfferCreated{
            offer_id           : 0x2::object::id<OfferV2>(&v7),
            maker              : v0,
            taker              : arg0,
            wanted_from_taker  : arg1,
            payout_to_taker    : arg2,
            expected_taker_ids : arg3,
            expires_at         : arg4,
            note               : arg5,
        };
        0x2::event::emit<OfferCreated>(v10);
        0x2::transfer::public_share_object<OfferV2>(v7);
    }

    public fun finalize_publish(arg0: OfferV2, arg1: 0x2::kiosk::Kiosk, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x2::kiosk::KioskOwnerCap) {
        let v0 = CapKey{who: 0};
        0x2::dynamic_object_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v0, arg3);
        let v1 = CapKey{who: 1};
        0x2::dynamic_object_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v1, arg4);
        let v2 = OfferCreated{
            offer_id           : 0x2::object::id<OfferV2>(&arg0),
            maker              : arg0.maker,
            taker              : arg0.taker,
            wanted_from_taker  : arg0.wanted_from_taker,
            payout_to_taker    : arg0.payout_to_taker,
            expected_taker_ids : arg0.expected_taker_ids,
            expires_at         : arg0.expires_at,
            note               : arg0.note,
        };
        0x2::event::emit<OfferCreated>(v2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg2);
        0x2::transfer::public_share_object<OfferV2>(arg0);
    }

    public fun maker_deposit_any<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg3), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_kiosk_id, 7);
        let v0 = CapKey{who: 0};
        0x2::kiosk::place<T0>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x2::kiosk::KioskOwnerCap>(&arg0.id, v0), arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.maker_item_ids, 0x2::object::id<T0>(&arg2));
    }

    public fun maker_deposit_any_draft<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg4), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_kiosk_id, 7);
        0x2::kiosk::place<T0>(arg1, arg2, arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.maker_item_ids, 0x2::object::id<T0>(&arg3));
    }

    public fun maker_deposit_sui(arg0: &mut OfferV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg2), 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.maker_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun maker_transfer_from_kiosk<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg5), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.maker_kiosk_id, 7);
        let v0 = CapKey{who: 0};
        0x2::kiosk::place<T0>(arg3, 0x2::dynamic_object_field::borrow<CapKey, 0x2::kiosk::KioskOwnerCap>(&arg0.id, v0), 0x2::kiosk::take<T0>(arg1, arg2, arg4));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.maker_item_ids, arg4);
    }

    public fun maker_transfer_from_kiosk_draft<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.maker, 1);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg6), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.maker_kiosk_id, 7);
        0x2::kiosk::place<T0>(arg3, arg4, 0x2::kiosk::take<T0>(arg1, arg2, arg5));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.maker_item_ids, arg5);
    }

    fun not_expired(arg0: u64, arg1: &0x2::tx_context::TxContext) : bool {
        arg0 == 0 || now_ms(arg1) <= arg0
    }

    fun now_ms(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::epoch_timestamp_ms(arg0)
    }

    public fun taker_deposit_any<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.taker, 2);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg3), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.taker_kiosk_id, 7);
        let v0 = CapKey{who: 1};
        0x2::kiosk::place<T0>(arg1, 0x2::dynamic_object_field::borrow<CapKey, 0x2::kiosk::KioskOwnerCap>(&arg0.id, v0), arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.taker_item_ids, 0x2::object::id<T0>(&arg2));
    }

    public fun taker_transfer_from_kiosk<T0: store + key>(arg0: &mut OfferV2, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.taker, 2);
        assert!(arg0.status == 0, 3);
        assert!(not_expired(arg0.expires_at, arg5), 5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.taker_kiosk_id, 7);
        let v0 = CapKey{who: 1};
        0x2::kiosk::place<T0>(arg3, 0x2::dynamic_object_field::borrow<CapKey, 0x2::kiosk::KioskOwnerCap>(&arg0.id, v0), 0x2::kiosk::take<T0>(arg1, arg2, arg4));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.taker_item_ids, arg4);
    }

    fun vec_contains_id(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

