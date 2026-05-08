module 0xd7686a6fa87a2833344290622ef149b86b3c2c5551bdb0b6865506f1d7e70381::nft_marketplace {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        nft: NFT,
        price: u64,
        seller: address,
    }

    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        publisher: address,
        balance: 0x2::balance::Balance<T0>,
        listings: 0x2::bag::Bag,
        payments: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ListNFTEvent has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct DelistNFTEvent has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct PurchaseNFTEvent has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    entry fun burn(arg0: NFT) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            nft    : v1,
            price  : v2,
            seller : v3,
        } = 0x2::bag::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(0x2::coin::value<T1>(&arg2) >= v2, 1);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = v2 * 2 / 100;
        if (0x2::table::contains<address, 0x2::coin::Coin<T1>>(&arg0.payments, v3)) {
            0x2::coin::join<T1>(0x2::table::borrow_mut<address, 0x2::coin::Coin<T1>>(&mut arg0.payments, v3), 0x2::coin::split<T1>(&mut arg2, v2 - v5, arg3));
        } else {
            0x2::table::add<address, 0x2::coin::Coin<T1>>(&mut arg0.payments, v3, 0x2::coin::split<T1>(&mut arg2, v2 - v5, arg3));
        };
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg3)));
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v4);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v6 = PurchaseNFTEvent{
            nft_id : arg1,
            buyer  : v4,
            seller : v3,
            price  : v2,
        };
        0x2::event::emit<PurchaseNFTEvent>(v6);
        0x2::transfer::public_transfer<NFT>(v1, v4);
        0x2::object::delete(v0);
    }

    entry fun delist_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            nft    : v1,
            price  : _,
            seller : v3,
        } = 0x2::bag::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(0x2::tx_context::sender(arg2) == v3, 2);
        let v4 = DelistNFTEvent{
            nft_id : arg1,
            seller : v3,
        };
        0x2::event::emit<DelistNFTEvent>(v4);
        0x2::transfer::public_transfer<NFT>(v1, v3);
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace<0x2::sui::SUI>{
            id        : 0x2::object::new(arg0),
            publisher : 0x2::tx_context::sender(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            listings  : 0x2::bag::new(arg0),
            payments  : 0x2::table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg0),
        };
        0x2::transfer::share_object<Marketplace<0x2::sui::SUI>>(v0);
    }

    public fun is_listed(arg0: &Marketplace<0x2::sui::SUI>, arg1: 0x2::object::ID) : bool {
        0x2::bag::contains<0x2::object::ID>(&arg0.listings, arg1)
    }

    entry fun list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: NFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = nft_id(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Listing{
            id     : 0x2::object::new(arg3),
            nft    : arg1,
            price  : arg2,
            seller : v1,
        };
        0x2::bag::add<0x2::object::ID, Listing>(&mut arg0.listings, v0, v2);
        let v3 = ListNFTEvent{
            nft_id : v0,
            seller : v1,
            price  : arg2,
        };
        0x2::event::emit<ListNFTEvent>(v3);
    }

    public fun listing_count(arg0: &Marketplace<0x2::sui::SUI>) : u64 {
        0x2::bag::length(&arg0.listings)
    }

    public fun listing_nft_id(arg0: &Marketplace<0x2::sui::SUI>, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(is_listed(arg0, arg1), 3);
        arg1
    }

    public fun listing_price(arg0: &Marketplace<0x2::sui::SUI>, arg1: 0x2::object::ID) : u64 {
        assert!(is_listed(arg0, arg1), 3);
        0x2::bag::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).price
    }

    public fun listing_seller(arg0: &Marketplace<0x2::sui::SUI>, arg1: 0x2::object::ID) : address {
        assert!(is_listed(arg0, arg1), 3);
        0x2::bag::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).seller
    }

    public fun marketplace_balance(arg0: &Marketplace<0x2::sui::SUI>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun nft_id(arg0: &NFT) : 0x2::object::ID {
        0x2::object::id<NFT>(arg0)
    }

    entry fun take_profits_and_keep<T0>(arg0: &mut Marketplace<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.payments, 0x2::tx_context::sender(arg1)), 0x2::tx_context::sender(arg1));
    }

    entry fun update_nft_description(arg0: &mut NFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    entry fun withdraw_marketplace_fees(arg0: &mut Marketplace<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.publisher, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

