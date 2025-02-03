module 0x95a0a9c379fea6da48302196b7bcda169e9fa93eee7ac1a0c49835c7e51c4e68::query_bottle_list {
    struct BottleListInfo<phantom T0> has copy, drop {
        bottle_list: vector<BottleInfoWithID<T0>>,
        total_collateral_amount: u64,
        vault_collateral_amount: u64,
        total_debt_amount_with_interest: u64,
    }

    struct BottleInfoWithID<phantom T0> has copy, drop {
        bottle_address: address,
        collateral_amount: u64,
        debt_amount_with_interest: u64,
    }

    public fun query_bottle_list<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v0);
        let v2 = 0x1::vector::empty<BottleInfoWithID<T0>>();
        while (0x1::option::is_some<address>(&v1) && 0x1::vector::length<BottleInfoWithID<T0>>(&v2) < arg2) {
            let v3 = 0x1::option::destroy_some<address>(v1);
            let (v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v0, v3, arg1);
            let v6 = BottleInfoWithID<T0>{
                bottle_address            : v3,
                collateral_amount         : v4,
                debt_amount_with_interest : v5,
            };
            0x1::vector::push_back<BottleInfoWithID<T0>>(&mut v2, v6);
            v1 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(v0, v3);
        };
        let v7 = BottleListInfo<T0>{
            bottle_list                     : v2,
            total_collateral_amount         : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_total_collateral_balance<T0>(v0),
            vault_collateral_amount         : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_collateral_vault_balance<T0>(v0),
            total_debt_amount_with_interest : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_debt<T0>(v0, arg1),
        };
        0x2::event::emit<BottleListInfo<T0>>(v7);
    }

    // decompiled from Move bytecode v6
}

