module 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_config {
    struct CetusConfig has key {
        id: 0x2::object::UID,
        swaps: vector<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>,
    }

    struct BBB_CETUS_CONFIG has drop {
        dummy_field: bool,
    }

    public fun get<T0, T1>(arg0: &CetusConfig) : 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v0, v1);
            let (v4, v5) = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::a2b(v3)) {
                let v5 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v3);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v3), v5)
            } else {
                let v5 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v3);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v3), v5)
            };
            let v6 = 0x1::type_name::get<T0>();
            let v7 = if (&v6 == v4) {
                let v8 = 0x1::type_name::get<T1>();
                &v8 == v5
            } else {
                false
            };
            if (v7) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 13 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                return *0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 13 */
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : CetusConfig {
        CetusConfig{
            id    : 0x2::object::new(arg0),
            swaps : 0x1::vector::empty<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(),
        }
    }

    public fun add(arg0: &mut CetusConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap, arg2: 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap) {
        let (v0, v1) = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::a2b(&arg2)) {
            let v1 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(&arg2);
            let v0 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(&arg2);
            (v0, v1)
        } else {
            let v1 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(&arg2);
            let v0 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(&arg2);
            (v0, v1)
        };
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v2)) {
            let v5 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v2, v3);
            let (v6, v7) = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::a2b(v5)) {
                let v7 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v5);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v5), v7)
            } else {
                let v7 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v5);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v5), v7)
            };
            if (v0 == v6 && v1 == v7) {
                v4 = true;
                /* label 18 */
                assert!(!v4, 1000);
                0x1::vector::push_back<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, arg2);
                return
            };
            v3 = v3 + 1;
        };
        v4 = false;
        /* goto 18 */
    }

    public fun id(arg0: &CetusConfig) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: BBB_CETUS_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CetusConfig>(new(arg1));
    }

    public fun remove<T0, T1>(arg0: &mut CetusConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(v0, v1);
            let (v4, v5) = if (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::a2b(v3)) {
                let v5 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v3);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v3), v5)
            } else {
                let v5 = 0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_a(v3);
                (0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::type_b(v3), v5)
            };
            let v6 = 0x1::type_name::get<T0>();
            let v7 = if (&v6 == v4) {
                let v8 = 0x1::type_name::get<T1>();
                &v8 == v5
            } else {
                false
            };
            if (v7) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 13 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                0x1::vector::swap_remove<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 13 */
    }

    public fun remove_all(arg0: &mut CetusConfig, arg1: &0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(&arg0.swaps)) {
            0x1::vector::pop_back<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps);
            v0 = v0 + 1;
        };
    }

    public fun swaps(arg0: &CetusConfig) : &vector<0x4051e63dd9fe859285bd52d240118ea718347055658b5593afcdf39a9db2602b::bbb_cetus_swap::CetusSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

