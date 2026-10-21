module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority {
    struct PACKAGE has drop {
        dummy_field: bool,
    }

    struct VENDOR<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ACCOUNT has drop {
        dummy_field: bool,
    }

    struct ADL has drop {
        dummy_field: bool,
    }

    struct PAUSE_GUARDIAN has drop {
        dummy_field: bool,
    }

    struct TREASURY has drop {
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

    public fun assert_is_admin_or_assistant<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() || v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(), 6100);
    }

    public(friend) fun assert_is_admin_or_assistant_or_maintenance<T0>() {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<MAINTENANCE>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>()
        };
        assert!(v1, 6100);
    }

    public(friend) fun assert_is_not_admin<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(), 6100);
    }

    public(friend) fun create_account_admin_cap(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN> {
        let v0 = ACCOUNT{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_admin_cap<ACCOUNT>(arg0, &v0, arg1)
    }

    public(friend) fun create_account_assistant_cap(arg0: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg1: &mut 0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        let v0 = ACCOUNT{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton_assistant_cap<ACCOUNT>(arg1, &v0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::for<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0), arg2)
    }

    public(friend) fun create_package_adl_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, ADL> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = ADL{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<PACKAGE, ADL>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_package_admin_cap_and_keep<T0: drop>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 66);
        let v0 = PACKAGE{dummy_field: false};
        let v1 = 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_admin_cap<PACKAGE>(arg1, &v0, this_package());
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg1, &v1);
        0x2::transfer::public_transfer<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>>(v1, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_package_assistant_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        let v0 = PACKAGE{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton_assistant_cap<PACKAGE>(arg0, &v0, this_package(), arg1)
    }

    public(friend) fun create_package_freeze_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, FREEZE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = FREEZE_GUARDIAN{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<PACKAGE, FREEZE_GUARDIAN>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_package_pause_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, PAUSE_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = PAUSE_GUARDIAN{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<PACKAGE, PAUSE_GUARDIAN>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_package_revoke_vendor_guardian_cap(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<PACKAGE, REVOKE_VENDOR_GUARDIAN> {
        let v0 = PACKAGE{dummy_field: false};
        let v1 = REVOKE_VENDOR_GUARDIAN{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<PACKAGE, REVOKE_VENDOR_GUARDIAN>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_vendor_admin_cap<T0>(arg0: &mut 0x2::object::UID) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN> {
        let v0 = VENDOR<T0>{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_admin_cap<VENDOR<T0>>(arg0, &v0, this_package())
    }

    public(friend) fun create_vendor_assistant_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        let v0 = VENDOR<T0>{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton_assistant_cap<VENDOR<T0>>(arg0, &v0, this_package(), arg1)
    }

    public(friend) fun create_vendor_maintenance_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, MAINTENANCE> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = MAINTENANCE{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<VENDOR<T0>, MAINTENANCE>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_vendor_pause_guardian_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, PAUSE_GUARDIAN> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = PAUSE_GUARDIAN{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<VENDOR<T0>, PAUSE_GUARDIAN>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun create_vendor_treasury_cap<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<VENDOR<T0>, TREASURY> {
        let v0 = VENDOR<T0>{dummy_field: false};
        let v1 = TREASURY{dummy_field: false};
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::new_multiton<VENDOR<T0>, TREASURY>(arg0, &v0, &v1, this_package(), arg1)
    }

    public(friend) fun destroy_account_assistant_cap(arg0: 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>) {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::destroy<ACCOUNT, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, 0x1::internal::permit<ACCOUNT>());
    }

    fun this_package() : 0x2::object::ID {
        let v0 = 0x1::type_name::with_defining_ids<PACKAGE>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v1))
    }

    // decompiled from Move bytecode v7
}

