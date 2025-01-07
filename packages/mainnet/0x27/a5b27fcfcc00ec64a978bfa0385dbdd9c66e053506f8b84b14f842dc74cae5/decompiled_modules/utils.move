module 0xb3f10f2c9a52b615ab8b0b930ee55e019bacb407b29f5f534e6d9c3291341db8::utils {
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

    public fun get_bottles_by_step<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) : (vector<BottleData>, 0x1::option::Option<address>) {
        let v0 = 0x1::vector::empty<BottleData>();
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0);
        if (0x1::option::is_none<address>(&arg2)) {
            arg2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_lowest_cr_debtor<T0>(v1);
        };
        let v2 = 0;
        let v3 = 0;
        while (0x1::option::is_some<address>(&arg2) && v2 < arg4) {
            let v4 = *0x1::option::borrow<address>(&arg2);
            arg2 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(v1, v4);
            if (v3 == arg3) {
                let (v5, v6) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_with_interest_by_debtor<T0>(v1, v4, arg1);
                let v7 = BottleData{
                    debtor      : v4,
                    coll_amount : v5,
                    debt_amount : v6,
                };
                0x1::vector::push_back<BottleData>(&mut v0, v7);
                v3 = 0;
            };
            v2 = v2 + 1;
            v3 = v3 + 1;
        };
        (v0, arg2)
    }

    public fun transfer_non_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun transfer_non_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

