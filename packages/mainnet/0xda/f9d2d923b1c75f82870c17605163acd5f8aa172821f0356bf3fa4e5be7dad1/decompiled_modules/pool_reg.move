module 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool_reg {
    struct PoolCap has key {
        id: 0x2::object::UID,
    }

    struct PoolReg has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    public entry fun update_fee<T0, T1>(arg0: &PoolCap, arg1: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: u8) {
        assert_fee(0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::stable<T0, T1>(arg1), arg2);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::update_fee<T0, T1>(arg1, arg2);
    }

    public entry fun update_stable<T0, T1>(arg0: &PoolCap, arg1: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: bool) {
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::update_stable<T0, T1>(arg1, arg2);
    }

    fun assert_fee(arg0: bool, arg1: u8) {
        if (arg0) {
            assert!(arg1 >= 1 && arg1 <= 5, 0);
        } else {
            assert!(arg1 >= 10 && arg1 <= 50, 0);
        };
    }

    public entry fun create_pool<T0, T1>(arg0: &mut PoolReg, arg1: &PoolCap, arg2: bool, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert_fee(arg2, arg5);
        let v0 = 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::new<T0, T1>(get_pool_name<T0, T1>(arg3, arg4), arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::bcs::to_bytes<0x1::ascii::String>(0x1::type_name::borrow_string(&v1));
        let v3 = 0x1::type_name::get<T1>();
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x1::ascii::String>(0x1::type_name::borrow_string(&v3)));
        let v4 = v2;
        v2 = 0x1::hash::sha2_256(v4);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.pools, v2, v0);
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::event::pool_created<T0, T1>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun get_pool_name<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>) : 0x1::string::String {
        let v0 = 0x2::coin::get_symbol<T0>(arg0);
        let v1 = 0x2::coin::get_symbol<T1>(arg1);
        assert!(v0 != v1, 0);
        let v2 = 0x1::ascii::as_bytes(&v0);
        let v3 = 0x1::ascii::as_bytes(&v1);
        assert!(0x1::vector::length<u8>(v2) <= 0x1::vector::length<u8>(v3), 0);
        if (0x1::vector::length<u8>(v2) == 0x1::vector::length<u8>(v3)) {
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(v2)) {
                let v5 = *0x1::vector::borrow<u8>(v2, v4);
                let v6 = *0x1::vector::borrow<u8>(v3, v4);
                assert!(v5 <= v6, 0);
                if (v5 < v6) {
                    break
                };
                v4 = v4 + 1;
            };
        };
        let v7 = 0x1::string::from_ascii(v0);
        0x1::string::append(&mut v7, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v7, 0x1::string::from_ascii(v1));
        v7
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolReg{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PoolReg>(v0);
        let v1 = PoolCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pools_length(arg0: &PoolReg) : u64 {
        0x2::table::length<vector<u8>, 0x2::object::ID>(&arg0.pools)
    }

    entry fun update_pool<T0, T1>(arg0: &PoolCap, arg1: &mut 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::Pool<T0, T1>, arg2: bool) {
        0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::pool::udpate_lock<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

