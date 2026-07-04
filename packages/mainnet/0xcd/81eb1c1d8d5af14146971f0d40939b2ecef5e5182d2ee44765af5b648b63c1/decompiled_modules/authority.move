module 0xcd81eb1c1d8d5af14146971f0d40939b2ecef5e5182d2ee44765af5b648b63c1::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct VAULT<phantom T0> has drop {
        dummy_field: bool,
    }

    struct MAINTENANCE has drop {
        dummy_field: bool,
    }

    struct PAUSE_GUARDIAN has drop {
        dummy_field: bool,
    }

    struct TREASURY has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_is_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(), 13835058914275622913);
    }

    public(friend) fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(), 13835058897095753729);
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_multiton_package_maintenance_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, MAINTENANCE> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = MAINTENANCE{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton<PACKAGE, MAINTENANCE>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_multiton_package_pause_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = PAUSE_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton<PACKAGE, PAUSE_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_package_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339865266454531);
        assert!(!0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::exists<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg1), 13835339886741291011);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)))
    }

    public(friend) fun create_vault_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        assert!(!0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::exists<VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0), 13835621632301072389);
        let v0 = VAULT<T0>{dummy_field: false};
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_admin_cap<VAULT<T0>>(arg0, &v0, 0x2::object::uid_to_inner(arg0))
    }

    public(friend) fun create_vault_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VAULT<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = VAULT<T0>{dummy_field: false};
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton_assistant_cap<VAULT<T0>>(arg0, &v0, 0x2::object::uid_to_inner(arg0), arg1)
    }

    public(friend) fun create_vault_treasury_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VAULT<T0>, TREASURY> {
        let v0 = VAULT<T0>{dummy_field: false};
        let v1 = TREASURY{dummy_field: false};
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton<VAULT<T0>, TREASURY>(arg0, &v0, &v1, 0x2::object::uid_to_inner(arg0), arg1)
    }

    public(friend) fun package_id() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v7
}

