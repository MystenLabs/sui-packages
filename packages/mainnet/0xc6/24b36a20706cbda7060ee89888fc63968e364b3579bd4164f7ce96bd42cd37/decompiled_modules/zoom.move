module 0xc624b36a20706cbda7060ee89888fc63968e364b3579bd4164f7ce96bd42cd37::zoom {
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

    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
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

    public entry fun list_nft_personal<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 3);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let v0 = Listing<T0>{
            id          : 0x2::object::new(arg5),
            seller      : 0x2::tx_context::sender(arg5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg5),
            price       : arg4,
            commission  : 0,
            beneficiary : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v0);
        let v1 = NFTListed{
            nft_id   : arg3,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            seller   : 0x2::tx_context::sender(arg5),
            price    : arg4,
        };
        0x2::event::emit<NFTListed>(v1);
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

