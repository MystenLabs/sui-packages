module 0x5ee64f884ede6735b379a2fafdc6b96a7eb1cadf5661a7adb751529d2cb8c594::instant_kiosk_transfer {
    struct TransferEvent has copy, drop {
        sender: address,
        receiver: address,
        nft_id: 0x2::object::ID,
        sender_kiosk: 0x2::object::ID,
        receiver_kiosk: 0x2::object::ID,
    }

    struct KioskCreatedEvent has copy, drop {
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    public entry fun batch_instant_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg4)) {
            instant_transfer<T0>(arg0, arg1, arg2, arg3, *0x1::vector::borrow<0x2::object::ID>(&arg4, v0), arg5, arg6, arg7);
            v0 = v0 + 1;
        };
    }

    public entry fun batch_instant_transfer_to_new_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: address, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_kiosk(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v5 = &mut v3;
            instant_transfer<T0>(arg0, arg1, v5, &v2, *0x1::vector::borrow<0x2::object::ID>(&arg3, v4), arg4, arg5, arg6);
            v4 = v4 + 1;
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg2);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = KioskCreatedEvent{
            owner    : 0x2::tx_context::sender(arg0),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
        };
        0x2::event::emit<KioskCreatedEvent>(v3);
        (v2, v1)
    }

    public entry fun create_kiosk_for(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_kiosk(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, arg0);
    }

    public entry fun instant_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 1);
        assert!(0x2::kiosk::has_item(arg0, arg4), 3);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg4, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v0);
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v2, arg2);
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg5, 0x2::transfer_policy::paid<T0>(&v2));
        if (v3 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg6, v3, arg7));
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v2);
        let v7 = TransferEvent{
            sender         : 0x2::tx_context::sender(arg7),
            receiver       : 0x2::kiosk::owner(arg2),
            nft_id         : arg4,
            sender_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            receiver_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<TransferEvent>(v7);
    }

    public entry fun instant_transfer_to_new_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: address, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_kiosk(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        instant_transfer<T0>(arg0, arg1, v4, &v2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg2);
    }

    // decompiled from Move bytecode v6
}

