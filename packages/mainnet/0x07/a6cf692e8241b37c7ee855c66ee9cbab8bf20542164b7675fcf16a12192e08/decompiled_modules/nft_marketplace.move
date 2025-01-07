module 0x7a6cf692e8241b37c7ee855c66ee9cbab8bf20542164b7675fcf16a12192e08::nft_marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        owner: address,
        fee_percentage: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_listings: u64,
        active_listings: u64,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        created_at: u64,
        is_active: bool,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        created_at: u64,
    }

    struct ListingSold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        fee_amount: u64,
    }

    struct ListingCanceled has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun cancel_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seller == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1.is_active, 4);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), arg1.seller);
        arg1.is_active = false;
        arg0.active_listings = arg0.active_listings - 1;
        let v0 = ListingCanceled{
            listing_id : 0x2::object::id<Listing>(arg1),
            nft_id     : arg1.nft_id,
            seller     : arg1.seller,
        };
        0x2::event::emit<ListingCanceled>(v0);
    }

    public entry fun create_listing<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Listing{
            id         : 0x2::object::new(arg3),
            nft_id     : v0,
            seller     : v1,
            price      : arg2,
            created_at : 0x2::tx_context::epoch(arg3),
            is_active  : true,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"nft", arg1);
        arg0.total_listings = arg0.total_listings + 1;
        arg0.active_listings = arg0.active_listings + 1;
        let v3 = ListingCreated{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : v0,
            seller     : v1,
            price      : arg2,
            created_at : v2.created_at,
        };
        0x2::event::emit<ListingCreated>(v3);
        0x2::transfer::share_object<Listing>(v2);
    }

    public fun get_fee_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun get_listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun get_listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    public fun get_marketplace_stats(arg0: &Marketplace) : (u64, u64, u64) {
        (arg0.fee_percentage, arg0.total_listings, arg0.active_listings)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            fee_percentage  : 10,
            fee_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            total_listings  : 0,
            active_listings : 0,
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun is_listing_active(arg0: &Listing) : bool {
        arg0.is_active
    }

    public entry fun purchase_listing<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Listing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.price, 1);
        let v0 = arg1.price * arg0.fee_percentage / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.price - v0, arg3), arg1.seller);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), 0x2::tx_context::sender(arg3));
        arg1.is_active = false;
        arg0.active_listings = arg0.active_listings - 1;
        let v1 = ListingSold{
            listing_id : 0x2::object::id<Listing>(arg1),
            nft_id     : arg1.nft_id,
            seller     : arg1.seller,
            buyer      : 0x2::tx_context::sender(arg3),
            price      : arg1.price,
            fee_amount : v0,
        };
        0x2::event::emit<ListingSold>(v1);
    }

    public entry fun update_fee_percentage(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1 <= 1000, 3);
        arg0.fee_percentage = arg1;
    }

    public entry fun withdraw_fees(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance) > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee_balance), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

