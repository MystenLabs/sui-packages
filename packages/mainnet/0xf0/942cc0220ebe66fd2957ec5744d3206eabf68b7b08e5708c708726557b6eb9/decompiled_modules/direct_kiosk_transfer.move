module 0xf0942cc0220ebe66fd2957ec5744d3206eabf68b7b08e5708c708726557b6eb9::direct_kiosk_transfer {
    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        from_kiosk_id: 0x2::object::ID,
        to_kiosk_id: 0x2::object::ID,
    }

    public entry fun transfer_direct<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_access(arg2, arg3), 3);
        assert!(0x2::kiosk::has_item(arg0, arg4), 2);
        0x2::kiosk::list<T0>(arg0, arg1, arg4, 0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(arg0, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
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

    // decompiled from Move bytecode v6
}

