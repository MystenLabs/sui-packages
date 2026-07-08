module 0xed9458d2f8b0b54399d086f43e3369f0397d2aea330544512b08f84f2a41209f::marketplace {
    struct Listing has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
        treasury: address,
        created_at: u64,
    }

    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NFTListed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTSold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        fee: u64,
    }

    struct NFTDelisted has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun delist<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 2);
        let v0 = arg0.nft_id;
        let v1 = CapKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v1);
        0x2::kiosk::delist<T0>(arg1, &v2, v0);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &v2, v0), arg0.seller);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg0.seller);
        let v3 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v0,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v3);
    }

    public entry fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg0);
        let (v2, v3) = 0x2::kiosk::new(arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<T0>(&mut v5, &v4, arg0);
        0x2::kiosk::list<T0>(&mut v5, &v4, v1, arg1);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(&v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        let v7 = Listing{
            id         : 0x2::object::new(arg3),
            nft_id     : v1,
            kiosk_id   : v6,
            seller     : v0,
            price      : arg1,
            treasury   : arg2,
            created_at : 0x2::tx_context::epoch(arg3),
        };
        let v8 = CapKey{dummy_field: false};
        0x2::dynamic_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut v7.id, v8, v4);
        0x2::transfer::share_object<Listing>(v7);
        let v9 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v7),
            nft_id     : v1,
            kiosk_id   : v6,
            seller     : v0,
            price      : arg1,
        };
        0x2::event::emit<NFTListed>(v9);
    }

    public entry fun buy<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.price;
        let v1 = arg0.seller;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg0.nft_id;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v4 >= v0, 3);
        if (v4 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4 - v0, arg4), v2);
        };
        let v5 = v0 * 500 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
        let v6 = CapKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v6);
        0x2::kiosk::delist<T0>(arg1, &v7, v3);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &v7, v3), v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, v1);
        let v8 = NFTSold{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v3,
            buyer      : v2,
            seller     : v1,
            price      : v0,
            fee        : v5,
        };
        0x2::event::emit<NFTSold>(v8);
    }

    public entry fun buy_kiosk<T0: store + key>(arg0: &Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.price;
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = arg0.nft_id;
        let v3 = v0 * 500 / 10000;
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, v0);
        let v5 = v0 + v3 + v4;
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v6 >= v5, 3);
        if (v6 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v6 - v5, arg6), v1);
        };
        let (v7, v8) = 0x2::kiosk::purchase<T0>(arg1, v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v0, arg6));
        let v9 = v8;
        0x2::kiosk::lock<T0>(arg3, arg4, arg2, v7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v9, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v9, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v3, arg6), arg0.treasury);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        let v13 = NFTSold{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v2,
            buyer      : v1,
            seller     : arg0.seller,
            price      : v0,
            fee        : v3,
        };
        0x2::event::emit<NFTSold>(v13);
    }

    public entry fun delist_kiosk<T0: store + key>(arg0: &Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 2);
        0x2::kiosk::delist<T0>(arg1, arg2, arg0.nft_id);
        let v0 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : arg0.nft_id,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v0);
    }

    public entry fun list_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v2 = Listing{
            id         : 0x2::object::new(arg5),
            nft_id     : arg2,
            kiosk_id   : v1,
            seller     : v0,
            price      : arg3,
            treasury   : arg4,
            created_at : 0x2::tx_context::epoch(arg5),
        };
        0x2::transfer::share_object<Listing>(v2);
        let v3 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : arg2,
            kiosk_id   : v1,
            seller     : v0,
            price      : arg3,
        };
        0x2::event::emit<NFTListed>(v3);
    }

    public fun listing_kiosk_id(arg0: &Listing) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun listing_nft_id(arg0: &Listing) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    // decompiled from Move bytecode v7
}

