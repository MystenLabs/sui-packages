module 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value {
    struct StorageValue<phantom T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        size: u64,
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut StorageValue<T0>) {
        if (contains<T0>(arg0)) {
            0x2::dynamic_field::remove<u8, T0>(&mut arg0.id, 0);
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<u8, u8>(arg0.name, 0x1::option::none<u8>(), 0x1::option::none<u8>());
        };
    }

    public fun new<T0: copy + drop + store>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : StorageValue<T0> {
        StorageValue<T0>{
            id   : 0x2::object::new(arg1),
            name : 0x1::ascii::string(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store>(arg0: &StorageValue<T0>) : bool {
        0x2::dynamic_field::exists_with_type<u8, T0>(&arg0.id, 0)
    }

    public fun drop<T0: copy + drop + store>(arg0: StorageValue<T0>) {
        let StorageValue {
            id   : v0,
            name : _,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get<T0: copy + drop + store>(arg0: &StorageValue<T0>) : &T0 {
        0x2::dynamic_field::borrow<u8, T0>(&arg0.id, 0)
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &StorageValue<T0>) : bool {
        !0x2::dynamic_field::exists_with_type<u8, T0>(&arg0.id, 0)
    }

    public fun set<T0: copy + drop + store>(arg0: &mut StorageValue<T0>, arg1: T0) {
        if (contains<T0>(arg0)) {
            0x2::dynamic_field::remove<u8, T0>(&mut arg0.id, 0);
        };
        0x2::dynamic_field::add<u8, T0>(&mut arg0.id, 0, arg1);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_set_record<u8, u8, T0>(arg0.name, 0x1::option::none<u8>(), 0x1::option::none<u8>(), 0x1::option::some<T0>(arg1));
    }

    public fun try_get<T0: copy + drop + store>(arg0: &StorageValue<T0>) : 0x1::option::Option<T0> {
        if (contains<T0>(arg0)) {
            0x1::option::some<T0>(*get<T0>(arg0))
        } else {
            0x1::option::none<T0>()
        }
    }

    public fun try_remove<T0: copy + drop + store>(arg0: &mut StorageValue<T0>) : 0x1::option::Option<T0> {
        if (contains<T0>(arg0)) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<u8, u8>(arg0.name, 0x1::option::none<u8>(), 0x1::option::none<u8>());
            0x1::option::some<T0>(0x2::dynamic_field::remove<u8, T0>(&mut arg0.id, 0))
        } else {
            0x1::option::none<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

