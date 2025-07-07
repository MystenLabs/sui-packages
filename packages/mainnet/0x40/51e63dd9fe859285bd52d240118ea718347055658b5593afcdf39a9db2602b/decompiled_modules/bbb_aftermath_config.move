module 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_config {
    struct AftermathConfig has key {
        id: 0x2::object::UID,
        swaps: vector<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>,
    }

    struct BBB_AFTERMATH_CONFIG has drop {
        dummy_field: bool,
    }

    public fun get<T0, T1>(arg0: &AftermathConfig) : 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0, v1);
            let v4 = 0x1::type_name::get<T0>();
            let v5 = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_in(v3) == &v4) {
                let v6 = 0x1::type_name::get<T1>();
                0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_out(v3) == &v6
            } else {
                false
            };
            if (v5) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                return *0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : AftermathConfig {
        AftermathConfig{
            id    : 0x2::object::new(arg0),
            swaps : 0x1::vector::empty<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(),
        }
    }

    public fun add(arg0: &mut AftermathConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap, arg2: 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0, v1);
            if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_in(v3) == 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_in(&arg2) && 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_out(v3) == 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_out(&arg2)) {
                v2 = true;
                /* label 10 */
                assert!(!v2, 1000);
                0x1::vector::push_back<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 10 */
    }

    public fun id(arg0: &AftermathConfig) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: BBB_AFTERMATH_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<AftermathConfig>(new(arg1));
    }

    public fun remove<T0, T1>(arg0: &mut AftermathConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(v0, v1);
            let v4 = 0x1::type_name::get<T0>();
            let v5 = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_in(v3) == &v4) {
                let v6 = 0x1::type_name::get<T1>();
                0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::type_out(v3) == &v6
            } else {
                false
            };
            if (v5) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                0x1::vector::swap_remove<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public fun remove_all(arg0: &mut AftermathConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(&arg0.swaps)) {
            0x1::vector::pop_back<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps);
            v0 = v0 + 1;
        };
    }

    public fun swaps(arg0: &AftermathConfig) : &vector<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_aftermath_swap::AftermathSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

