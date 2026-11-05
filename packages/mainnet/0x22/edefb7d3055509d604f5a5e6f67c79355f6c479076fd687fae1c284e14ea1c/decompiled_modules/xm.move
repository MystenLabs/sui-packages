module 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::xm {
    public fun op<T0, T1>(arg0: &0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>> {
        let v0 = 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::sz(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>()
        };
        0x1::option::some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::op<T0, T1>(arg1, arg2, arg3, 0x1::option::destroy_some<u64>(v0), arg4, arg5))
    }

    public fun ra<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext, arg3: 0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>, arg4: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        if (0x1::option::is_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(&arg3)) {
            0x1::option::destroy_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg3);
            return arg4
        };
        0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::ra<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg3), arg4, arg2)
    }

    public fun rb<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext, arg3: 0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>, arg4: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        if (0x1::option::is_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(&arg3)) {
            0x1::option::destroy_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg3);
            return arg4
        };
        0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::rb<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg3), arg4, arg2)
    }

    public fun sa<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::sa<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::sb<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun ta<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: 0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>) : (0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>, 0x2::balance::Balance<T0>) {
        if (0x1::option::is_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T0>())
        };
        let (v0, v1) = 0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::ta<T0, T1>(0x1::option::destroy_some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg1));
        let v2 = v1;
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T0>(arg0, &v2);
        (0x1::option::some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(v0), v2)
    }

    public fun tb<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: 0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>) : (0x1::option::Option<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>, 0x2::balance::Balance<T1>) {
        if (0x1::option::is_none<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T1>())
        };
        let (v0, v1) = 0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::tb<T0, T1>(0x1::option::destroy_some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(arg1));
        let v2 = v1;
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T1>(arg0, &v2);
        (0x1::option::some<0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::L<T0, T1>>(v0), v2)
    }

    public fun qs<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::live(arg0)) {
            return
        };
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::fd(arg0, 0x1ea5978684431a73b65aa5c18dc82d1d60f2440a107144ab8226f77e1e13ad8d::vm::qo<T0, T1>(arg1, arg2, 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::cy(arg0)));
    }

    // decompiled from Move bytecode v7
}

