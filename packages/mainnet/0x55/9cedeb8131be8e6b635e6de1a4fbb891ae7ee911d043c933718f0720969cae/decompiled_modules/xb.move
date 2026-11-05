module 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::xb {
    public fun op<T0, T1>(arg0: &0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock) : 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>> {
        let v0 = 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::sz(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>()
        };
        0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::op<T0, T1>(arg1, arg2, arg3, 0x1::option::destroy_some<u64>(v0), arg4))
    }

    public fun qs<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::live(arg0)) {
            return
        };
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::fd(arg0, 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::qo<T0, T1>(arg1, arg2, 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::cy(arg0)));
    }

    public fun ra<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(&arg2)) {
            0x1::option::destroy_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg2);
            return arg3
        };
        0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::ra<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg2), arg3)
    }

    public fun rb<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(&arg2)) {
            0x1::option::destroy_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg2);
            return arg3
        };
        0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::rb<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg2), arg3)
    }

    public fun sa<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::sa<T0, T1>(arg1, arg2, arg3, arg4);
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::sb<T0, T1>(arg1, arg2, arg3, arg4);
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun ta<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>) : (0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>, 0x2::balance::Balance<T0>) {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T0>())
        };
        let (v0, v1) = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::ta<T0, T1>(0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg1));
        let v2 = v1;
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T0>(arg0, &v2);
        (0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(v0), v2)
    }

    public fun tb<T0, T1>(arg0: &mut 0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::M, arg1: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>) : (0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>, 0x2::balance::Balance<T1>) {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T1>())
        };
        let (v0, v1) = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::tb<T0, T1>(0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(arg1));
        let v2 = v1;
        0x559cedeb8131be8e6b635e6de1a4fbb891ae7ee911d043c933718f0720969cae::m::hp<T1>(arg0, &v2);
        (0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vb::L<T0, T1>>(v0), v2)
    }

    // decompiled from Move bytecode v7
}

