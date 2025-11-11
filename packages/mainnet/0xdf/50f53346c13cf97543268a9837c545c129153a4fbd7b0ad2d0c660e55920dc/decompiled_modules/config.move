module 0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        verified_extensions: vector<0x1::type_name::TypeName>,
        max_performance_fee_bps: u64,
        max_management_fee_bps: u64,
        max_withdrawal_fee_bps: u64,
    }

    public fun assert_extension_is_verified(arg0: &Config, arg1: &0x1::type_name::TypeName) {
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.verified_extensions, arg1), 3);
    }

    public(friend) fun assert_fees_are_valid(arg0: &Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg0.max_performance_fee_bps, 2);
        assert!(arg2 <= arg0.max_management_fee_bps, 2);
        assert!(arg3 <= arg0.max_withdrawal_fee_bps, 2);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        let v0 = Config{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            verified_extensions     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            max_performance_fee_bps : 2000,
            max_management_fee_bps  : 1000,
            max_withdrawal_fee_bps  : 500,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun unverify_extension<T0>(arg0: &mut Config, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::PACKAGE, T0>, arg2: 0x1::type_name::TypeName) {
        assert_package_version(arg0);
        let v0 = &arg0.verified_extensions;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.verified_extensions, 0x1::option::extract<u64>(&mut v2));
                0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::events::emit_unverified_extension_event(arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::PACKAGE, T0>) {
        assert!(arg0.version == 1 - 1, 0);
        arg0.version = 1;
    }

    public fun verify_extension<T0, T1: copy + drop + store>(arg0: &mut Config, arg1: &0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::AuthorityCap<0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::authority::PACKAGE, T0>, arg2: &T1) {
        assert_package_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x1::vector::contains<0x1::type_name::TypeName>(&arg0.verified_extensions, &v0)) {
            return
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.verified_extensions, v0);
        0xdf50f53346c13cf97543268a9837c545c129153a4fbd7b0ad2d0c660e55920dc::events::emit_verified_extension_event(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

