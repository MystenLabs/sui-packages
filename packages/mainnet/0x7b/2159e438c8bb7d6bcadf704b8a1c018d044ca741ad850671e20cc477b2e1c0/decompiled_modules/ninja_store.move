module 0x7b2159e438c8bb7d6bcadf704b8a1c018d044ca741ad850671e20cc477b2e1c0::ninja_store {
    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        from_kiosk_id: 0x2::object::ID,
    }

    struct PersonalKioskMarker has copy, drop, store {
        dummy_field: bool,
    }

    public fun is_personal_kiosk(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = PersonalKioskMarker{dummy_field: false};
        0x2::dynamic_field::exists_<PersonalKioskMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public fun transfer_with_kiosk_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        0x2::transfer::public_transfer<T0>(v0, arg3);
        let v2 = NFTTransferred{
            nft_id        : arg2,
            from          : 0x2::tx_context::sender(arg4),
            to            : arg3,
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v2);
        v1
    }

    public entry fun transfer_with_kiosk_cap_and_policy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, transfer_with_kiosk_cap<T0>(arg0, arg1, arg2, arg3, arg5));
    }

    public fun transfer_with_personal_kiosk_cap<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 3);
        assert!(0x2::kiosk::has_item(arg0, arg4), 2);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        0x2::kiosk::place<T0>(arg2, arg3, v0);
        let v2 = NFTTransferred{
            nft_id        : arg4,
            from          : 0x2::tx_context::sender(arg5),
            to            : 0x2::kiosk::owner(arg2),
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v2);
        v1
    }

    public entry fun transfer_with_personal_kiosk_cap_and_policy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, transfer_with_personal_kiosk_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg6));
    }

    // decompiled from Move bytecode v6
}

