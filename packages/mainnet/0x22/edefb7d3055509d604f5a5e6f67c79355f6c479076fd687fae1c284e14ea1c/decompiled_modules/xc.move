module 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::xc {
    public fun op<T0, T1>(arg0: &0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock) : 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>> {
        let v0 = 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::sz(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>()
        };
        0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::op<T0, T1>(arg1, arg2, arg3, 0x1::option::destroy_some<u64>(v0), arg4))
    }

    public fun qs<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::live(arg0)) {
            return
        };
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::fd(arg0, 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::qo<T0, T1>(arg1, arg2, 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::cy(arg0)));
    }

    public fun ra<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(&arg2)) {
            0x1::option::destroy_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg2);
            return arg3
        };
        0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::ra<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg2), arg3)
    }

    public fun rb<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(&arg2)) {
            0x1::option::destroy_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg2);
            return arg3
        };
        0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::rb<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg2), arg3)
    }

    public fun sa<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::sa<T0, T1>(arg1, arg2, arg3, arg4);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::sb<T0, T1>(arg1, arg2, arg3, arg4);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun ta<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>) : (0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>, 0x2::balance::Balance<T0>) {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T0>())
        };
        let (v0, v1) = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::ta<T0, T1>(0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg1));
        let v2 = v1;
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T0>(arg0, &v2);
        (0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(v0), v2)
    }

    public fun tb<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: 0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>) : (0x1::option::Option<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>, 0x2::balance::Balance<T1>) {
        if (0x1::option::is_none<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(&arg1)) {
            return (arg1, 0x2::balance::zero<T1>())
        };
        let (v0, v1) = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::tb<T0, T1>(0x1::option::destroy_some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(arg1));
        let v2 = v1;
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T1>(arg0, &v2);
        (0x1::option::some<0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vc::L<T0, T1>>(v0), v2)
    }

    // decompiled from Move bytecode v7
}

