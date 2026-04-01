module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::listing_manager {
    struct Listing has copy, drop, store {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        price: u64,
        min_price: u64,
        listing_type: u8,
        expires_at: u64,
        created_at: u64,
        active: bool,
    }

    struct ListingManager has store {
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        purchase_caps: 0x2::object_bag::ObjectBag,
        seller_listings: 0x2::table::Table<address, vector<0x2::object::ID>>,
        nft_listings: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ListingManager {
        ListingManager{
            listings        : 0x2::table::new<0x2::object::ID, Listing>(arg0),
            purchase_caps   : 0x2::object_bag::new(arg0),
            seller_listings : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            nft_listings    : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        }
    }

    public fun can_cleanup_expired_listing(arg0: &ListingManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        v1 >= v0.expires_at && v1 >= v0.expires_at + 604800000
    }

    public(friend) fun cancel_listing<T0: store + key>(arg0: &mut ListingManager, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == arg2, 1);
        assert!(v0.active, 6);
        let v1 = v0.seller;
        let v2 = v0.nft_id;
        v0.active = false;
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, v2)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_listings, v2);
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seller_listings, v1)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seller_listings, v1);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(v3, &arg1);
            if (v4) {
                0x1::vector::remove<0x2::object::ID>(v3, v5);
            };
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_listing_cancelled(arg1, arg2, v2, 0x2::clock::timestamp_ms(arg3));
        0x2::object_bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.purchase_caps, arg1)
    }

    public(friend) fun cleanup_expired_listing<T0: store + key>(arg0: &mut ListingManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 0);
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.expires_at, 6);
        assert!(v0.active, 6);
        let v1 = v0.seller;
        let v2 = v0.nft_id;
        0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1).active = false;
        0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, v2)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_listings, v2);
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seller_listings, v1)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seller_listings, v1);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(v3, &arg1);
            if (v4) {
                0x1::vector::remove<0x2::object::ID>(v3, v5);
            };
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_listing_expired_cleanup(arg1, v1, v2, v0.expires_at, 0x2::clock::timestamp_ms(arg2));
        0x2::object_bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.purchase_caps, arg1)
    }

    public fun collection_id(arg0: &Listing) : 0x2::object::ID {
        arg0.collection_id
    }

    public(friend) fun create_fixed_listing<T0: store + key>(arg0: &mut ListingManager, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::kiosk::PurchaseCap<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 >= arg6, 2);
        assert!(arg5 > 0, 2);
        assert!(arg7 <= 7776000000, 4);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, arg3), 5);
        let v0 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg10));
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = v1 + arg7;
        let v3 = Listing{
            listing_id    : v0,
            seller        : arg1,
            kiosk_id      : arg2,
            nft_id        : arg3,
            collection_id : arg4,
            price         : arg5,
            min_price     : arg6,
            listing_type  : 0,
            expires_at    : v2,
            created_at    : v1,
            active        : true,
        };
        0x2::object_bag::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.purchase_caps, v0, arg8);
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v0, v3);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_listings, arg3, v0);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seller_listings, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.seller_listings, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seller_listings, arg1), v0);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_listing_created(v0, arg1, arg2, arg3, arg4, arg5, 0, v2, v1);
        v0
    }

    public fun created_at(arg0: &Listing) : u64 {
        arg0.created_at
    }

    public fun expires_at(arg0: &Listing) : u64 {
        arg0.expires_at
    }

    public fun get_listing(arg0: &ListingManager, arg1: 0x2::object::ID) : Listing {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 0);
        *0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1)
    }

    public fun get_listing_by_nft(arg0: &ListingManager, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, arg1), 0);
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, arg1)
    }

    public fun has_active_listing(arg0: &ListingManager, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, arg1)
    }

    public fun is_active(arg0: &Listing) : bool {
        arg0.active
    }

    public fun is_fixed_listing(arg0: &Listing) : bool {
        arg0.listing_type == 0
    }

    public fun is_listing_active(arg0: &ListingManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
        v0.active && 0x2::clock::timestamp_ms(arg2) < v0.expires_at
    }

    public fun kiosk_id(arg0: &Listing) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun listing_cleanup_grace_period() : u64 {
        604800000
    }

    public fun listing_id(arg0: &Listing) : 0x2::object::ID {
        arg0.listing_id
    }

    public fun listing_type(arg0: &Listing) : u8 {
        arg0.listing_type
    }

    public fun listing_type_fixed() : u8 {
        0
    }

    public fun max_listing_duration() : u64 {
        7776000000
    }

    public fun min_price(arg0: &Listing) : u64 {
        arg0.min_price
    }

    public fun nft_id(arg0: &Listing) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun seller(arg0: &Listing) : address {
        arg0.seller
    }

    public(friend) fun take_purchase_cap<T0: store + key>(arg0: &mut ListingManager, arg1: 0x2::object::ID) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.active, 6);
        let v1 = v0.seller;
        let v2 = v0.nft_id;
        v0.active = false;
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.nft_listings, v2)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.nft_listings, v2);
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seller_listings, v1)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seller_listings, v1);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(v3, &arg1);
            if (v4) {
                0x1::vector::remove<0x2::object::ID>(v3, v5);
            };
        };
        0x2::object_bag::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.purchase_caps, arg1)
    }

    public(friend) fun update_listing_price(arg0: &mut ListingManager, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 0);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == arg3, 1);
        assert!(v0.active, 6);
        assert!(v0.listing_type == 0, 3);
        assert!(arg2 >= v0.min_price, 2);
        v0.price = arg2;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_listing_price_updated(arg1, v0.price, arg2, 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v6
}

