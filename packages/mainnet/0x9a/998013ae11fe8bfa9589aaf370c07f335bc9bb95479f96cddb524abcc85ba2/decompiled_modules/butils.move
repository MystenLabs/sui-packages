module 0x9a998013ae11fe8bfa9589aaf370c07f335bc9bb95479f96cddb524abcc85ba2::butils {
    struct BottleData has copy, drop {
        debtor: address,
        coll_amount: u64,
        debt_amount: u64,
    }

    public fun get_bottles<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<BottleData>, 0x1::option::Option<address>) {
        let v0 = 0x1::vector::empty<BottleData>();
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        if (0x1::option::is_none<address>(&arg2)) {
            arg2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v1);
        };
        let v2 = 0;
        while (0x1::option::is_some<address>(&arg2) && v2 < arg3) {
            let v3 = *0x1::option::borrow<address>(&arg2);
            let (v4, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v1, v3, arg1);
            let v6 = BottleData{
                debtor      : v3,
                coll_amount : v4,
                debt_amount : v5,
            };
            0x1::vector::push_back<BottleData>(&mut v0, v6);
            v2 = v2 + 1;
            arg2 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(v1, v3);
        };
        (v0, arg2)
    }

    // decompiled from Move bytecode v6
}

