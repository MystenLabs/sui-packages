module 0xb90325807219803a61f594675a0e3419f5929d47f40839e3e84d08d873c9759b::nft {
    struct MarketplaceInit has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        minter: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct NFTBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct ListingCreated has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct ListingCancelled has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct Buy has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    struct BidCreated has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        price: u64,
    }

    struct BidCancelled has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        price: u64,
    }

    struct AcceptBid has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        price: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        seller: address,
        nft_id: 0x2::object::ID,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        price: 0x2::balance::Balance<0x2::sui::SUI>,
        bidder: address,
        seller: address,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        bids: 0x2::table::Table<0x2::object::ID, vector<Bid>>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun accept_bid<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg3), 2);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1);
        let Listing {
            id     : v2,
            price  : _,
            seller : _,
            nft_id : _,
        } = v0;
        let Bid {
            id         : v6,
            nft_id     : _,
            listing_id : v8,
            price      : v9,
            bidder     : v10,
            seller     : v11,
        } = get_and_remove_bid(arg0, arg1, arg2);
        let v12 = v9;
        let v13 = v6;
        let v14 = AcceptBid{
            object_id  : 0x2::object::uid_to_inner(&v13),
            nft_id     : 0x2::object::id<T0>(&v1),
            listing_id : v8,
            bidder     : v10,
            seller     : v11,
            price      : 0x2::balance::value<0x2::sui::SUI>(&v12),
        };
        0x2::event::emit<AcceptBid>(v14);
        0x2::transfer::public_transfer<T0>(v1, v10);
        0x2::object::delete(v13);
        0x2::object::delete(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v12, arg3)
    }

    public fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            name        : v1,
            description : v2,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = NFTBurned{
            object_id   : 0x2::object::uid_to_inner(&v4),
            owner       : 0x2::tx_context::sender(arg1),
            name        : v1,
            description : v2,
        };
        0x2::event::emit<NFTBurned>(v5);
        0x2::object::delete(v4);
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1);
        let Listing {
            id     : v1,
            price  : v2,
            seller : v3,
            nft_id : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v5 = v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 0);
        let v6 = Buy{
            object_id  : 0x2::object::uid_to_inner(&v5),
            nft_id     : 0x2::object::id<T0>(&v0),
            listing_id : 0x2::object::uid_to_inner(&v5),
            seller     : v3,
            buyer      : 0x2::tx_context::sender(arg3),
            price      : v2,
        };
        0x2::event::emit<Buy>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v3);
        0x2::object::delete(v5);
        v0
    }

    public fun cancel_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_and_remove_bid(arg0, arg1, arg2);
        assert!(v0.bidder == 0x2::tx_context::sender(arg3), 2);
        let Bid {
            id         : v1,
            nft_id     : _,
            listing_id : v3,
            price      : v4,
            bidder     : v5,
            seller     : v6,
        } = v0;
        let v7 = v4;
        let v8 = v1;
        let v9 = BidCancelled{
            object_id  : 0x2::object::uid_to_inner(&v8),
            nft_id     : arg1,
            listing_id : v3,
            bidder     : v5,
            seller     : v6,
            price      : 0x2::balance::value<0x2::sui::SUI>(&v7),
        };
        0x2::event::emit<BidCancelled>(v9);
        0x2::object::delete(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg3)
    }

    public fun cancel_listing<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg2), 2);
        let Listing {
            id     : v1,
            price  : v2,
            seller : v3,
            nft_id : _,
        } = v0;
        let v5 = v1;
        let v6 = ListingCancelled{
            object_id : 0x2::object::uid_to_inner(&v5),
            nft_id    : arg1,
            seller    : v3,
            price     : v2,
        };
        0x2::event::emit<ListingCancelled>(v6);
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    fun get_and_remove_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : Bid {
        assert!(0x2::table::contains<0x2::object::ID, vector<Bid>>(&arg0.bids, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1);
        let v1 = 0x1::option::none<Bid>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Bid>(v0)) {
            if (0x2::object::id<Bid>(0x1::vector::borrow<Bid>(v0, v2)) == arg2) {
                0x1::option::destroy_none<Bid>(v1);
                v1 = 0x1::option::some<Bid>(0x1::vector::swap_remove<Bid>(v0, v2));
                break
            };
            v2 = v2 + 1;
        };
        assert!(0x1::option::is_some<Bid>(&v1), 4);
        if (0x1::vector::is_empty<Bid>(v0)) {
            0x1::vector::destroy_empty<Bid>(0x2::table::remove<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1));
        };
        0x1::option::destroy_some<Bid>(v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id       : 0x2::object::new(arg0),
            listings : 0x2::table::new<0x2::object::ID, Listing>(arg0),
            bids     : 0x2::table::new<0x2::object::ID, vector<Bid>>(arg0),
        };
        let v1 = MarketplaceInit{object_id: 0x2::object::id<Marketplace>(&v0)};
        0x2::event::emit<MarketplaceInit>(v1);
        0x2::transfer::share_object<Marketplace>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun mint_to(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v1 = NFTMinted{
            object_id   : 0x2::object::id<NFT>(&v0),
            minter      : arg1,
            name        : v0.name,
            description : v0.description,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg1);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun place_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Bid{
            id         : 0x2::object::new(arg4),
            nft_id     : arg1,
            listing_id : arg2,
            price      : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            bidder     : v1,
            seller     : v0.seller,
        };
        let v3 = 0x2::object::id<Bid>(&v2);
        let v4 = BidCreated{
            object_id  : v3,
            nft_id     : arg1,
            listing_id : arg2,
            bidder     : v1,
            seller     : v0.seller,
            price      : 0x2::balance::value<0x2::sui::SUI>(&v2.price),
        };
        0x2::event::emit<BidCreated>(v4);
        if (0x2::table::contains<0x2::object::ID, vector<Bid>>(&arg0.bids, arg1)) {
            0x1::vector::push_back<Bid>(0x2::table::borrow_mut<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1), v2);
        } else {
            0x2::table::add<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1, 0x1::vector::singleton<Bid>(v2));
        };
        v3
    }

    public fun place_listing<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = Listing{
            id     : 0x2::object::new(arg3),
            price  : arg2,
            seller : v0,
            nft_id : v1,
        };
        let v3 = ListingCreated{
            object_id : 0x2::object::id<Listing>(&v2),
            nft_id    : v1,
            seller    : v0,
            price     : v2.price,
        };
        0x2::event::emit<ListingCreated>(v3);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v1, v2);
    }

    // decompiled from Move bytecode v6
}

