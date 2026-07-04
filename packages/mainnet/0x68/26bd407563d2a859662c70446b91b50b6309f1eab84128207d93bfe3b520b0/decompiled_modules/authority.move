module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct VENDOR<phantom T0> has drop {
        dummy_field: bool,
    }

    struct MAINTENANCE has drop {
        dummy_field: bool,
    }

    struct VendorAuthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VendorSourceCap<phantom T0> has store {
        dummy_field: bool,
    }

    struct SourceCap has store {
        source_id: u16,
        authorized: bool,
    }

    public(friend) fun add_vendor_authorization<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = VendorAuthKey{dummy_field: false};
        let v1 = VendorSourceCap<T0>{dummy_field: false};
        0x2::dynamic_field::add<VendorAuthKey, VendorSourceCap<T0>>(arg0, v0, v1);
    }

    public(friend) fun assert_has_active_vendor_authority<T0>(arg0: &0x2::object::UID) {
        assert!(has_vendor_authorization<T0>(arg0), 13835903579724316679);
    }

    public(friend) fun assert_is_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(), 13835059133318955009);
    }

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(), 13835059090369282049);
    }

    public fun assert_is_admin_or_maintenance<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<MAINTENANCE>() || v0 == 0x1::type_name::with_defining_ids<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(), 13835059116139085825);
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339873856389123);
        assert!(!0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::exists<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg1), 13835339895331225603);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x2::transfer::public_transfer<0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<PACKAGE, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>>(0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2))), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_vendor_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN> {
        assert!(!0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::exists<VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>(arg0), 13835621524926889989);
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_admin_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)))
    }

    public(friend) fun create_vendor_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ASSISTANT> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton_assistant_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_vendor_maintenance_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<VENDOR<T0>, MAINTENANCE> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = MAINTENANCE{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::new_multiton<VENDOR<T0>, MAINTENANCE>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public fun has_vendor_authorization<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = VendorAuthKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<VendorAuthKey, VendorSourceCap<T0>>(arg0, v0)
    }

    public fun is_authorized(arg0: &SourceCap) : bool {
        arg0.authorized
    }

    public(friend) fun new_source_cap(arg0: u16) : SourceCap {
        SourceCap{
            source_id  : arg0,
            authorized : true,
        }
    }

    public(friend) fun set_source_cap_authorized(arg0: &mut SourceCap, arg1: bool) {
        arg0.authorized = arg1;
    }

    public fun source_id(arg0: &SourceCap) : u16 {
        arg0.source_id
    }

    // decompiled from Move bytecode v7
}

