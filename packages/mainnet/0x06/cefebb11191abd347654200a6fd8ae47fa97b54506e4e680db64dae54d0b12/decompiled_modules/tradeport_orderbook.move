module 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::tradeport_orderbook {
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
        let v3 = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::utils::encode_order_id(false, arg5, arg0.index);
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
            0x2::dynamic_field::add<OrderbookKey, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::empty<0x2::object::ID>(64, 64, arg6));
        };
        0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::insert<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v5), v3, arg2);
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
        let v1 = OrderbookKey{nft_type: *0x1::type_name::as_string(&v0)};
        if (!0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v1)) {
            return empty_listing()
        };
        let v2 = 0x2::dynamic_field::borrow<OrderbookKey, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v1);
        let (v3, v4) = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::min_slice<0x2::object::ID>(v2);
        let v5 = v3;
        if (0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::slice_is_null(&v5)) {
            return empty_listing()
        };
        let v6 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::slice_borrow<0x2::object::ID>(0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::borrow_slice<0x2::object::ID>(v2, v5), v4));
        (true, v6.listing_id, v6.market, v6.seller, v6.nft_id, v6.price)
    }

    public fun get_next_floor_listing<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID) : (bool, 0x2::object::ID, 0x1::ascii::String, address, 0x2::object::ID, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = OrderbookKey{nft_type: *0x1::type_name::as_string(&v0)};
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            return empty_listing()
        };
        if (!0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v1)) {
            return empty_listing()
        };
        let v2 = 0x2::dynamic_field::borrow<OrderbookKey, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::BigVector<0x2::object::ID>>(&arg0.id, v1);
        let (v3, v4) = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::slice_around<0x2::object::ID>(v2, 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1).index);
        let (v5, v6) = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::next_slice<0x2::object::ID>(v2, v3, v4);
        let v7 = v5;
        if (0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::slice_is_null(&v7)) {
            return empty_listing()
        };
        let v8 = 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, *0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::slice_borrow<0x2::object::ID>(0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::borrow_slice<0x2::object::ID>(v2, v7), v6));
        (true, v8.listing_id, v8.market, v8.seller, v8.nft_id, v8.price)
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
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = OrderbookKey{nft_type: *0x1::type_name::as_string(&v0)};
        assert!(0x2::dynamic_field::exists_<OrderbookKey>(&arg0.id, v1), 4);
        0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::remove<0x2::object::ID>(0x2::dynamic_field::borrow_mut<OrderbookKey, 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::big_vector::BigVector<0x2::object::ID>>(&mut arg0.id, v1), 0x2::dynamic_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg2).index);
        let Listing {
            listing_id : v2,
            market     : v3,
            index      : _,
            seller     : v5,
            nft_type   : v6,
            nft_id     : v7,
            price      : v8,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg2);
        let v9 = RemoveListingEvent{
            listing_id : v2,
            market     : v3,
            seller     : v5,
            nft_type   : v6,
            nft_id     : v7,
            price      : v8,
        };
        0x2::event::emit<RemoveListingEvent>(v9);
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

