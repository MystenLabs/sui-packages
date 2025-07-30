module 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_registry {
    struct AftermathRegistry has key {
        id: 0x2::object::UID,
        swaps: vector<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>,
    }

    struct BBB_AFTERMATH_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get<T0, T1>(arg0: &AftermathRegistry) : 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwapPromise {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v2)) {
            let v5 = 0x1::vector::borrow<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v2, v3);
            if (0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_in(v5) == &v0 && 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_out(v5) == &v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v4), 1001);
                return 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::new_promise(*0x1::vector::borrow<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v4)))
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : AftermathRegistry {
        AftermathRegistry{
            id    : 0x2::object::new(arg0),
            swaps : 0x1::vector::empty<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(),
        }
    }

    public fun add(arg0: &mut AftermathRegistry, arg1: &0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_admin::BBBAdminCap, arg2: 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::vector::borrow<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v0, v1);
            if (0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_in(v3) == 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_in(&arg2) && 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_out(v3) == 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_out(&arg2)) {
                v2 = true;
                /* label 10 */
                assert!(!v2, 1000);
                0x1::vector::push_back<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 10 */
    }

    public fun id(arg0: &AftermathRegistry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: BBB_AFTERMATH_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<AftermathRegistry>(new(arg1));
    }

    public fun remove<T0, T1>(arg0: &mut AftermathRegistry, arg1: &0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_admin::BBBAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = &arg0.swaps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v2)) {
            let v5 = 0x1::vector::borrow<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(v2, v3);
            if (0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_in(v5) == &v0 && 0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::type_out(v5) == &v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 10 */
                assert!(0x1::option::is_some<u64>(&v4), 1001);
                0x1::vector::swap_remove<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v4));
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public fun remove_all(arg0: &mut AftermathRegistry, arg1: &0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_admin::BBBAdminCap) {
        arg0.swaps = 0x1::vector::empty<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap>();
    }

    public fun swaps(arg0: &AftermathRegistry) : &vector<0x93ecc5b0647d488da8b9479ca40ac017cc26cb4598aab628519fc76ccb423a32::bbb_aftermath_swap::AftermathSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

