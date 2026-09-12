module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        symbols: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        curves: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        count: u64,
    }

    public fun assert_valid_symbol(arg0: &0x1::ascii::String) {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 > 0, 1);
        assert!(v1 <= 12, 2);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v3 >= 65 && v3 <= 90;
            let v5 = v3 >= 48 && v3 <= 57;
            assert!(v4 || v5, 3);
            v2 = v2 + 1;
        };
    }

    public fun contains_type<T0>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.curves, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun curve_of_symbol(arg0: &Registry, arg1: 0x1::ascii::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.symbols, arg1)
    }

    public fun curve_of_type<T0>(arg0: &Registry) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.curves, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            symbols : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
            curves  : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_symbol_available(arg0: &Registry, arg1: 0x1::ascii::String) : bool {
        !0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.symbols, arg1)
    }

    public(friend) fun register<T0>(arg0: &mut Registry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) {
        assert_valid_symbol(&arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.curves, v0), 4);
        if (!0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.symbols, arg1)) {
            0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.symbols, arg1, arg2);
        };
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.curves, v0, arg2);
        arg0.count = arg0.count + 1;
    }

    public fun token_count(arg0: &Registry) : u64 {
        arg0.count
    }

    // decompiled from Move bytecode v7
}

