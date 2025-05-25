module 0x54ce5bac8843da98dc96c6c0ae786e82a2545edafdef8ff2c75c79a9416036a1::transfer_nft_auctionhouse {
    struct NFTTransferredToWallet has copy, drop {
        sender: address,
        recipient: address,
        nft_id: 0x2::object::ID,
        from_kiosk: bool,
    }

    struct BatchTransferCompleted has copy, drop {
        sender: address,
        recipient: address,
        nft_count: u64,
        from_kiosk: bool,
    }

    struct KioskCreatedForRecipient has copy, drop {
        sender: address,
        recipient: address,
        kiosk_id: 0x2::object::ID,
    }

    public fun batch_transfer_kiosk_nfts_to_wallet<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg2);
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        assert!(v0 != arg3, 3);
        assert!(v1 == 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg5), 4);
        assert!(v1 > 0, 4);
        let (v2, v3) = 0x2::kiosk::new(arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(&v5);
        let v7 = 0;
        while (v7 < v1) {
            let v8 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v7);
            assert!(0x2::kiosk::has_item(arg0, v8), 1);
            let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, v8, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
            let v11 = v10;
            0x2::kiosk::lock<T0>(&mut v5, &v4, arg4, v9);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v11, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg5));
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v11, &v5);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
            let v15 = NFTTransferredToWallet{
                sender     : v0,
                recipient  : arg3,
                nft_id     : v8,
                from_kiosk : true,
            };
            0x2::event::emit<NFTTransferredToWallet>(v15);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v5, v4, arg6), arg6);
        let v16 = KioskCreatedForRecipient{
            sender    : v0,
            recipient : arg3,
            kiosk_id  : v6,
        };
        0x2::event::emit<KioskCreatedForRecipient>(v16);
        let v17 = BatchTransferCompleted{
            sender     : v0,
            recipient  : arg3,
            nft_count  : v1,
            from_kiosk : true,
        };
        0x2::event::emit<BatchTransferCompleted>(v17);
        v6
    }

    public entry fun batch_transfer_kiosk_nfts_to_wallet_entry<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        batch_transfer_kiosk_nfts_to_wallet<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun batch_transfer_wallet_nfts_to_wallet<T0: store + key>(arg0: vector<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::length<T0>(&arg0);
        assert!(v0 != arg1, 3);
        assert!(v1 > 0, 4);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::pop_back<T0>(&mut arg0);
            0x2::transfer::public_transfer<T0>(v3, arg1);
            let v4 = NFTTransferredToWallet{
                sender     : v0,
                recipient  : arg1,
                nft_id     : 0x2::object::id<T0>(&v3),
                from_kiosk : false,
            };
            0x2::event::emit<NFTTransferredToWallet>(v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        let v5 = BatchTransferCompleted{
            sender     : v0,
            recipient  : arg1,
            nft_count  : v1,
            from_kiosk : false,
        };
        0x2::event::emit<BatchTransferCompleted>(v5);
    }

    public entry fun batch_transfer_wallet_nfts_to_wallet_entry<T0: store + key>(arg0: vector<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        batch_transfer_wallet_nfts_to_wallet<T0>(arg0, arg1, arg2);
    }

    public fun get_kiosk_owner(arg0: &0x2::kiosk::Kiosk) : address {
        0x2::kiosk::owner(arg0)
    }

    public fun is_kiosk_empty(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk::item_count(arg0) == 0
    }

    public fun nft_exists_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(arg0, arg1)
    }

    public fun transfer_kiosk_nft_direct_to_wallet<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        assert!(0x2::kiosk::has_item(arg0, arg2), 1);
        assert!(v0 != arg3, 3);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v3 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v3, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v3);
        0x2::transfer::public_transfer<T0>(v1, arg3);
        let v7 = NFTTransferredToWallet{
            sender     : v0,
            recipient  : arg3,
            nft_id     : arg2,
            from_kiosk : true,
        };
        0x2::event::emit<NFTTransferredToWallet>(v7);
    }

    public entry fun transfer_kiosk_nft_direct_to_wallet_entry<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        transfer_kiosk_nft_direct_to_wallet<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun transfer_kiosk_nft_direct_to_wallet_with_new_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        assert!(0x2::kiosk::has_item(arg0, arg2), 1);
        assert!(v0 != arg3, 3);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v3 = v2;
        let (v4, v5) = 0x2::kiosk::new(arg6);
        let v6 = v5;
        let v7 = v4;
        0x2::kiosk::lock<T0>(&mut v7, &v6, arg4, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v3, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v3, &v7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v7);
        let v11 = NFTTransferredToWallet{
            sender     : v0,
            recipient  : arg3,
            nft_id     : arg2,
            from_kiosk : true,
        };
        0x2::event::emit<NFTTransferredToWallet>(v11);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v7, v6, arg6)
    }

    public fun transfer_kiosk_nft_to_wallet<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        assert!(0x2::kiosk::has_item(arg0, arg2), 1);
        assert!(v0 != arg3, 3);
        let (v1, v2) = 0x2::kiosk::new(arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(&v4);
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v8 = v7;
        0x2::kiosk::lock<T0>(&mut v4, &v3, arg4, v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v8, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, &v4);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v4, v3, arg6), arg6);
        let v12 = KioskCreatedForRecipient{
            sender    : v0,
            recipient : arg3,
            kiosk_id  : v5,
        };
        0x2::event::emit<KioskCreatedForRecipient>(v12);
        let v13 = NFTTransferredToWallet{
            sender     : v0,
            recipient  : arg3,
            nft_id     : arg2,
            from_kiosk : true,
        };
        0x2::event::emit<NFTTransferredToWallet>(v13);
        v5
    }

    public entry fun transfer_kiosk_nft_to_wallet_entry<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        transfer_kiosk_nft_to_wallet<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun transfer_wallet_nft_to_wallet<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 3);
        0x2::transfer::public_transfer<T0>(arg0, arg1);
        let v1 = NFTTransferredToWallet{
            sender     : v0,
            recipient  : arg1,
            nft_id     : 0x2::object::id<T0>(&arg0),
            from_kiosk : false,
        };
        0x2::event::emit<NFTTransferredToWallet>(v1);
    }

    public entry fun transfer_wallet_nft_to_wallet_entry<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_wallet_nft_to_wallet<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

