module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config {
    struct ActiveMultitonAuthorityCaps<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct RegisteredSource<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        next_storage_id: u32,
        next_source_id: u16,
        active_assistants: vector<0x2::object::ID>,
    }

    public(friend) fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun active_assistants(arg0: &Config) : vector<0x2::object::ID> {
        arg0.active_assistants
    }

    public fun assert_package_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        assert!(has_active_package_authority<T0>(arg0, arg1), 13835622822007013381);
    }

    public fun assert_package_version(arg0: &Config) {
        if (arg0.version > 1) {
            abort 13835341316965400579
        };
    }

    public fun assert_vendor_authority_cap_is_valid<T0, T1>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>) {
        assert!(has_vendor_authority<T0, T1>(arg0, arg1), 13835622852071784453);
    }

    fun authorize_multiton_authority_cap<T0, T1>(arg0: &mut Config, arg1: 0x2::object::ID) {
        let v0 = &mut arg0.id;
        let v1 = ActiveMultitonAuthorityCaps<T0, T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<ActiveMultitonAuthorityCaps<T0, T1>>(v0, v1)) {
            0x2::dynamic_field::add<ActiveMultitonAuthorityCaps<T0, T1>, vector<0x2::object::ID>>(v0, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<ActiveMultitonAuthorityCaps<T0, T1>, vector<0x2::object::ID>>(v0, v1), arg1);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058463304056833);
        Config{
            id                : 0x2::object::new(arg1),
            version           : 1,
            next_storage_id   : 0,
            next_source_id    : 0,
            active_assistants : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    fun has_active_multiton_authority_cap<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        let v0 = ActiveMultitonAuthorityCaps<T0, T1>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<ActiveMultitonAuthorityCaps<T0, T1>, vector<0x2::object::ID>>(&arg0.id, v0) && 0x1::vector::contains<0x2::object::ID>(0x2::dynamic_field::borrow<ActiveMultitonAuthorityCaps<T0, T1>, vector<0x2::object::ID>>(&arg0.id, v0), &arg1)
    }

    public(friend) fun has_active_package_authority<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>()) {
            let v2 = 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>>(arg1);
            0x1::vector::contains<0x2::object::ID>(&arg0.active_assistants, &v2)
        } else {
            false
        }
    }

    public(friend) fun has_vendor_authority<T0, T1>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>() && has_active_multiton_authority_cap<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>>(arg1))) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE>() && has_active_multiton_authority_cap<T0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE>(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>>(arg1))
        }
    }

    public(friend) fun inc_storage_id(arg0: &mut Config) : u32 {
        let v0 = arg0.next_storage_id;
        arg0.next_storage_id = v0 + 1;
        v0
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_assistants, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun new_source_id<T0, T1>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T1>) : 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap {
        assert_package_version(arg0);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        assert_package_authority_cap_is_valid<T1>(arg0, arg1);
        let v0 = RegisteredSource<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<RegisteredSource<T0>, u16>(&arg0.id, v0), 13835903450875297799);
        let v1 = arg0.next_source_id;
        arg0.next_source_id = v1 + 1;
        0x2::dynamic_field::add<RegisteredSource<T0>, u16>(&mut arg0.id, v0, v1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_added_authorization(v1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::new_source_cap(v1)
    }

    public fun new_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::create_vendor_assistant_cap<T0>(&mut arg0.id, arg2);
        authorize_multiton_authority_cap<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>>(&v0));
        v0
    }

    public fun new_vendor_maintenance_cap<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE> {
        assert_package_version(arg0);
        let v0 = 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::create_vendor_maintenance_cap<T0>(&mut arg0.id, arg2);
        authorize_multiton_authority_cap<T0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE>(arg0, 0x2::object::id<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE>>(&v0));
        v0
    }

    public fun register_vendor<T0, T1>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::authority::VENDOR<T0>, T1>, arg2: &mut 0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::VendorMetadata<T0>) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        assert_package_version(arg0);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T1>();
        0x9b8c58edd708e2b9c245b973cbc236d4d3e3b0e1e790c94958b4f08da72a71ac::metadata::assert_has_active_vendor_authority<T0, T1>(arg2, arg1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::create_vendor_admin_cap<T0>(&mut arg0.id)
    }

    fun revoke_multiton_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(has_active_multiton_authority_cap<T0, T1>(arg0, arg2), 13835622972330868741);
        let v0 = ActiveMultitonAuthorityCaps<T0, T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ActiveMultitonAuthorityCaps<T0, T1>, vector<0x2::object::ID>>(&mut arg0.id, v0);
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            if (0x1::vector::borrow<0x2::object::ID>(v1, v2) == &arg2) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                0x1::vector::remove<0x2::object::ID>(v1, 0x1::option::destroy_some<u64>(v3));
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun revoke_package_assistant_cap(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        let v0 = &arg0.active_assistants;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg2) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13835621718200418309);
                0x1::vector::remove<0x2::object::ID>(&mut arg0.active_assistants, 0x1::option::destroy_some<u64>(v2));
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun revoke_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        revoke_multiton_authority_cap<T0, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>(arg0, arg1, arg2);
    }

    public fun revoke_vendor_maintenance_cap<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: 0x2::object::ID) {
        revoke_multiton_authority_cap<T0, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::MAINTENANCE>(arg0, arg1, arg2);
    }

    public fun set_authorized<T0>(arg0: &Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>, arg2: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::SourceCap, arg3: bool) {
        assert_package_version(arg0);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T0>();
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::set_source_cap_authorized(arg2, arg3);
        if (arg3) {
            0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_added_authorization(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(arg2));
        } else {
            0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::events::emit_removed_authorization(0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::source_id(arg2));
        };
    }

    public fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835340342007824387);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::assert_is_admin_or_assistant<T0>();
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v7
}

