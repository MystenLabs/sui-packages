module 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058227080855553);
        assert!(!0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::exists<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1), 13835058248555692033);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        let v3 = 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &v3);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v3, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

