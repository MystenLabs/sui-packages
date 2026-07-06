module 0xc79d01572bfa9dcc5ab24ef658dc0f027cae9ccfe8ceec1746f0ec998afb72d0::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058274325495809);
        assert!(!0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::exists<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg1), 13835058295800332289);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2))), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

