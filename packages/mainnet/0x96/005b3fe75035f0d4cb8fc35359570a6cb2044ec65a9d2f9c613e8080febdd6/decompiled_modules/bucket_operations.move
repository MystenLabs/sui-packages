module 0xb71fc42c6b024290999aa4737fc51485557ee9089ce6151bc4384edb72869426::bucket_operations {
    public entry fun borrow<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0xb71fc42c6b024290999aa4737fc51485557ee9089ce6151bc4384edb72869426::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), arg4, find_insertion_place<T0>(arg0, arg5), arg6), 0x2::tx_context::sender(arg6), arg6);
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

    public entry fun redeem<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb71fc42c6b024290999aa4737fc51485557ee9089ce6151bc4384edb72869426::utils::transfer_non_zero_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::redeem<T0>(arg0, arg1, arg2, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3), arg4), 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun repay<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb71fc42c6b024290999aa4737fc51485557ee9089ce6151bc4384edb72869426::utils::transfer_non_zero_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1), arg2), 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun repay_and_withdraw<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::repay<T0>(arg0, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3), arg6);
        let v2 = 0x2::balance::value<T0>(&v1);
        if (arg4 > v2) {
            0x2::balance::join<T0>(&mut v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::withdraw<T0>(arg0, arg1, arg2, arg4 - v2, find_insertion_place<T0>(arg0, arg5), arg6));
        } else if (arg4 < v2) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up<T0>(arg0, 0x2::balance::split<T0>(&mut v1, v2 - arg4), v0, find_insertion_place<T0>(arg0, arg5));
        };
        0xb71fc42c6b024290999aa4737fc51485557ee9089ce6151bc4384edb72869426::utils::transfer_non_zero_balance<T0>(v1, v0, arg6);
    }

    public entry fun top_up<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::top_up<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, find_insertion_place<T0>(arg0, arg3));
    }

    // decompiled from Move bytecode v6
}

