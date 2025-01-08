module 0x3825f19fdca76481ba35b8b98dc0d0f28b0c8a1b3ebe3033c70928185a8694a2::nft_marketplace {
    struct MarketplaceInit has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ListingCreated has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct ListingCancelled has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct Buy has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        buyer: address,
        price: u64,
    }

    struct BidCreated has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct BidCancelled has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct AcceptBid has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        seller: address,
        price: u64,
    }

    struct TestnetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
        nft_id: 0x2::object::ID,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        bids: 0x2::table::Table<0x2::object::ID, vector<Bid>>,
    }

    struct NFT_MARKETPLACE has drop {
        dummy_field: bool,
    }

    public fun url(arg0: &TestnetNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun accept_bid<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 2);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1);
        let Listing {
            id     : v2,
            price  : _,
            owner  : _,
            nft_id : _,
        } = v0;
        let Bid {
            id      : v6,
            nft_id  : _,
            balance : v8,
            owner   : v9,
        } = get_and_remove_bid(arg0, arg1, arg2);
        let v10 = v8;
        let v11 = v6;
        let v12 = AcceptBid{
            object_id : 0x2::object::uid_to_inner(&v11),
            nft_id    : 0x2::object::id<T0>(&v1),
            creator   : v9,
            seller    : 0x2::tx_context::sender(arg3),
            price     : 0x2::balance::value<0x2::sui::SUI>(&v10),
        };
        0x2::event::emit<AcceptBid>(v12);
        0x2::transfer::public_transfer<T0>(v1, v9);
        0x2::object::delete(v11);
        0x2::object::delete(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v10, arg3)
    }

    public fun burn(arg0: TestnetNFT) {
        let TestnetNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1);
        let Listing {
            id     : v1,
            price  : v2,
            owner  : v3,
            nft_id : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v5 = v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 0);
        let v6 = Buy{
            object_id : 0x2::object::uid_to_inner(&v5),
            nft_id    : 0x2::object::id<T0>(&v0),
            creator   : v3,
            buyer     : 0x2::tx_context::sender(arg3),
            price     : v2,
        };
        0x2::event::emit<Buy>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v3);
        0x2::object::delete(v5);
        v0
    }

    public fun cancel_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = get_and_remove_bid(arg0, arg1, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 2);
        let Bid {
            id      : v1,
            nft_id  : v2,
            balance : v3,
            owner   : v4,
        } = v0;
        let v5 = v3;
        let v6 = v1;
        let v7 = BidCancelled{
            object_id : 0x2::object::uid_to_inner(&v6),
            nft_id    : v2,
            creator   : v4,
            price     : 0x2::balance::value<0x2::sui::SUI>(&v5),
        };
        0x2::event::emit<BidCancelled>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    public fun cancel_listing<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 2);
        let Listing {
            id     : v1,
            price  : v2,
            owner  : v3,
            nft_id : _,
        } = v0;
        let v5 = v1;
        let v6 = ListingCancelled{
            object_id : 0x2::object::uid_to_inner(&v5),
            nft_id    : arg1,
            creator   : v3,
            price     : v2,
        };
        0x2::event::emit<ListingCancelled>(v6);
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun creator(arg0: &TestnetNFT) : &address {
        &arg0.creator
    }

    public fun description(arg0: &TestnetNFT) : &0x1::string::String {
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

    fun init(arg0: NFT_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::package::claim<NFT_MARKETPLACE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TestnetNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TestnetNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestnetNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Marketplace{
            id       : 0x2::object::new(arg1),
            listings : 0x2::table::new<0x2::object::ID, Listing>(arg1),
            bids     : 0x2::table::new<0x2::object::ID, vector<Bid>>(arg1),
        };
        let v7 = MarketplaceInit{object_id: 0x2::object::id<Marketplace>(&v6)};
        0x2::event::emit<MarketplaceInit>(v7);
        0x2::transfer::share_object<Marketplace>(v6);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : TestnetNFT {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = TestnetNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<TestnetNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        v1
    }

    public fun name(arg0: &TestnetNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun place_bid(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Bid{
            id      : 0x2::object::new(arg3),
            nft_id  : arg1,
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            owner   : v0,
        };
        let v2 = 0x2::object::id<Bid>(&v1);
        let v3 = BidCreated{
            object_id : v2,
            nft_id    : arg1,
            creator   : v0,
            price     : 0x2::balance::value<0x2::sui::SUI>(&v1.balance),
        };
        0x2::event::emit<BidCreated>(v3);
        if (0x2::table::contains<0x2::object::ID, vector<Bid>>(&arg0.bids, arg1)) {
            0x1::vector::push_back<Bid>(0x2::table::borrow_mut<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1), v1);
        } else {
            0x2::table::add<0x2::object::ID, vector<Bid>>(&mut arg0.bids, arg1, 0x1::vector::singleton<Bid>(v1));
        };
        v2
    }

    public fun place_listing<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = Listing{
            id     : 0x2::object::new(arg3),
            price  : arg2,
            owner  : v0,
            nft_id : v1,
        };
        let v3 = ListingCreated{
            object_id : 0x2::object::id<Listing>(&v2),
            nft_id    : v1,
            creator   : v0,
            price     : v2.price,
        };
        0x2::event::emit<ListingCreated>(v3);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v1, v2);
    }

    // decompiled from Move bytecode v6
}

