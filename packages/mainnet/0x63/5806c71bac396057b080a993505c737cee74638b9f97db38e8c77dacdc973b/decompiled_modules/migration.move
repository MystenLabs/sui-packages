module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::migration {
    struct MigrationRegistry has copy, drop, store {
        completed: 0x2::vec_set::VecSet<vector<u8>>,
    }

    public fun add_dynamic_data<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(arg0, arg1, arg2);
    }

    public fun borrow_dynamic_data<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(arg0, arg1)
    }

    public fun borrow_dynamic_data_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(arg0, arg1)
    }

    public fun get_completed_migrations(arg0: &0x2::object::UID) : vector<vector<u8>> {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, MigrationRegistry>(arg0, b"__migrations__")) {
            return 0x1::vector::empty<vector<u8>>()
        };
        0x2::vec_set::into_keys<vector<u8>>(0x2::dynamic_field::borrow<vector<u8>, MigrationRegistry>(arg0, b"__migrations__").completed)
    }

    public fun get_migration_count(arg0: &0x2::object::UID) : u64 {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, MigrationRegistry>(arg0, b"__migrations__")) {
            return 0
        };
        0x2::vec_set::length<vector<u8>>(&0x2::dynamic_field::borrow<vector<u8>, MigrationRegistry>(arg0, b"__migrations__").completed)
    }

    public fun has_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, T1>(arg0, arg1)
    }

    public fun is_migration_completed(arg0: &0x2::object::UID, arg1: vector<u8>) : bool {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, MigrationRegistry>(arg0, b"__migrations__")) {
            return false
        };
        0x2::vec_set::contains<vector<u8>>(&0x2::dynamic_field::borrow<vector<u8>, MigrationRegistry>(arg0, b"__migrations__").completed, &arg1)
    }

    public fun mark_migration_completed(arg0: &mut 0x2::object::UID, arg1: vector<u8>) {
        if (!0x2::dynamic_field::exists_with_type<vector<u8>, MigrationRegistry>(arg0, b"__migrations__")) {
            let v0 = MigrationRegistry{completed: 0x2::vec_set::empty<vector<u8>>()};
            0x2::dynamic_field::add<vector<u8>, MigrationRegistry>(arg0, b"__migrations__", v0);
        };
        0x2::vec_set::insert<vector<u8>>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, MigrationRegistry>(arg0, b"__migrations__").completed, arg1);
    }

    public fun remove_dynamic_data<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

