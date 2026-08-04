module 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::orderbook {
    struct ORDERBOOK has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        index: u64,
        markets: 0x2::table::Table<0x2::object::ID, 0x1::ascii::String>,
    }

    struct Listing has store {
        listing_id: 0x2::object::ID,
        market: 0x1::ascii::String,
        index: u128,
        seller: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
    }

    struct OrderbookKey has copy, drop, store {
        nft_type: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
    }

    struct AddListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
        market: 0x1::ascii::String,
        seller: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
    }

    struct RemoveListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
        market: 0x1::ascii::String,
        seller: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        price: u64,
    }

    public(friend) fun add_listing<T0: store + key, T1>(arg0: &mut Store, arg1: &0x2::object::UID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_market(arg0, arg1);
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg2), 6);
        assert!(arg5 <= 9223372036854775807, 8);
        let v0 = *0x2::table::borrow<0x2::object::ID, 0x1::ascii::String>(&arg0.markets, 0x2::object::uid_to_inner(arg1));
        let v1 = type_string<T0>();
        let v2 = type_string<T1>();
        arg0.index = arg0.index + 1;
        let v3 = 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::utils::encode_order_id(false, arg5, arg0.index);
        let v4 = Listing{
            listing_id : arg2,
            market     : v0,
            index      : v3,
            seller     : arg3,
            nft_type   : v1,
            nft_id     : arg4,
            coin_type  : v2,
            price      : arg5,
        };
        0x2::dynamic_field::add<0x2::object::ID, Listing>(&mut arg0.id, arg2, v4);
        let v5 = OrderbookKey{
            nft_type  : v1,
            coin_type : v2,
        };
        if (!0x2::dynamic_field::exists<OrderbookKey>(&arg0.id, v5)) {
            0x2::dynamic_field::add<OrderbookKey, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::empty<0x2::object::ID>(64, 64, arg6));
        };
        0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::insert<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5), v3, arg2);
        let v6 = AddListingEvent{
            listing_id : arg2,
            market     : v0,
            seller     : arg3,
            nft_type   : v1,
            nft_id     : arg4,
            coin_type  : v2,
            price      : arg5,
        };
        0x2::event::emit<AddListingEvent>(v6);
    }

    entry fun add_market(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        0x2::table::add<0x2::object::ID, 0x1::ascii::String>(&mut arg0.markets, arg1, arg2);
    }

    fun empty_listing<T0>() : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, 0x1::ascii::String, u64) {
        (false, 0x2::object::id_from_address(@0x0), 0x1::ascii::string(b""), @0x0, 0x2::object::id_from_address(@0x0), type_string<T0>(), 0)
    }

    public fun get_floor_listing<T0: store + key, T1>(arg0: &Store) : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, 0x1::ascii::String, u64) {
        let v0 = OrderbookKey{
            nft_type  : type_string<T0>(),
            coin_type : type_string<T1>(),
        };
        if (!0x2::dynamic_field::exists<OrderbookKey>(&arg0.id, v0)) {
            return empty_listing<T1>()
        };
        let v1 = 0x2::dynamic_field::borrow<OrderbookKey, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v0);
        let (v2, v3) = 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::min_slice<0x2::object::ID>(v1);
        let v4 = v2;
        if (0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::slice_is_null(&v4)) {
            return empty_listing<T1>()
        };
        let v5 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::slice_borrow<0x2::object::ID>(0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::borrow_slice<0x2::object::ID>(v1, v4), v3));
        (true, v5.listing_id, v5.market, v5.seller, v5.nft_id, v5.coin_type, v5.price)
    }

    public fun get_next_floor_listing<T0: store + key, T1>(arg0: &Store, arg1: 0x2::object::ID) : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, 0x1::ascii::String, u64) {
        let v0 = type_string<T0>();
        let v1 = type_string<T1>();
        let v2 = OrderbookKey{
            nft_type  : v0,
            coin_type : v1,
        };
        if (!0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg1)) {
            return empty_listing<T1>()
        };
        let v3 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1);
        if (v3.nft_type != v0 || v3.coin_type != v1) {
            return empty_listing<T1>()
        };
        let v4 = v3.index;
        if (!0x2::dynamic_field::exists<OrderbookKey>(&arg0.id, v2)) {
            return empty_listing<T1>()
        };
        let v5 = 0x2::dynamic_field::borrow<OrderbookKey, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v2);
        let (v6, v7) = 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::slice_around<0x2::object::ID>(v5, v4);
        let (v8, v9) = 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::next_slice<0x2::object::ID>(v5, v6, v7);
        let v10 = v8;
        if (0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::slice_is_null(&v10)) {
            return empty_listing<T1>()
        };
        let v11 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::slice_borrow<0x2::object::ID>(0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::borrow_slice<0x2::object::ID>(v5, v10), v9));
        (true, v11.listing_id, v11.market, v11.seller, v11.nft_id, v11.coin_type, v11.price)
    }

    fun init(arg0: ORDERBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
            index   : 0,
            markets : 0x2::table::new<0x2::object::ID, 0x1::ascii::String>(arg1),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public fun is_market_authorized(arg0: &Store, arg1: &0x2::object::UID) : bool {
        0x2::table::contains<0x2::object::ID, 0x1::ascii::String>(&arg0.markets, 0x2::object::uid_to_inner(arg1))
    }

    public(friend) fun remove_listing<T0: store + key, T1>(arg0: &mut Store, arg1: &0x2::object::UID, arg2: 0x2::object::ID) {
        verify_version(arg0);
        verify_market(arg0, arg1);
        assert!(0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, arg2), 5);
        let v0 = type_string<T0>();
        let v1 = type_string<T1>();
        let v2 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg2);
        assert!(v2.nft_type == v0, 7);
        assert!(v2.coin_type == v1, 7);
        let v3 = OrderbookKey{
            nft_type  : v0,
            coin_type : v1,
        };
        assert!(0x2::dynamic_field::exists<OrderbookKey>(&arg0.id, v3), 4);
        0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::remove<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x8ebda321ece6e1ab4bf8376c9a216deebc2f16ae13e72ea100675e5f8bd16784::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v3), v2.index);
        let Listing {
            listing_id : v4,
            market     : v5,
            index      : _,
            seller     : v7,
            nft_type   : v8,
            nft_id     : v9,
            coin_type  : v10,
            price      : v11,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg2);
        let v12 = RemoveListingEvent{
            listing_id : v4,
            market     : v5,
            seller     : v7,
            nft_type   : v8,
            nft_id     : v9,
            coin_type  : v10,
            price      : v11,
        };
        0x2::event::emit<RemoveListingEvent>(v12);
    }

    entry fun remove_market(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        0x2::table::remove<0x2::object::ID, 0x1::ascii::String>(&mut arg0.markets, arg1);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun type_string<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        *0x1::type_name::as_string(&v0)
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_market(arg0: &Store, arg1: &0x2::object::UID) {
        assert!(0x2::table::contains<0x2::object::ID, 0x1::ascii::String>(&arg0.markets, 0x2::object::uid_to_inner(arg1)), 3);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version <= 1, 1);
    }

    // decompiled from Move bytecode v7
}

