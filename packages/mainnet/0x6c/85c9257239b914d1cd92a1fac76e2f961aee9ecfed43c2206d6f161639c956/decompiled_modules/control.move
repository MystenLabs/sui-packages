module 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::control {
    struct Store has key {
        id: 0x2::object::UID,
        version: u32,
        pools: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        count: u64,
    }

    struct StoreOwner has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun add<T0, T1>(arg0: &mut Store, arg1: 0x2::object::ID) {
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, get_name_x_y<T0, T1>(), arg1);
        arg0.count = arg0.count + 1;
    }

    public fun check_version(arg0: &mut Store) {
        assert!(arg0.version == 1, 203);
    }

    public(friend) fun exist<T0, T1>(arg0: &mut Store) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, get_name_x_y<T0, T1>())
    }

    public fun get_name<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    public fun get_name_u8array<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_name_x_y<T0, T1>() : 0x1::string::String {
        let v0 = get_name<T0>();
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, get_name<T1>());
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id      : 0x2::object::new(arg0),
            version : 1,
            pools   : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Store>(v0);
        let v1 = StoreOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StoreOwner>(v1, @0x87448429b1cf7511a80c553cc26419c8798fdf617635c434896ee7113db21472);
    }

    entry fun migrate(arg0: &mut StoreOwner, arg1: &mut Store) {
        assert!(arg1.version < 1, 202);
        arg1.version = 1;
    }

    entry fun withdraw<T0, T1>(arg0: &mut StoreOwner, arg1: &mut Store, arg2: &mut 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::pool::Pool<T0, T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let (v0, v1) = 0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::pool::withdraw_transaction_fee<T0, T1>(arg2, arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg3);
        0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::events::emit_transaction_fee_withdraw(0x2::object::id<0x6c85c9257239b914d1cd92a1fac76e2f961aee9ecfed43c2206d6f161639c956::pool::Pool<T0, T1>>(arg2), 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), arg3);
    }

    // decompiled from Move bytecode v6
}

