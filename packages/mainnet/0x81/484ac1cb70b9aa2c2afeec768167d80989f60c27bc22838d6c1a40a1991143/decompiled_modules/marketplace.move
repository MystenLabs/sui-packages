module 0x81484ac1cb70b9aa2c2afeec768167d80989f60c27bc22838d6c1a40a1991143::marketplace {
    struct SuimonNFT has store, key {
        id: 0x2::object::UID,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        created_at: u64,
    }

    struct NFTListed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTSold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct NFTDelisted has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun buy(arg0: Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.price;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 >= v1, 1);
        if (v2 > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2), arg0.seller);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.seller);
        };
        let v3 = NFTSold{
            listing_id : 0x2::object::id<Listing>(&arg0),
            nft_id     : arg0.nft_id,
            buyer      : v0,
            price      : v1,
        };
        0x2::event::emit<NFTSold>(v3);
        let Listing {
            id         : v4,
            nft_id     : _,
            seller     : _,
            price      : _,
            created_at : _,
        } = arg0;
        0x2::object::delete(v4);
    }

    public entry fun delist(arg0: Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 2);
        let v0 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(&arg0),
            nft_id     : arg0.nft_id,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v0);
        let Listing {
            id         : v1,
            nft_id     : _,
            seller     : _,
            price      : _,
            created_at : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public entry fun list(arg0: SuimonNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<SuimonNFT>(&arg0);
        assert!(arg1 > 0, 3);
        0x2::transfer::transfer<SuimonNFT>(arg0, v0);
        let v2 = Listing{
            id         : 0x2::object::new(arg2),
            nft_id     : v1,
            seller     : v0,
            price      : arg1,
            created_at : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::share_object<Listing>(v2);
        let v3 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : v1,
            seller     : v0,
            price      : arg1,
        };
        0x2::event::emit<NFTListed>(v3);
    }

    // decompiled from Move bytecode v7
}

