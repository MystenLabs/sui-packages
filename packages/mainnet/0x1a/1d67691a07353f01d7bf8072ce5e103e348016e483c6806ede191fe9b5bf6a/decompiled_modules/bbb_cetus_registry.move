module 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_registry {
    struct CetusRegistry has key {
        id: 0x2::object::UID,
        swaps: vector<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>,
    }

    struct BBB_CETUS_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get<T0, T1>(arg0: &CetusRegistry) : 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2)) {
            let (v5, v6) = 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::input_output_types(0x1::vector::borrow<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2, v3));
            if (&v0 == v5 && &v1 == v6) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v4), 1001);
                return *0x1::vector::borrow<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v4))
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : CetusRegistry {
        CetusRegistry{
            id    : 0x2::object::new(arg0),
            swaps : 0x1::vector::empty<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(),
        }
    }

    public fun add(arg0: &mut CetusRegistry, arg1: &0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_admin::BBBAdminCap, arg2: 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap) {
        let (v0, v1) = 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::input_output_types(&arg2);
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2)) {
            let (v5, v6) = 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::input_output_types(0x1::vector::borrow<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2, v3));
            if (v0 == v5 && v1 == v6) {
                v4 = true;
                /* label 10 */
                assert!(!v4, 1000);
                0x1::vector::push_back<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, arg2);
                return
            };
            v3 = v3 + 1;
        };
        v4 = false;
        /* goto 10 */
    }

    public fun id(arg0: &CetusRegistry) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: BBB_CETUS_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<CetusRegistry>(new(arg1));
    }

    public fun remove<T0, T1>(arg0: &mut CetusRegistry, arg1: &0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_admin::BBBAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2)) {
            let (v5, v6) = 0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::input_output_types(0x1::vector::borrow<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(v2, v3));
            if (&v0 == v5 && &v1 == v6) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v4), 1001);
                0x1::vector::swap_remove<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v4));
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public fun remove_all(arg0: &mut CetusRegistry, arg1: &0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_admin::BBBAdminCap) {
        arg0.swaps = 0x1::vector::empty<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap>();
    }

    public fun swaps(arg0: &CetusRegistry) : &vector<0x1a1d67691a07353f01d7bf8072ce5e103e348016e483c6806ede191fe9b5bf6a::bbb_cetus_swap::CetusSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

