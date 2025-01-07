module 0x44560c0d7d2f29879d93e12c36901ca1d096836b1f2b8c26ac631d2af07ead3d::add_interest {
    struct NextCursor<phantom T0> has copy, drop {
        cursor: 0x1::option::Option<address>,
    }

    public fun front<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol) : 0x1::option::Option<address> {
        *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::front<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_table(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::borrow_bottle_table<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg0))))
    }

    public fun add_interest<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::add_pending_record_to_bucket<T0>(arg0, arg1, arg3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::add_interest_table_to_bucket<T0>(arg0, arg1, arg2, arg3);
    }

    public fun add_interest_and_init_bottles<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &0x2::clock::Clock, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        add_interest<T0>(arg0, arg1, arg2, arg4);
        init_bottles<T0>(arg0, arg1, 0x1::option::none<address>(), 500, arg4);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::set_interest_rate<T0>(arg0, arg1, arg3, arg2);
    }

    public fun init_bottles<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        if (0x1::option::is_none<address>(&arg2)) {
            arg2 = front<T0>(arg1);
        };
        while (v0 < arg3 && 0x1::option::is_some<address>(&arg2)) {
            let v1 = 0x1::option::destroy_some<address>(arg2);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::init_bottle_current_interest_index<T0>(arg0, arg1, v1, arg4);
            arg2 = *0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::next_debtor<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_bucket<T0>(arg1), v1);
            v0 = v0 + 1;
        };
        let v2 = NextCursor<T0>{cursor: arg2};
        0x2::event::emit<NextCursor<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

