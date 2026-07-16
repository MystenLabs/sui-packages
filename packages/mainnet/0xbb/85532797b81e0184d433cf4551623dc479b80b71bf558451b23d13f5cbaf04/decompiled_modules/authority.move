module 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::authority {
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

    struct FREEZE_GUARDIAN has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_is_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(), 13835059064599478273);
    }

    public(friend) fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(), 13835059047419609089);
    }

    public(friend) fun assert_is_not_admin<T0>() {
        assert!(!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>()), 13835059081779347457);
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_multiton_package_freeze_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = FREEZE_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<PACKAGE, FREEZE_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_multiton_package_maintenance_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, MAINTENANCE> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = MAINTENANCE{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<PACKAGE, MAINTENANCE>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_multiton_package_pause_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = PAUSE_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<PACKAGE, PAUSE_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_package_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339895331225603);
        assert!(!0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::exists<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1), 13835339916806062083);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        let v3 = 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &v3);
        v3
    }

    public(friend) fun create_vault_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VAULT<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN> {
        assert!(!0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::exists<VAULT<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0), 13835621752560156677);
        let v0 = VAULT<T0>{dummy_field: false};
        let v1 = 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_admin_cap<VAULT<T0>>(arg0, &v0, 0x2::object::uid_to_inner(arg0));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<VAULT<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, &v1);
        v1
    }

    public(friend) fun create_vault_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VAULT<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = VAULT<T0>{dummy_field: false};
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton_assistant_cap<VAULT<T0>>(arg0, &v0, 0x2::object::uid_to_inner(arg0), arg1)
    }

    public(friend) fun create_vault_treasury_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VAULT<T0>, TREASURY> {
        let v0 = VAULT<T0>{dummy_field: false};
        let v1 = TREASURY{dummy_field: false};
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<VAULT<T0>, TREASURY>(arg0, &v0, &v1, 0x2::object::uid_to_inner(arg0), arg1)
    }

    public(friend) fun package_id() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v7
}

