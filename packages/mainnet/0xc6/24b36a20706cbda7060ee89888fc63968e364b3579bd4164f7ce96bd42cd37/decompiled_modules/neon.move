module 0xc624b36a20706cbda7060ee89888fc63968e364b3579bd4164f7ce96bd42cd37::neon {
    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        from_kiosk_id: 0x2::object::ID,
        to_kiosk_id: 0x2::object::ID,
    }

    struct WalletToWalletTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        royalty_paid: u64,
    }

    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    public entry fun transfer_direct_to_address<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg5));
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

    public entry fun transfer_direct_to_address_next<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg5);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::kiosk::owner(arg0) == v0, 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(arg3 != @0x0, 9);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, 0);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v2);
        0x2::transfer::public_transfer<T0>(v1, arg3);
        let v6 = NFTTransferred{
            nft_id        : arg2,
            from          : v0,
            to            : arg3,
            from_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<NFTTransferred>(v6);
    }

    public entry fun transfer_wallet_to_wallet<T0: store + key>(arg0: T0, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: address, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<T0>(&arg0);
        let (v2, v3) = 0x2::kiosk::new(arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<T0>(&mut v5, &v4, arg0);
        0x2::kiosk::list<T0>(&mut v5, &v4, v1, 0);
        let v6 = 10000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v6, 6);
        let (v7, v8) = 0x2::kiosk::purchase<T0>(&mut v5, v1, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v9 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, RoyaltyRule>(v9, arg1, 0x2::coin::split<0x2::sui::SUI>(arg3, v6, arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v8);
        0x2::transfer::public_transfer<T0>(v7, arg2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        let v13 = WalletToWalletTransferred{
            nft_id       : v1,
            from         : v0,
            to           : arg2,
            royalty_paid : v6,
        };
        0x2::event::emit<WalletToWalletTransferred>(v13);
    }

    // decompiled from Move bytecode v6
}

