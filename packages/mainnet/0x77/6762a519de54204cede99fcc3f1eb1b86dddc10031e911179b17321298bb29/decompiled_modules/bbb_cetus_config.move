module 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_config {
    struct CetusConfig has store, key {
        id: 0x2::object::UID,
        swaps: vector<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>,
    }

    public fun get<T0>(arg0: &CetusConfig) : 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.swaps;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1)) {
            let v4 = 0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1, v2);
            let v5 = if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::a2b(v4)) {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_a(v4)
            } else {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_b(v4)
            };
            if (&v0 == v5) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 9 */
                assert!(0x1::option::is_some<u64>(&v3), 1001);
                return *0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun new(arg0: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap, arg1: &mut 0x2::tx_context::TxContext) : CetusConfig {
        CetusConfig{
            id    : 0x2::object::new(arg1),
            swaps : 0x1::vector::empty<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(),
        }
    }

    public fun add(arg0: &mut CetusConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap, arg2: 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap) {
        let v0 = if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::a2b(&arg2)) {
            0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_a(&arg2)
        } else {
            0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_b(&arg2)
        };
        let v1 = &arg0.swaps;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1)) {
            let v4 = 0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1, v2);
            let v5 = if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::a2b(v4)) {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_a(v4)
            } else {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_b(v4)
            };
            if (v0 == v5) {
                v3 = true;
                /* label 14 */
                assert!(!v3, 1000);
                0x1::vector::push_back<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, arg2);
                return
            };
            v2 = v2 + 1;
        };
        v3 = false;
        /* goto 14 */
    }

    public fun destroy(arg0: CetusConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let CetusConfig {
            id    : v0,
            swaps : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &CetusConfig) : &0x2::object::UID {
        &arg0.id
    }

    public fun remove<T0>(arg0: &mut CetusConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.swaps;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1)) {
            let v4 = 0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(v1, v2);
            let v5 = if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::a2b(v4)) {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_a(v4)
            } else {
                0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::type_b(v4)
            };
            if (&v0 == v5) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 9 */
                assert!(0x1::option::is_some<u64>(&v3), 1001);
                0x1::vector::swap_remove<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v3));
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun remove_all(arg0: &mut CetusConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(&arg0.swaps)) {
            0x1::vector::pop_back<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap>(&mut arg0.swaps);
            v0 = v0 + 1;
        };
    }

    public fun swaps(arg0: &CetusConfig) : &vector<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_cetus_swap::CetusSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

