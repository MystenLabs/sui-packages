module 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_config {
    struct BBBConfig has key {
        id: 0x2::object::UID,
        af_swaps: vector<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>,
        burns: vector<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>,
    }

    struct BBB_CONFIG has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : BBBConfig {
        BBBConfig{
            id       : 0x2::object::new(arg0),
            af_swaps : 0x1::vector::empty<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(),
            burns    : 0x1::vector::empty<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(),
        }
    }

    public fun add_aftermath_swap(arg0: &mut BBBConfig, arg1: &0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_admin::BBBAdminCap, arg2: 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap) {
        let v0 = &arg0.af_swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v0)) {
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v0, v1)) == 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::type_in(&arg2)) {
                v2 = true;
                /* label 6 */
                assert!(!v2, 101);
                0x1::vector::push_back<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(&mut arg0.af_swaps, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun add_burn_type(arg0: &mut BBBConfig, arg1: &0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_admin::BBBAdminCap, arg2: 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v0)) {
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::coin_type(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v0, v1)) == 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::coin_type(&arg2)) {
                v2 = true;
                /* label 6 */
                assert!(!v2, 100);
                0x1::vector::push_back<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(&mut arg0.burns, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public fun af_swaps(arg0: &BBBConfig) : &vector<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap> {
        &arg0.af_swaps
    }

    public fun burns(arg0: &BBBConfig) : &vector<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn> {
        &arg0.burns
    }

    public fun get_aftermath_swap<T0>(arg0: &BBBConfig) : 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.af_swaps;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v1)) {
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v1, v2)) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 103);
                return *0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(&arg0.af_swaps, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun get_burn<T0>(arg0: &BBBConfig) : 0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &arg0.burns;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v1)) {
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::coin_type(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v1, v2)) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v3), 102);
                return *0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(&arg0.burns, 0x1::option::destroy_some<u64>(v3))
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun id(arg0: &BBBConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: BBB_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BBBConfig>(new(arg1));
    }

    public fun remove_aftermath_swap<T0>(arg0: &mut BBBConfig, arg1: &0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.af_swaps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v0)) {
            let v3 = 0x1::type_name::get<T0>();
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::type_in(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(v0, v1)) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 103);
                0x1::vector::swap_remove<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_aftermath_swap::AftermathSwap>(&mut arg0.af_swaps, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun remove_burn_type<T0>(arg0: &mut BBBConfig, arg1: &0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_admin::BBBAdminCap) {
        let v0 = &arg0.burns;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v0)) {
            let v3 = 0x1::type_name::get<T0>();
            if (0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::coin_type(0x1::vector::borrow<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(v0, v1)) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 102);
                0x1::vector::swap_remove<0x68cabe8f36b01b0a245422838cc30b405f9d6e7068a6b3a8cd02cac85a7641eb::bbb_burn::Burn>(&mut arg0.burns, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

