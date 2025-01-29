module 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map {
    struct Entry<T0: copy + drop + store, T1: copy + drop + store> has copy, drop, store {
        key1: T0,
        key2: T1,
    }

    struct StorageDoubleMap<phantom T0: copy + drop + store, phantom T1: copy + drop + store, phantom T2: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        size: u64,
    }

    public fun length<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>) : u64 {
        arg0.size
    }

    public fun remove<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) {
        if (contains<T0, T1, T2>(arg0, arg1, arg2)) {
            let v0 = Entry<T0, T1>{
                key1 : arg1,
                key2 : arg2,
            };
            0x2::dynamic_field::remove<Entry<T0, T1>, T2>(&mut arg0.id, v0);
            arg0.size = arg0.size - 1;
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<T0, T1>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::some<T1>(arg2));
        };
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : StorageDoubleMap<T0, T1, T2> {
        StorageDoubleMap<T0, T1, T2>{
            id   : 0x2::object::new(arg1),
            name : 0x1::ascii::string(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : bool {
        let v0 = Entry<T0, T1>{
            key1 : arg1,
            key2 : arg2,
        };
        0x2::dynamic_field::exists_with_type<Entry<T0, T1>, T2>(&arg0.id, v0)
    }

    public fun drop<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: StorageDoubleMap<T0, T1, T2>) {
        let StorageDoubleMap {
            id   : v0,
            name : _,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : &T2 {
        let v0 = Entry<T0, T1>{
            key1 : arg1,
            key2 : arg2,
        };
        0x2::dynamic_field::borrow<Entry<T0, T1>, T2>(&arg0.id, v0)
    }

    public fun is_empty<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>) : bool {
        arg0.size == 0
    }

    public fun set<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1, arg3: T2) {
        let v0 = Entry<T0, T1>{
            key1 : arg1,
            key2 : arg2,
        };
        if (contains<T0, T1, T2>(arg0, arg1, arg2)) {
            0x2::dynamic_field::remove<Entry<T0, T1>, T2>(&mut arg0.id, v0);
            0x2::dynamic_field::add<Entry<T0, T1>, T2>(&mut arg0.id, v0, arg3);
        } else {
            0x2::dynamic_field::add<Entry<T0, T1>, T2>(&mut arg0.id, v0, arg3);
            arg0.size = arg0.size + 1;
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_set_record<T0, T1, T2>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::some<T1>(arg2), 0x1::option::some<T2>(arg3));
    }

    public fun try_get<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : 0x1::option::Option<T2> {
        if (contains<T0, T1, T2>(arg0, arg1, arg2)) {
            0x1::option::some<T2>(*get<T0, T1, T2>(arg0, arg1, arg2))
        } else {
            0x1::option::none<T2>()
        }
    }

    public fun try_remove<T0: copy + drop + store, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut StorageDoubleMap<T0, T1, T2>, arg1: T0, arg2: T1) : 0x1::option::Option<T2> {
        if (contains<T0, T1, T2>(arg0, arg1, arg2)) {
            let v1 = Entry<T0, T1>{
                key1 : arg1,
                key2 : arg2,
            };
            arg0.size = arg0.size - 1;
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<T0, T1>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::some<T1>(arg2));
            0x1::option::some<T2>(0x2::dynamic_field::remove<Entry<T0, T1>, T2>(&mut arg0.id, v1))
        } else {
            0x1::option::none<T2>()
        }
    }

    // decompiled from Move bytecode v6
}

