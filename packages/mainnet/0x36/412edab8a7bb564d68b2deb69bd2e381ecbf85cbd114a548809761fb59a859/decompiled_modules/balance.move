module 0x36412edab8a7bb564d68b2deb69bd2e381ecbf85cbd114a548809761fb59a859::balance {
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
        0x1::vector::push_back<u64>(v5, v1);
        0x1::vector::push_back<u64>(v5, v2);
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
        0x1::vector::push_back<u64>(v5, v1);
        0x1::vector::push_back<u64>(v5, v2);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let (v7, v8, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T2, T3>(arg1);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v7);
        0x1::vector::push_back<u64>(v11, v8);
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
        0x1::vector::push_back<u64>(v5, v1);
        0x1::vector::push_back<u64>(v5, v2);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let (v7, v8, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T2, T3>(arg1);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v7);
        0x1::vector::push_back<u64>(v11, v8);
        let v12 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg1),
            b  : v10,
        };
        0x1::vector::push_back<Balance>(&mut v0, v12);
        let (v13, v14, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T4, T5>(arg2);
        let v16 = 0x1::vector::empty<u64>();
        let v17 = &mut v16;
        0x1::vector::push_back<u64>(v17, v13);
        0x1::vector::push_back<u64>(v17, v14);
        let v18 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T4, T5>>(arg2),
            b  : v16,
        };
        0x1::vector::push_back<Balance>(&mut v0, v18);
        let (v19, v20, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T6, T7>(arg3);
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, v19);
        0x1::vector::push_back<u64>(v23, v20);
        let v24 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T6, T7>>(arg3),
            b  : v22,
        };
        0x1::vector::push_back<Balance>(&mut v0, v24);
        v0
    }

    public fun get_balances_8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>, arg2: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T4, T5>, arg3: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T6, T7>, arg4: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T8, T9>, arg5: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T10, T11>, arg6: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T12, T13>, arg7: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T14, T15>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let (v1, v2, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T0, T1>(arg0);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, v1);
        0x1::vector::push_back<u64>(v5, v2);
        let v6 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
            b  : v4,
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let (v7, v8, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T2, T3>(arg1);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v7);
        0x1::vector::push_back<u64>(v11, v8);
        let v12 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T3>>(arg1),
            b  : v10,
        };
        0x1::vector::push_back<Balance>(&mut v0, v12);
        let (v13, v14, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T4, T5>(arg2);
        let v16 = 0x1::vector::empty<u64>();
        let v17 = &mut v16;
        0x1::vector::push_back<u64>(v17, v13);
        0x1::vector::push_back<u64>(v17, v14);
        let v18 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T4, T5>>(arg2),
            b  : v16,
        };
        0x1::vector::push_back<Balance>(&mut v0, v18);
        let (v19, v20, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T6, T7>(arg3);
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, v19);
        0x1::vector::push_back<u64>(v23, v20);
        let v24 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T6, T7>>(arg3),
            b  : v22,
        };
        0x1::vector::push_back<Balance>(&mut v0, v24);
        let (v25, v26, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T8, T9>(arg4);
        let v28 = 0x1::vector::empty<u64>();
        let v29 = &mut v28;
        0x1::vector::push_back<u64>(v29, v25);
        0x1::vector::push_back<u64>(v29, v26);
        let v30 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T8, T9>>(arg4),
            b  : v28,
        };
        0x1::vector::push_back<Balance>(&mut v0, v30);
        let (v31, v32, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T10, T11>(arg5);
        let v34 = 0x1::vector::empty<u64>();
        let v35 = &mut v34;
        0x1::vector::push_back<u64>(v35, v31);
        0x1::vector::push_back<u64>(v35, v32);
        let v36 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T10, T11>>(arg5),
            b  : v34,
        };
        0x1::vector::push_back<Balance>(&mut v0, v36);
        let (v37, v38, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T12, T13>(arg6);
        let v40 = 0x1::vector::empty<u64>();
        let v41 = &mut v40;
        0x1::vector::push_back<u64>(v41, v37);
        0x1::vector::push_back<u64>(v41, v38);
        let v42 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T12, T13>>(arg6),
            b  : v40,
        };
        0x1::vector::push_back<Balance>(&mut v0, v42);
        let (v43, v44, _) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<T14, T15>(arg7);
        let v46 = 0x1::vector::empty<u64>();
        let v47 = &mut v46;
        0x1::vector::push_back<u64>(v47, v43);
        0x1::vector::push_back<u64>(v47, v44);
        let v48 = Balance{
            id : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T14, T15>>(arg7),
            b  : v46,
        };
        0x1::vector::push_back<Balance>(&mut v0, v48);
        v0
    }

    // decompiled from Move bytecode v6
}

