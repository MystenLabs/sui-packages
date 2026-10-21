module 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct VENDOR<phantom T0> has drop {
        dummy_field: bool,
    }

    struct REVOKE_VENDOR_GUARDIAN has drop {
        dummy_field: bool,
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        assert!(!0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::exists<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg1), 0);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        let v3 = 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)));
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg1, &v3);
        0x2::transfer::public_transfer<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>>(v3, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_package_revoke_vendor_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = REVOKE_VENDOR_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<PACKAGE, REVOKE_VENDOR_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_vendor_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN> {
        assert!(!0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::exists<VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0), 0);
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_admin_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)))
    }

    public(friend) fun create_vendor_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton_assistant_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    // decompiled from Move bytecode v7
}

