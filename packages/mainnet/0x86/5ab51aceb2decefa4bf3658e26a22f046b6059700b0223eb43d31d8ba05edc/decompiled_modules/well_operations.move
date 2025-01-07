module 0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::well_operations {
    public entry fun claim<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::claim<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit_fee<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: 0x2::coin::Coin<T0>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun force_unstake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::force_unstake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v0, v2, arg4);
        0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::utils::transfer_non_zero_balance<T0>(v1, v2, arg4);
    }

    public entry fun stake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::stake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::unstake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v0, v2, arg3);
        0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::utils::transfer_non_zero_balance<T0>(v1, v2, arg3);
    }

    public fun withdraw_reserve<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktAdminCap, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::withdraw_reserve<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg1)), arg2)
    }

    public fun withdraw_reserve_to<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktAdminCap, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_reserve<T0>(arg0, arg1, arg3);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg2);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

