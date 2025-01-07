module 0xe148b7b92ea0ec6afe6e65f7ad94e01b59eb8f829b088c1ee5728bb4209367b::query {
    struct BucketInfo<phantom T0> {
        total_collateral_amount: u64,
        total_debt_amount: u64,
    }

    public fun query<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock) : BucketInfo<T0> {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        BucketInfo<T0>{
            total_collateral_amount : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_total_collateral_balance<T0>(v0),
            total_debt_amount       : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_debt<T0>(v0, arg1),
        }
    }

    // decompiled from Move bytecode v6
}

