module 0x8c7a307fe893cdb04a5ccb38f880269f6f22b9cc05c321899b281f9d8474930::market {
    struct NFTListed has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTUnlisted has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
    }

    struct NFTPurchased has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 6);
        assert!(arg3 > 0, 7);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v0 = NFTListed{
            nft_id   : arg2,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            seller   : 0x2::tx_context::sender(arg4),
            price    : arg3,
        };
        0x2::event::emit<NFTListed>(v0);
    }

    public entry fun unlist_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 3);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg0, arg2), 5);
        0x2::kiosk::delist<T0>(arg0, arg1, arg2);
        let v0 = NFTUnlisted{
            nft_id   : arg2,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            seller   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<NFTUnlisted>(v0);
    }

    // decompiled from Move bytecode v6
}

