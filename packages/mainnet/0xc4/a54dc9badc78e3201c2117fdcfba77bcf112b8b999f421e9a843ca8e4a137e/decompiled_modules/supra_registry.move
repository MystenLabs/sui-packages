module 0xc4a54dc9badc78e3201c2117fdcfba77bcf112b8b999f421e9a843ca8e4a137e::supra_registry {
    struct SupraRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, vector<u32>>,
    }

    struct SupraRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun get_supra_pairs_sequence<T0>(arg0: &SupraRegistry) : vector<u32> {
        *0x2::table::borrow<0x1::type_name::TypeName, vector<u32>>(&arg0.table, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SupraRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, vector<u32>>(arg0),
        };
        let v1 = SupraRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<SupraRegistry>(&v0),
        };
        0x2::transfer::share_object<SupraRegistry>(v0);
        0x2::transfer::transfer<SupraRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun register_supra_pairs_sequence<T0>(arg0: &mut SupraRegistry, arg1: &SupraRegistryCap, arg2: vector<u32>) {
        assert!(0x2::object::id<SupraRegistry>(arg0) == arg1.for, 70407);
        assert!(0x1::vector::length<u32>(&arg2) % 2 == 1, 70408);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg2)) {
            let v1 = *0x1::vector::borrow<u32>(&arg2, v0);
            if (v0 % 2 == 1) {
                assert!(v1 == 0 || v1 == 1, 70409);
            };
            v0 = v0 + 1;
        };
        let v2 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, vector<u32>>(&arg0.table, v2)) {
            0x2::table::remove<0x1::type_name::TypeName, vector<u32>>(&mut arg0.table, v2);
        };
        0x2::table::add<0x1::type_name::TypeName, vector<u32>>(&mut arg0.table, v2, arg2);
    }

    // decompiled from Move bytecode v6
}

