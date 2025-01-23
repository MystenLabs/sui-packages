module 0xed27b7f3a62826b5728a54e4256d5995aa14fda9a12c38fdcafbb7d004fa3ea5::balance {
    struct Balance has copy, drop {
        id: 0x2::object::ID,
        b: vector<u64>,
    }

    struct Balances has copy, drop {
        data: vector<Balance>,
    }

    public fun emit_balances(arg0: vector<Balance>) {
        let v0 = Balances{data: arg0};
        0x2::event::emit<Balances>(v0);
    }

    public fun get_balances_1<T0, T1>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let (v1, v2, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, v1);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        v0
    }

    public fun get_balances_2<T0, T1, T2, T3>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let (v1, v2, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, v1);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let (v7, v8, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T2, T3>(arg1);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v8);
        0x1::vector::push_back<u64>(v11, v7);
        let v12 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg1),
            b  : v10,
        };
        0x1::vector::push_back<Balance>(&mut v0, v12);
        v0
    }

    public fun get_balances_4<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg2: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T4, T5>, arg3: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T6, T7>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let (v1, v2, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, v1);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let (v7, v8, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T2, T3>(arg1);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v8);
        0x1::vector::push_back<u64>(v11, v7);
        let v12 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg1),
            b  : v10,
        };
        0x1::vector::push_back<Balance>(&mut v0, v12);
        let (v13, v14, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T4, T5>(arg2);
        let v16 = 0x1::vector::empty<u64>();
        let v17 = &mut v16;
        0x1::vector::push_back<u64>(v17, v14);
        0x1::vector::push_back<u64>(v17, v13);
        let v18 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T4, T5>>(arg2),
            b  : v16,
        };
        0x1::vector::push_back<Balance>(&mut v0, v18);
        let (v19, v20, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T6, T7>(arg3);
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, v20);
        0x1::vector::push_back<u64>(v23, v19);
        let v24 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T6, T7>>(arg3),
            b  : v22,
        };
        0x1::vector::push_back<Balance>(&mut v0, v24);
        v0
    }

    // decompiled from Move bytecode v6
}

