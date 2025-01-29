module 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map {
    struct StorageMap<phantom T0: copy + drop + store, phantom T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        size: u64,
    }

    public fun length<T0: copy + drop + store, T1: copy + drop + store>(arg0: &StorageMap<T0, T1>) : u64 {
        arg0.size
    }

    public fun remove<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut StorageMap<T0, T1>, arg1: T0) {
        if (contains<T0, T1>(arg0, arg1)) {
            0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1);
            arg0.size = arg0.size - 1;
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<T0, T0>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::none<T0>());
        };
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : StorageMap<T0, T1> {
        StorageMap<T0, T1>{
            id   : 0x2::object::new(arg1),
            name : 0x1::ascii::string(arg0),
            size : 0,
        }
    }

    public fun contains<T0: copy + drop + store, T1: copy + drop + store>(arg0: &StorageMap<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: copy + drop + store>(arg0: StorageMap<T0, T1>) {
        let StorageMap {
            id   : v0,
            name : _,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get<T0: copy + drop + store, T1: copy + drop + store>(arg0: &StorageMap<T0, T1>, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun is_empty<T0: copy + drop + store, T1: copy + drop + store>(arg0: &StorageMap<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun set<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut StorageMap<T0, T1>, arg1: T0, arg2: T1) {
        if (contains<T0, T1>(arg0, arg1)) {
            0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1);
            0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
        } else {
            0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
            arg0.size = arg0.size + 1;
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_set_record<T0, T0, T1>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::none<T0>(), 0x1::option::some<T1>(arg2));
    }

    public fun try_get<T0: copy + drop + store, T1: copy + drop + store>(arg0: &StorageMap<T0, T1>, arg1: T0) : 0x1::option::Option<T1> {
        if (contains<T0, T1>(arg0, arg1)) {
            0x1::option::some<T1>(*get<T0, T1>(arg0, arg1))
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun try_remove<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut StorageMap<T0, T1>, arg1: T0) : 0x1::option::Option<T1> {
        if (contains<T0, T1>(arg0, arg1)) {
            arg0.size = arg0.size - 1;
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_event::emit_remove_record<T0, T0>(arg0.name, 0x1::option::some<T0>(arg1), 0x1::option::none<T0>());
            0x1::option::some<T1>(0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1))
        } else {
            0x1::option::none<T1>()
        }
    }

    // decompiled from Move bytecode v6
}

