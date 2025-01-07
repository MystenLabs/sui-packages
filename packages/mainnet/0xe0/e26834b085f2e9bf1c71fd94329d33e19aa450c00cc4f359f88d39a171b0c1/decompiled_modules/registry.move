module 0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        supra_pair_ids: 0x2::table::Table<0x1::type_name::TypeName, u32>,
    }

    public fun get_pair_id<T0>(arg0: &Registry, arg1: &0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::Version) : u32 {
        0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::assert_current_version(arg1);
        *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            supra_pair_ids : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_price_pair_id<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u32, arg3: &0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::Version) {
        0xe0e26834b085f2e9bf1c71fd94329d33e19aa450c00cc4f359f88d39a171b0c1::version::assert_current_version(arg3);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg1.supra_pair_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg1.supra_pair_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg1.supra_pair_ids, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

