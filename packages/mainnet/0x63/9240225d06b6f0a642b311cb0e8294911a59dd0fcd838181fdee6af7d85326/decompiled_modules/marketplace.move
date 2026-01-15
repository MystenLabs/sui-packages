module 0x639240225d06b6f0a642b311cb0e8294911a59dd0fcd838181fdee6af7d85326::marketplace {
    struct Listing has store, key {
        id: 0x2::object::UID,
        nft: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration,
        seller: address,
        price: u64,
        domain_name: 0x1::string::String,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        price: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
    }

    struct ListingSold has copy, drop {
        listing_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        buyer: address,
        price: u64,
    }

    public entry fun buy_domain(arg0: &mut Marketplace, arg1: Listing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id          : v0,
            nft         : v1,
            seller      : v2,
            price       : v3,
            domain_name : v4,
        } = arg1;
        let v5 = v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 2);
        let v6 = 0x2::tx_context::sender(arg3);
        let v7 = v3 * arg0.fee_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3 - v7, arg3), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v7, arg3), arg0.fee_recipient);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v1, v6);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.listings, v4);
        let v8 = ListingSold{
            listing_id  : 0x2::object::uid_to_inner(&v5),
            domain_name : v4,
            seller      : v2,
            buyer       : v6,
            price       : v3,
        };
        0x2::event::emit<ListingSold>(v8);
        0x2::object::delete(v5);
    }

    public entry fun cancel_listing(arg0: &mut Marketplace, arg1: Listing, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.seller, 0);
        let Listing {
            id          : v0,
            nft         : v1,
            seller      : v2,
            price       : _,
            domain_name : v4,
        } = arg1;
        let v5 = v0;
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.listings, v4);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v1, v2);
        let v6 = ListingCancelled{
            listing_id  : 0x2::object::uid_to_inner(&v5),
            domain_name : v4,
            seller      : v2,
        };
        0x2::event::emit<ListingCancelled>(v6);
        0x2::object::delete(v5);
    }

    public fun get_listing_domain(arg0: &Listing) : 0x1::string::String {
        arg0.domain_name
    }

    public fun get_listing_id(arg0: &Marketplace, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.listings, arg1)
    }

    public fun get_listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun get_listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id            : 0x2::object::new(arg0),
            listings      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            fee_bps       : 250,
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun is_listed(arg0: &Marketplace, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.listings, arg1)
    }

    public entry fun list_domain(arg0: &mut Marketplace, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Listing{
            id          : 0x2::object::new(arg3),
            nft         : arg1,
            seller      : v1,
            price       : arg2,
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0),
        };
        let v3 = 0x2::object::id<Listing>(&v2);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.listings, v2.domain_name, v3);
        let v4 = ListingCreated{
            listing_id  : v3,
            domain_name : v2.domain_name,
            seller      : v1,
            price       : arg2,
        };
        0x2::event::emit<ListingCreated>(v4);
        0x2::transfer::share_object<Listing>(v2);
    }

    public entry fun update_price(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 0);
        assert!(arg1 > 0, 1);
        arg0.price = arg1;
    }

    // decompiled from Move bytecode v6
}

