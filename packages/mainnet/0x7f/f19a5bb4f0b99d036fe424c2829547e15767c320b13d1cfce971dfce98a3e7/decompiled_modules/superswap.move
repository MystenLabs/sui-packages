module 0x7ff19a5bb4f0b99d036fe424c2829547e15767c320b13d1cfce971dfce98a3e7::superswap {
    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        from_kiosk_id: 0x2::object::ID,
        to_kiosk_id: 0x2::object::ID,
    }

    struct KioskTransferred has copy, drop {
        kiosk_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct PersonalKioskMarker has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun create_personal_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = PersonalKioskMarker{dummy_field: false};
        0x2::dynamic_field::add<PersonalKioskMarker, bool>(0x2::kiosk::uid_mut(&mut v2), v3, true);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_personal_kiosk(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = PersonalKioskMarker{dummy_field: false};
        0x2::dynamic_field::exists_<PersonalKioskMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public entry fun p2p_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 3);
        assert!(0x2::kiosk::has_item(arg0, arg4), 2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::place<T0>(arg2, arg3, v0);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v1);
        let v5 = NFTTransferred{
            nft_id        : arg4,
            from          : 0x2::tx_context::sender(arg6),
            to            : 0x2::kiosk::owner(arg2),
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<NFTTransferred>(v5);
    }

    public entry fun simple_p2p_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 3);
        assert!(0x2::kiosk::has_item(arg0, arg4), 2);
        0x2::kiosk::place<T0>(arg2, arg3, 0x2::kiosk::take<T0>(arg0, arg1, arg4));
        let v0 = NFTTransferred{
            nft_id        : arg4,
            from          : 0x2::tx_context::sender(arg5),
            to            : 0x2::kiosk::owner(arg2),
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<NFTTransferred>(v0);
    }

    public entry fun transfer_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        0x2::kiosk::set_owner_custom(arg0, arg1, arg2);
        let v0 = KioskTransferred{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            from     : 0x2::tx_context::sender(arg3),
            to       : arg2,
        };
        0x2::event::emit<KioskTransferred>(v0);
    }

    public entry fun transfer_kiosk_with_cap(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, &arg1), 3);
        0x2::kiosk::set_owner_custom(arg0, &arg1, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg1, arg2);
        let v0 = KioskTransferred{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            from     : 0x2::tx_context::sender(arg3),
            to       : arg2,
        };
        0x2::event::emit<KioskTransferred>(v0);
    }

    public entry fun transfer_to_address<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::transfer::public_transfer<T0>(v0, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v1);
        let v5 = NFTTransferred{
            nft_id        : arg2,
            from          : 0x2::tx_context::sender(arg5),
            to            : arg3,
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v5);
    }

    // decompiled from Move bytecode v6
}

