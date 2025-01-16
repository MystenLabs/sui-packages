module 0x4f049e993a309ad93e66b6eda6a33c2d11d59c33f683454d218d9cd45fa35d3d::balance {
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

    public fun get_balances_1<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let v1 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0),
        };
        0x1::vector::push_back<Balance>(&mut v0, v1);
        v0
    }

    public fun get_balances_2<T0, T1>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let v1 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0),
        };
        0x1::vector::push_back<Balance>(&mut v0, v1);
        let v2 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>>(arg1),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T1>(arg1),
        };
        0x1::vector::push_back<Balance>(&mut v0, v2);
        v0
    }

    public fun get_balances_4<T0, T1, T2, T3>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let v1 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0),
        };
        0x1::vector::push_back<Balance>(&mut v0, v1);
        let v2 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>>(arg1),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T1>(arg1),
        };
        0x1::vector::push_back<Balance>(&mut v0, v2);
        let v3 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg2),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T2>(arg2),
        };
        0x1::vector::push_back<Balance>(&mut v0, v3);
        let v4 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>>(arg3),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T3>(arg3),
        };
        0x1::vector::push_back<Balance>(&mut v0, v4);
        v0
    }

    public fun get_balances_8<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>, arg4: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>, arg5: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T5>, arg6: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T6>, arg7: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T7>) : vector<Balance> {
        let v0 = 0x1::vector::empty<Balance>();
        let v1 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T0>(arg0),
        };
        0x1::vector::push_back<Balance>(&mut v0, v1);
        let v2 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T1>>(arg1),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T1>(arg1),
        };
        0x1::vector::push_back<Balance>(&mut v0, v2);
        let v3 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T2>>(arg2),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T2>(arg2),
        };
        0x1::vector::push_back<Balance>(&mut v0, v3);
        let v4 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T3>>(arg3),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T3>(arg3),
        };
        0x1::vector::push_back<Balance>(&mut v0, v4);
        let v5 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T4>>(arg4),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T4>(arg4),
        };
        0x1::vector::push_back<Balance>(&mut v0, v5);
        let v6 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T5>>(arg5),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T5>(arg5),
        };
        0x1::vector::push_back<Balance>(&mut v0, v6);
        let v7 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T6>>(arg6),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T6>(arg6),
        };
        0x1::vector::push_back<Balance>(&mut v0, v7);
        let v8 = Balance{
            id : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T7>>(arg7),
            b  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balances<T7>(arg7),
        };
        0x1::vector::push_back<Balance>(&mut v0, v8);
        v0
    }

    // decompiled from Move bytecode v6
}

