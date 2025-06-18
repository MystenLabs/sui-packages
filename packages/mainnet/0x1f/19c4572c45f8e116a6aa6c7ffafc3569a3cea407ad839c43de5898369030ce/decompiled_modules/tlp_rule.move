module 0x1f19c4572c45f8e116a6aa6c7ffafc3569a3cea407ad839c43de5898369030ce::tlp_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct IndexMap has key {
        id: 0x2::object::UID,
        inner: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    fun err_unsupported_tlp_type() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IndexMap{
            id    : 0x2::object::new(arg0),
            inner : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::transfer::share_object<IndexMap>(v0);
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_index<T0>(arg0: &mut IndexMap, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.inner, &v0);
    }

    public fun set_index<T0>(arg0: &mut IndexMap, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.inner, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.inner, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.inner, v0, arg2);
        };
    }

    public fun update_price<T0>(arg0: &IndexMap, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg4: &0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.inner, &v0)) {
            err_unsupported_tlp_type();
        };
        let (v1, v2, _, _, _) = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::get_pool_liquidity(arg3, arg4, *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.inner, &v0));
        let v6 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg1);
        let v7 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(v6, v7, arg2, mul_and_div(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(v6), v2, v1));
    }

    // decompiled from Move bytecode v6
}

