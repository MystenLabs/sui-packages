module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::executable {
    struct Executable<T0: store> {
        id: 0x2::object::UID,
        intent: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>,
        action_idx: u64,
    }

    public(friend) fun new<T0: store>(arg0: 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0>, arg1: &mut 0x2::tx_context::TxContext) : Executable<T0> {
        Executable<T0>{
            id         : 0x2::object::new(arg1),
            intent     : arg0,
            action_idx : 0,
        }
    }

    public fun action_idx<T0: store>(arg0: &Executable<T0>) : u64 {
        arg0.action_idx
    }

    fun assert_can_increment_for_current_action<T0: store, T1: drop>(arg0: &Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(!0x1::type_name::is_primitive(&v0), 2);
        let v1 = current_action_type<T0>(arg0);
        assert!(!0x1::type_name::is_primitive(&v1), 2);
        let v2 = if (same_package_family(arg1, &v0, &v1)) {
            if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                let v3 = struct_name_bytes(&v0);
                let v4 = b"ExecutionProgressWitness";
                &v3 == &v4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
    }

    fun assert_can_increment_with_deps<T0: store, T1: drop>(arg0: &Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &0x2::table::Table<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>) {
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(!0x1::type_name::is_primitive(&v0), 2);
        let v1 = current_action_type<T0>(arg0);
        assert!(!0x1::type_name::is_primitive(&v1), 2);
        let v2 = if (same_package_family(arg1, &v0, &v1) || same_dep_family(arg2, &v0, &v1)) {
            if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                let v3 = struct_name_bytes(&v0);
                let v4 = b"ExecutionProgressWitness";
                &v3 == &v4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 2);
    }

    public fun assert_current_action_witness<T0: store, T1: drop>(arg0: &Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: T1) {
        assert!(arg0.action_idx < 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(intent<T0>(arg0))), 0);
        assert_can_increment_for_current_action<T0, T1>(arg0, arg1);
    }

    public fun current_action_type<T0: store>(arg0: &Executable<T0>) : 0x1::type_name::TypeName {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(intent<T0>(arg0));
        assert!(arg0.action_idx < 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0), 0);
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_type(0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0, arg0.action_idx))
    }

    fun destroy<T0: store>(arg0: Executable<T0>) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0> {
        let Executable {
            id         : v0,
            intent     : v1,
            action_idx : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun destroy_complete<T0: store>(arg0: Executable<T0>) : 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0> {
        assert!(is_complete<T0>(&arg0), 1);
        destroy<T0>(arg0)
    }

    public fun increment_action_idx<T0: store, T1: drop, T2: drop>(arg0: &mut Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: T2) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(intent<T0>(arg0));
        assert!(arg0.action_idx < 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0), 0);
        assert_can_increment_for_current_action<T0, T2>(arg0, arg1);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::is_action_type<T1>(0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0, arg0.action_idx)), 2);
        arg0.action_idx = arg0.action_idx + 1;
    }

    public fun increment_action_idx_with_deps<T0: store, T1: drop, T2: drop>(arg0: &mut Executable<T0>, arg1: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg2: &0x2::table::Table<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>, arg3: T2) {
        let v0 = 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(intent<T0>(arg0));
        assert!(arg0.action_idx < 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0), 0);
        assert_can_increment_with_deps<T0, T2>(arg0, arg1, arg2);
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation::is_action_type<T1>(0x1::vector::borrow<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(v0, arg0.action_idx)), 2);
        arg0.action_idx = arg0.action_idx + 1;
    }

    public fun intent<T0: store>(arg0: &Executable<T0>) : &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::Intent<T0> {
        &arg0.intent
    }

    public fun is_complete<T0: store>(arg0: &Executable<T0>) : bool {
        arg0.action_idx == 0x1::vector::length<0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec>(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_specs<T0>(intent<T0>(arg0)))
    }

    fun same_dep_family(arg0: &0x2::table::Table<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>, arg1: &0x1::type_name::TypeName, arg2: &0x1::type_name::TypeName) : bool {
        let v0 = type_name_package_addr(arg1);
        let v1 = type_name_package_addr(arg2);
        0x2::table::contains<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>(arg0, v0) && 0x2::table::contains<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>(arg0, v1) && 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::dep_name(0x2::table::borrow<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>(arg0, v0)) == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::dep_name(0x2::table::borrow<address, 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::deps::DepInfo>(arg0, v1))
    }

    fun same_package_family(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::PackageRegistry, arg1: &0x1::type_name::TypeName, arg2: &0x1::type_name::TypeName) : bool {
        let v0 = type_name_package_addr(arg1);
        let v1 = type_name_package_addr(arg2);
        if (v0 == v1) {
            return true
        };
        if (!0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::contains_package_addr(arg0, v0) || !0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::contains_package_addr(arg0, v1)) {
            return false
        };
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::get_package_name(arg0, v0) == 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::package_registry::get_package_name(arg0, v1)
    }

    fun struct_name_bytes(arg0: &0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x1::type_name::address_string(arg0);
        let v2 = 0x1::type_name::module_string(arg0);
        let v3 = 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v1)) + 2 + 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v2)) + 2;
        if (v3 >= 0x1::vector::length<u8>(v0)) {
            return b""
        };
        let v4 = b"";
        while (v3 < 0x1::vector::length<u8>(v0)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v3);
            if (v5 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v4, v5);
            v3 = v3 + 1;
        };
        v4
    }

    fun type_name_package_addr(arg0: &0x1::type_name::TypeName) : address {
        0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(arg0))))
    }

    public(friend) fun uid<T0: store>(arg0: &Executable<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0: store>(arg0: &mut Executable<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

