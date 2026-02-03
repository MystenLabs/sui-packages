module 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::tradeport_orderbook {
    struct TRADEPORT_ORDERBOOK has drop {
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
        price: u64,
    }

    struct OrderbookKey has copy, drop, store {
        nft_type: 0x1::ascii::String,
    }

    struct AddListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
        market: 0x1::ascii::String,
        seller: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        price: u64,
    }

    struct RemoveListingEvent has copy, drop {
        listing_id: 0x2::object::ID,
        market: 0x1::ascii::String,
        seller: address,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        price: u64,
    }

    public fun add_listing<T0: store + key>(arg0: &mut Store, arg1: &0x2::object::UID, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_market(arg0, arg1);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg2), 6);
        let v0 = *0x2::table::borrow<0x2::object::ID, 0x1::ascii::String>(&arg0.markets, 0x2::object::uid_to_inner(arg1));
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = *0x1::type_name::as_string(&v1);
        arg0.index = arg0.index + 1;
        let v3 = 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::utils::encode_order_id(false, arg5, arg0.index);
        let v4 = Listing{
            listing_id : arg2,
            market     : v0,
            index      : v3,
            seller     : arg3,
            nft_type   : v2,
            nft_id     : arg4,
            price      : arg5,
        };
        0x2::dynamic_field::add<0x2::object::ID, Listing>(&mut arg0.id, arg2, v4);
        let v5 = OrderbookKey{nft_type: v2};
        if (!0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v5)) {
            0x2::dynamic_field::add<OrderbookKey, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::empty<0x2::object::ID>(64, 64, arg6));
        };
        0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::insert<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5), v3, arg2);
        let v6 = AddListingEvent{
            listing_id : arg2,
            market     : v0,
            seller     : arg3,
            nft_type   : v2,
            nft_id     : arg4,
            price      : arg5,
        };
        0x2::event::emit<AddListingEvent>(v6);
    }

    entry fun add_market(arg0: &mut Store, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        0x2::table::add<0x2::object::ID, 0x1::ascii::String>(&mut arg0.markets, arg1, arg2);
    }

    fun empty_listing() : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, u64) {
        (false, 0x2::object::id_from_address(@0x0), 0x1::ascii::string(b""), @0x0, 0x2::object::id_from_address(@0x0), 0)
    }

    public fun get_floor_listing<T0: store + key>(arg0: &Store) : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::type_name::as_string(&v0);
        let v2 = OrderbookKey{nft_type: v1};
        if (!0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v2)) {
            return empty_listing()
        };
        let v3 = 0x2::dynamic_field::borrow<OrderbookKey, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v2);
        let (v4, v5) = 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::min_slice<0x2::object::ID>(v3);
        let v6 = v4;
        if (0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::slice_is_null(&v6)) {
            return empty_listing()
        };
        let v7 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::slice_borrow<0x2::object::ID>(0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::borrow_slice<0x2::object::ID>(v3, v6), v5));
        if (v7.nft_type != v1) {
            return empty_listing()
        };
        (true, v7.listing_id, v7.market, v7.seller, v7.nft_id, v7.price)
    }

    public fun get_next_floor_listing<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID) : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::type_name::as_string(&v0);
        let v2 = OrderbookKey{nft_type: v1};
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            return empty_listing()
        };
        if (!0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v2)) {
            return empty_listing()
        };
        let v3 = 0x2::dynamic_field::borrow<OrderbookKey, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v2);
        let (v4, v5) = 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::slice_around<0x2::object::ID>(v3, 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1).index);
        let (v6, v7) = 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::next_slice<0x2::object::ID>(v3, v4, v5);
        let v8 = v6;
        if (0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::slice_is_null(&v8)) {
            return empty_listing()
        };
        let v9 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::slice_borrow<0x2::object::ID>(0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::borrow_slice<0x2::object::ID>(v3, v8), v7));
        if (v9.nft_type != v1) {
            return empty_listing()
        };
        (true, v9.listing_id, v9.market, v9.seller, v9.nft_id, v9.price)
    }

    fun init(arg0: TRADEPORT_ORDERBOOK, arg1: &mut 0x2::tx_context::TxContext) {
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

    public fun remove_listing<T0: store + key>(arg0: &mut Store, arg1: &0x2::object::UID, arg2: 0x2::object::ID) {
        verify_version(arg0);
        verify_market(arg0, arg1);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg2), 5);
        let Listing {
            listing_id : v0,
            market     : v1,
            index      : v2,
            seller     : v3,
            nft_type   : v4,
            nft_id     : v5,
            price      : v6,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg2);
        let v7 = 0x1::type_name::with_defining_ids<T0>();
        let v8 = *0x1::type_name::as_string(&v7);
        let v9 = OrderbookKey{nft_type: v8};
        assert!(0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v9), 4);
        assert!(v4 == v8, 7);
        0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::remove<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x491e5a8de7e6ac863e78aa571d4443a85fdce8d4dbb3371a1eb5255af56971f5::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v9), v2);
        let v10 = RemoveListingEvent{
            listing_id : v0,
            market     : v1,
            seller     : v3,
            nft_type   : v8,
            nft_id     : v5,
            price      : v6,
        };
        0x2::event::emit<RemoveListingEvent>(v10);
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

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_market(arg0: &Store, arg1: &0x2::object::UID) {
        assert!(0x2::table::contains<0x2::object::ID, 0x1::ascii::String>(&arg0.markets, 0x2::object::uid_to_inner(arg1)), 3);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version <= 1, 1);
    }

    // decompiled from Move bytecode v6
}

