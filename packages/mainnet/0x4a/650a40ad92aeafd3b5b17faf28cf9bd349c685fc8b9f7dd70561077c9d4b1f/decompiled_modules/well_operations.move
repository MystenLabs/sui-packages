module 0x4a650a40ad92aeafd3b5b17faf28cf9bd349c685fc8b9f7dd70561077c9d4b1f::well_operations {
    public entry fun claim<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::claim<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun force_unstake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::force_unstake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        0x4a650a40ad92aeafd3b5b17faf28cf9bd349c685fc8b9f7dd70561077c9d4b1f::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v0, v2, arg4);
        0x4a650a40ad92aeafd3b5b17faf28cf9bd349c685fc8b9f7dd70561077c9d4b1f::utils::transfer_non_zero_balance<T0>(v1, v2, arg4);
    }

    public entry fun stake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::stake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(arg2), arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun unstake<T0>(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::StakedBKT<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::unstake<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg0), arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        0x4a650a40ad92aeafd3b5b17faf28cf9bd349c685fc8b9f7dd70561077c9d4b1f::utils::transfer_non_zero_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>(v0, v2, arg3);
        0x4a650a40ad92aeafd3b5b17faf28cf9bd349c685fc8b9f7dd70561077c9d4b1f::utils::transfer_non_zero_balance<T0>(v1, v2, arg3);
    }

    // decompiled from Move bytecode v6
}

