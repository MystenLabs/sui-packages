module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        whitelisted_extensions: vector<0x1::type_name::TypeName>,
        max_performance_fee_bps: u64,
        max_management_fee_bps: u64,
        max_withdrawal_fee_bps: u64,
        max_swap_fee_bps: u64,
        protocol_management_fee_bps: u64,
        protocol_management_fee_recipient: address,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339916806062083);
        Config{
            id                                : 0x2::object::new(arg1),
            version                           : 1,
            whitelisted_extensions            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            max_performance_fee_bps           : 2000,
            max_management_fee_bps            : 1000,
            max_withdrawal_fee_bps            : 500,
            max_swap_fee_bps                  : 500,
            protocol_management_fee_bps       : 0,
            protocol_management_fee_recipient : @0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777,
            extra_fields                      : 0x2::bag::new(arg1),
        }
    }

    public fun create_package_assistant_cap(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::ADMIN>) : 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::ASSISTANT> {
        assert_package_version(arg0);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::create_package_assistant_cap(&mut arg0.id)
    }

    public fun assert_extension_is_whitelisted(arg0: &Config, arg1: &0x1::type_name::TypeName) {
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_extensions, arg1), 13835903635558891527);
    }

    public(friend) fun assert_fees_are_valid(arg0: &Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg0.max_performance_fee_bps, 13835622207826690053);
        assert!(arg2 <= arg0.max_withdrawal_fee_bps, 13835622212121657349);
        assert!(arg3 <= arg0.max_swap_fee_bps, 13835622216416624645);
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835059171973660673);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun protocol_management_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_management_fee_bps
    }

    public fun protocol_management_fee_recipient(arg0: &Config) : address {
        arg0.protocol_management_fee_recipient
    }

    public fun set_protocol_management_fee_bps(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::ADMIN>, arg2: u64) {
        assert_package_version(arg0);
        assert!(arg2 <= arg0.max_management_fee_bps, 13835622018848129029);
        arg0.protocol_management_fee_bps = arg2;
    }

    public fun set_protocol_management_fee_recipient(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::ADMIN>, arg2: address) {
        assert_package_version(arg0);
        arg0.protocol_management_fee_recipient = arg2;
    }

    public fun unwhitelist_extension<T0>(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, T0>, arg2: 0x1::type_name::TypeName) {
        assert_package_version(arg0);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::assert_is_admin_or_assistant<T0>();
        let v0 = &arg0.whitelisted_extensions;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                } else {
                    0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_extensions, 0x1::option::extract<u64>(&mut v2));
                    0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::events::emit_unwhitelisted_extension_event(arg2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, T0>) {
        assert!(arg0.version == 1 - 1, 13835058751066865665);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::assert_is_admin_or_assistant<T0>();
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun whitelist_extension<T0, T1: copy + drop + store>(arg0: &mut Config, arg1: &0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::AuthorityCap<0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::PACKAGE, T0>, arg2: &T1) {
        assert_package_version(arg0);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::authority::assert_is_admin_or_assistant<T0>();
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_extensions, &v0)) {
            return
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.whitelisted_extensions, v0);
        0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::events::emit_whitelisted_extension_event(v0);
    }

    public fun whitelisted_extensions(arg0: &Config) : vector<0x1::type_name::TypeName> {
        arg0.whitelisted_extensions
    }

    // decompiled from Move bytecode v6
}

