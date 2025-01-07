module 0x9860c139fcb3e467332e3d0296258441efa10e7c07857a2d24589de082bafb0b::query {
    struct BucketInfo<phantom T0> has copy, drop {
        total_collateral_amount: u64,
        total_debt_amount: u64,
    }

    public fun query<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let v1 = BucketInfo<T0>{
            total_collateral_amount : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_total_collateral_balance<T0>(v0),
            total_debt_amount       : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_debt<T0>(v0, arg1),
        };
        0x2::event::emit<BucketInfo<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

