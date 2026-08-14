module 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct VENDOR<phantom T0> has drop {
        dummy_field: bool,
    }

    struct MAINTENANCE has drop {
        dummy_field: bool,
    }

    struct REVOKE_VENDOR_GUARDIAN has drop {
        dummy_field: bool,
    }

    struct FREEZE_GUARDIAN has drop {
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
        assert!(has_vendor_authorization<T0>(arg0), 13835903815947517959);
    }

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(), 13835059326592483329);
    }

    public fun assert_is_admin_or_maintenance<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<MAINTENANCE>() || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(), 13835059352362287105);
    }

    public(friend) fun assert_is_not_admin<T0>() {
        assert!(!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>()), 13835059369542156289);
    }

    public(friend) fun create_multiton_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339959755735043);
        assert!(!0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::exists<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1), 13835339981230571523);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        let v3 = 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_admin_cap<PACKAGE>(arg1, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1, &v3);
        0x2::transfer::public_transfer<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>>(v3, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_freeze_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = FREEZE_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<PACKAGE, FREEZE_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_package_revoke_vendor_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = REVOKE_VENDOR_GUARDIAN{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<PACKAGE, REVOKE_VENDOR_GUARDIAN>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
    }

    public(friend) fun create_vendor_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN> {
        assert!(!0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::exists<VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0), 13835621632301072389);
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_admin_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)))
    }

    public(friend) fun create_vendor_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton_assistant_cap<VENDOR<T0>>(arg0, &v0, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v2)), arg1)
    }

    public(friend) fun create_vendor_maintenance_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<VENDOR<T0>, MAINTENANCE> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = MAINTENANCE{dummy_field: false};
        let v2 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::new_multiton<VENDOR<T0>, MAINTENANCE>(arg0, &v0, &v1, 0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1)
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

