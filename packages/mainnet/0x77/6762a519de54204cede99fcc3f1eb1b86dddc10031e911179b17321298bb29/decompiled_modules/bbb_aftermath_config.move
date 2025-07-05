module 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_config {
    struct AftermathConfig has store, key {
        id: 0x2::object::UID,
        swaps: vector<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>,
    }

    public fun get<T0>(arg0: &AftermathConfig) : 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.swaps;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v1)) {
            if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v1, v2)) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 1001);
                return *0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(&arg0.swaps, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun new(arg0: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap, arg1: &mut 0x2::tx_context::TxContext) : AftermathConfig {
        AftermathConfig{
            id    : 0x2::object::new(arg1),
            swaps : 0x1::vector::empty<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(),
        }
    }

    public fun add(arg0: &mut AftermathConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap, arg2: 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v0)) {
            if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v0, v1)) == 0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::type_in(&arg2)) {
                v2 = true;
                /* label 6 */
                assert!(!v2, 1000);
                0x1::vector::push_back<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun destroy(arg0: AftermathConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let AftermathConfig {
            id    : v0,
            swaps : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &AftermathConfig) : &0x2::object::UID {
        &arg0.id
    }

    public fun remove<T0>(arg0: &mut AftermathConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::type_name::get<T0>();
            if (0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(v0, v1)) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                0x1::vector::swap_remove<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun remove_all(arg0: &mut AftermathConfig, arg1: &0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(&arg0.swaps)) {
            0x1::vector::pop_back<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap>(&mut arg0.swaps);
            v0 = v0 + 1;
        };
    }

    public fun swaps(arg0: &AftermathConfig) : &vector<0x776762a519de54204cede99fcc3f1eb1b86dddc10031e911179b17321298bb29::bbb_aftermath_swap::AftermathSwap> {
        &arg0.swaps
    }

    // decompiled from Move bytecode v6
}

