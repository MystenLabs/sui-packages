module 0xf2cba52933ccfa5eba0fbf9167a8c30a4c705a9e72c8d5aeb4b0963af4d6c707::strap {
    public entry fun borrow<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_with_strap<T0>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), arg5, 0x1::option::some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(arg2)), arg6), arg6), 0x2::tx_context::sender(arg6));
    }

    fun find_insertion_place<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x1::option::Option<address>) : 0x1::option::Option<address> {
        if (0x1::option::is_some<address>(&arg1)) {
            let v1 = 0x1::option::destroy_some<address>(arg1);
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
            if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::bottle_exists<T0>(v2, v1)) {
                *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_table(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::borrow_bottle_table<T0>(v2)), v1)
            } else {
                arg1
            }
        } else {
            arg1
        }
    }

    public fun fully_repay_with_strap<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg2: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<T0>) {
        let (_, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(&arg1), arg3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::destroy_empty_strap<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0), arg1);
        (arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_with_strap<T0>(arg0, &arg1, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg2, v1), arg3))
    }

    public entry fun new_strap<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::new<T0>(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun repay_and_withdraw<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: u64) : (0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>();
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(arg2);
        let (_, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<T0>(arg0, v1, arg3);
        let v4 = if (0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg4) > v3) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v0, arg4);
            0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg4, v3)
        } else {
            arg4
        };
        let v5 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay_with_strap<T0>(arg0, arg2, v4, arg3);
        let v6 = 0x2::balance::value<T0>(&v5);
        if (arg5 > v6) {
            0x2::balance::join<T0>(&mut v5, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw_with_strap<T0>(arg0, arg1, arg2, arg3, arg5 - v6, find_insertion_place<T0>(arg0, 0x1::option::some<address>(v1))));
        } else if (arg5 < v6) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up_coll<T0>(arg0, 0x2::balance::split<T0>(&mut v5, v6 - arg5), v1, find_insertion_place<T0>(arg0, 0x1::option::some<address>(v1)), arg3);
        };
        (v0, v5)
    }

    // decompiled from Move bytecode v6
}

