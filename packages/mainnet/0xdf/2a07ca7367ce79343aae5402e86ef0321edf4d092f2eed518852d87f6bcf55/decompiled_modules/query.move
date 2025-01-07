module 0xdf2a07ca7367ce79343aae5402e86ef0321edf4d092f2eed518852d87f6bcf55::query {
    struct BottleInfo<phantom T0> has copy, drop {
        collateral_amount: u64,
        debt_amount_with_interest: u64,
    }

    struct BucketInfo<phantom T0> has copy, drop {
        head: BottleInfo<T0>,
        total_collateral_amount: u64,
        total_debt_amount: u64,
    }

    public fun query<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        let (v1, v2) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v0, 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v0)), arg1);
        let v3 = BottleInfo<T0>{
            collateral_amount         : v1,
            debt_amount_with_interest : v2,
        };
        let v4 = BucketInfo<T0>{
            head                    : v3,
            total_collateral_amount : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_total_collateral_balance<T0>(v0),
            total_debt_amount       : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_debt<T0>(v0, arg1),
        };
        0x2::event::emit<BucketInfo<T0>>(v4);
    }

    // decompiled from Move bytecode v6
}

