module 0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_revenue_pool {
    struct RevenueData has store, key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    struct ReferralRevenuePool has key {
        id: 0x2::object::UID,
        revenue: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::BalanceBag,
        ve_sca_revenue_data: 0x2::table::Table<0x2::object::ID, RevenueData>,
    }

    public(friend) fun add_revenue_to_ve_sca_referrer<T0>(arg0: &mut ReferralRevenuePool, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, RevenueData>(&arg0.ve_sca_revenue_data, arg1)) {
            let v0 = RevenueData{
                id  : 0x2::object::new(arg3),
                bag : 0x2::bag::new(arg3),
            };
            0x2::table::add<0x2::object::ID, RevenueData>(&mut arg0.ve_sca_revenue_data, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, RevenueData>(&mut arg0.ve_sca_revenue_data, arg1);
        increase_revenue_data(v1, 0x1::type_name::get<T0>(), 0x2::balance::value<T0>(&arg2));
        if (!0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::contains<T0>(&arg0.revenue)) {
            0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::init_balance<T0>(&mut arg0.revenue);
        };
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::join<T0>(&mut arg0.revenue, arg2);
    }

    public fun claim_revenue_with_ve_sca_key<T0>(arg0: &mut ReferralRevenuePool, arg1: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaKey, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaKey>(arg1);
        if (!0x2::table::contains<0x2::object::ID, RevenueData>(&arg0.ve_sca_revenue_data, v0)) {
            0x2::coin::zero<T0>(arg2)
        } else {
            let v2 = 0x1::type_name::get<T0>();
            let v3 = 0x2::table::borrow_mut<0x2::object::ID, RevenueData>(&mut arg0.ve_sca_revenue_data, v0);
            let v4 = revenue_amount(v3, v2);
            decrease_revenue_data(v3, v2, v4);
            0x2::coin::from_balance<T0>(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::split<T0>(&mut arg0.revenue, v4), arg2)
        }
    }

    fun decrease_revenue_data(arg0: &mut RevenueData, arg1: 0x1::type_name::TypeName, arg2: u64) {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, arg1), 0);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.bag, arg1);
        *v0 = *v0 - arg2;
    }

    fun increase_revenue_data(arg0: &mut RevenueData, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, arg1)) {
            let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.bag, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::bag::add<0x1::type_name::TypeName, u64>(&mut arg0.bag, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRevenuePool{
            id                  : 0x2::object::new(arg0),
            revenue             : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::balance_bag::new(arg0),
            ve_sca_revenue_data : 0x2::table::new<0x2::object::ID, RevenueData>(arg0),
        };
        0x2::transfer::share_object<ReferralRevenuePool>(v0);
    }

    fun revenue_amount(arg0: &RevenueData, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, arg1)) {
            *0x2::bag::borrow<0x1::type_name::TypeName, u64>(&arg0.bag, arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

