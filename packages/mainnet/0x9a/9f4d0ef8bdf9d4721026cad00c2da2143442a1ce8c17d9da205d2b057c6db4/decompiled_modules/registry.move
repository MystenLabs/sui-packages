module 0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: 0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::Version,
        oracle_set_price_cap: 0x1::option::Option<0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap>,
        price_info_ids: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        stale_price_secs: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &Registry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        assert!(&v0 == 0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_ids, 0x1::type_name::get<T0>()), 0);
    }

    public fun get_oracle_set_price_cap(arg0: &Registry) : &0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap {
        0x1::option::borrow<0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap>(&arg0.oracle_set_price_cap)
    }

    public fun get_pair_id<T0>(arg0: &Registry) : 0x2::object::ID {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::assert_current_version(&arg0.version);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_ids, 0x1::type_name::get<T0>())
    }

    public fun get_stale_price_secs<T0>(arg0: &Registry) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.stale_price_secs, 0x1::type_name::get<T0>())) {
            return 30
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.stale_price_secs, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                   : 0x2::object::new(arg0),
            version              : 0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::initialize(),
            oracle_set_price_cap : 0x1::option::none<0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap>(),
            price_info_ids       : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            stale_price_secs     : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_oracle_set_price_cap(arg0: &mut Registry, arg1: 0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap) {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::assert_current_version(&arg0.version);
        0x1::option::fill<0xd129487010865d68654b443b84b42f3a55bff9cbe86b4fc9e78b274fedc82345::registry::SetPriceCap>(&mut arg0.oracle_set_price_cap, arg1);
    }

    public fun set_price_pair_id<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.price_info_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_info_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_info_ids, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    public fun set_stale_price_secs<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::assert_current_version(&arg1.version);
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.stale_price_secs, 0x1::type_name::get<T0>())) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.stale_price_secs, 0x1::type_name::get<T0>());
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.stale_price_secs, 0x1::type_name::get<T0>(), arg2);
    }

    public fun upgrade_major(arg0: &AdminCap, arg1: &mut Registry) {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::upgrade_major(&mut arg1.version);
    }

    public fun upgrade_minor(arg0: &AdminCap, arg1: &mut Registry) {
        0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::upgrade_minor(&mut arg1.version);
    }

    public fun version(arg0: &Registry) : &0x9a9f4d0ef8bdf9d4721026cad00c2da2143442a1ce8c17d9da205d2b057c6db4::version::Version {
        &arg0.version
    }

    // decompiled from Move bytecode v6
}

