module 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::bidirectional_kiosk_transfer {
    struct NftTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from_kiosk: 0x2::object::ID,
        to_address: address,
        sender: address,
        timestamp_ms: u64,
    }

    struct NftTransferredToNewKiosk has copy, drop {
        nft_id: 0x2::object::ID,
        from_kiosk: 0x2::object::ID,
        to_kiosk: 0x2::object::ID,
        to_address: address,
        sender: address,
        timestamp_ms: u64,
    }

    struct BatchTransferCompleted has copy, drop {
        from_kiosk: 0x2::object::ID,
        to_kiosk: 0x2::object::ID,
        to_address: address,
        nft_count: u64,
        sender: address,
        timestamp_ms: u64,
    }

    struct KioskAutoRegistered has copy, drop {
        user: address,
        kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public entry fun batch_transfer_same_collection<T0: store + key>(arg0: &mut 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: vector<0x2::object::ID>, arg5: address, arg6: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x1::vector::length<0x2::object::ID>(&arg4) == 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg6), 5);
        let (v2, v3) = 0x2::kiosk::new(arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(&v5);
        let v7 = 0;
        let v8 = 0x1::vector::length<0x2::object::ID>(&arg4);
        while (v7 < v8) {
            let v9 = *0x1::vector::borrow<0x2::object::ID>(&arg4, v7);
            assert!(0x2::kiosk::has_item(arg1, v9), 3);
            let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v9, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
            let v12 = v11;
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v12, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg6));
            0x2::kiosk::lock<T0>(&mut v5, &v4, arg3, v10);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v12, &v5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v12);
            let v16 = NftTransferredToNewKiosk{
                nft_id       : v9,
                from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
                to_kiosk     : v6,
                to_address   : arg5,
                sender       : v0,
                timestamp_ms : v1,
            };
            0x2::event::emit<NftTransferredToNewKiosk>(v16);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg6);
        0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::register_kiosk_internal(arg0, arg5, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, arg5);
        let v17 = BatchTransferCompleted{
            from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            to_kiosk     : v6,
            to_address   : arg5,
            nft_count    : v8,
            sender       : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<BatchTransferCompleted>(v17);
        let v18 = KioskAutoRegistered{
            user         : arg5,
            kiosk_id     : v6,
            timestamp_ms : v1,
        };
        0x2::event::emit<KioskAutoRegistered>(v18);
    }

    public fun get_kiosk_owner(arg0: &0x2::kiosk::Kiosk) : address {
        0x2::kiosk::owner(arg0)
    }

    public fun get_user_registered_kiosk(arg0: &0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::get_user_kiosk(arg0, arg1)
    }

    public entry fun gift_nft<T0: store + key>(arg0: &mut 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        transfer_nft_to_address<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun has_kiosk_access(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) : bool {
        0x2::kiosk::has_access(arg0, arg1)
    }

    public fun nft_exists_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(arg0, arg1)
    }

    public entry fun smart_transfer<T0: store + key>(arg0: &mut 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::has_registered_kiosk(arg0, arg5)) {
            transfer_nft_to_address<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        } else {
            transfer_nft_to_address<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        };
    }

    public entry fun transfer_nft_to_address<T0: store + key>(arg0: &mut 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: address, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x2::kiosk::has_item(arg1, arg4), 3);
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg4, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v4 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v4, arg6);
        let (v5, v6) = 0x2::kiosk::new(arg8);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::object::id<0x2::kiosk::Kiosk>(&v8);
        0x2::kiosk::lock<T0>(&mut v8, &v7, arg3, v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v4, &v8);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v4);
        0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::register_kiosk_internal(arg0, arg5, v9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, arg5);
        let v13 = NftTransferredToNewKiosk{
            nft_id       : arg4,
            from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            to_kiosk     : v9,
            to_address   : arg5,
            sender       : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<NftTransferredToNewKiosk>(v13);
        let v14 = KioskAutoRegistered{
            user         : arg5,
            kiosk_id     : v9,
            timestamp_ms : v1,
        };
        0x2::event::emit<KioskAutoRegistered>(v14);
    }

    public entry fun transfer_nft_to_existing_kiosk<T0: store + key>(arg0: &0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::object::ID, arg7: address, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        assert!(0x2::kiosk::has_item(arg1, arg6), 3);
        assert!(0x2::kiosk::owner(arg3) == arg7, 1);
        assert!(0x2::kiosk::has_access(arg3, arg4), 4);
        let v1 = 0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::get_user_kiosk(arg0, arg7);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 6);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 2);
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg6, 0, arg10), 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let v4 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v4, arg8);
        0x2::kiosk::lock<T0>(arg3, arg4, arg5, v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v4, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v4);
        let v8 = NftTransferred{
            nft_id       : arg6,
            from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            to_address   : arg7,
            sender       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<NftTransferred>(v8);
    }

    public fun user_has_registered_kiosk(arg0: &0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::KioskRegistry, arg1: address) : bool {
        0xa67cc532705e028da4f6830dd4bdfa6c5a6be6aead30b7b9c1d82e684e649703::kiosk_registry::has_registered_kiosk(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

