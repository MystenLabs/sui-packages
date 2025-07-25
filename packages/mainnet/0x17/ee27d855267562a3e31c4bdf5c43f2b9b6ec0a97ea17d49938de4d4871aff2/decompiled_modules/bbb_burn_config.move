module 0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn_config {
    struct BurnConfig has key {
        id: 0x2::object::UID,
        burns: vector<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>,
    }

    public fun get<T0>(arg0: &BurnConfig) : 0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.burns;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v1)) {
            if (0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::coin_type(0x1::vector::borrow<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v1, v2)) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 1001);
                return *0x1::vector::borrow<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(&arg0.burns, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun new(arg0: &0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_admin::BBBAdminCap, arg1: &mut 0x2::tx_context::TxContext) : BurnConfig {
        BurnConfig{
            id    : 0x2::object::new(arg1),
            burns : 0x1::vector::empty<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(),
        }
    }

    public fun add(arg0: &mut BurnConfig, arg1: &0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_admin::BBBAdminCap, arg2: 0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v0)) {
            if (0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::coin_type(0x1::vector::borrow<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v0, v1)) == 0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::coin_type(&arg2)) {
                v2 = true;
                /* label 6 */
                assert!(!v2, 1000);
                0x1::vector::push_back<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(&mut arg0.burns, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun burns(arg0: &BurnConfig) : &vector<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn> {
        &arg0.burns
    }

    public fun destroy(arg0: BurnConfig, arg1: &0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_admin::BBBAdminCap) {
        let BurnConfig {
            id    : v0,
            burns : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &BurnConfig) : &0x2::object::UID {
        &arg0.id
    }

    public fun remove<T0>(arg0: &mut BurnConfig, arg1: &0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v0)) {
            let v3 = 0x1::type_name::get<T0>();
            if (0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::coin_type(0x1::vector::borrow<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(v0, v1)) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 1001);
                0x1::vector::swap_remove<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(&mut arg0.burns, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun remove_all(arg0: &mut BurnConfig, arg1: &0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_admin::BBBAdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(&arg0.burns)) {
            0x1::vector::pop_back<0x17ee27d855267562a3e31c4bdf5c43f2b9b6ec0a97ea17d49938de4d4871aff2::bbb_burn::Burn>(&mut arg0.burns);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

