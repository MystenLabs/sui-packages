module 0x23c14099aab76feac796fb6319fa040356d5ef1cbbc48a4dcc9e2389761ae886::simple_kiosk_transfer {
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

    public entry fun batch_transfer_nfts_to_address<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: vector<0x2::object::ID>, arg4: address, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::kiosk::owner(arg0) == v0, 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg5), 4);
        let (v1, v2) = 0x2::kiosk::new(arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v5);
            assert!(0x2::kiosk::has_item(arg0, v6), 3);
            let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, v6, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
            let v9 = v8;
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v9, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5));
            0x2::kiosk::lock<T0>(&mut v4, &v3, arg2, v7);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v9, &v4);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v9);
            let v13 = NftTransferredToNewKiosk{
                nft_id       : v6,
                from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
                to_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
                to_address   : arg4,
                sender       : v0,
                timestamp_ms : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<NftTransferredToNewKiosk>(v13);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg4);
    }

    public fun get_kiosk_owner(arg0: &0x2::kiosk::Kiosk) : address {
        0x2::kiosk::owner(arg0)
    }

    public entry fun gift_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        transfer_nft_to_address<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun has_kiosk_access(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) : bool {
        0x2::kiosk::has_access(arg0, arg1)
    }

    public fun nft_exists_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(arg0, arg1)
    }

    public entry fun transfer_nft_to_address<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::kiosk::owner(arg0) == v0, 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        assert!(0x2::kiosk::has_item(arg0, arg3), 3);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg3, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v3, arg5);
        let (v4, v5) = 0x2::kiosk::new(arg7);
        let v6 = v5;
        let v7 = v4;
        0x2::kiosk::lock<T0>(&mut v7, &v6, arg2, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, &v7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, arg4);
        let v11 = NftTransferredToNewKiosk{
            nft_id       : arg3,
            from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_kiosk     : 0x2::object::id<0x2::kiosk::Kiosk>(&v7),
            to_address   : arg4,
            sender       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NftTransferredToNewKiosk>(v11);
    }

    public entry fun transfer_nft_to_existing_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: address, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::kiosk::owner(arg0) == v0, 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        assert!(0x2::kiosk::has_item(arg0, arg5), 3);
        assert!(0x2::kiosk::owner(arg2) == arg6, 1);
        assert!(0x2::kiosk::has_access(arg2, arg3), 4);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg5, 0, arg9), 0x2::coin::zero<0x2::sui::SUI>(arg9));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v3, arg7);
        0x2::kiosk::lock<T0>(arg2, arg3, arg4, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, arg2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v3);
        let v7 = NftTransferred{
            nft_id       : arg5,
            from_kiosk   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_address   : arg6,
            sender       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<NftTransferred>(v7);
    }

    // decompiled from Move bytecode v6
}

