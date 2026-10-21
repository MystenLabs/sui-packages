module 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config {
    struct RegisteredSource<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VendorRegistrationOpen has copy, drop, store {
        dummy_field: bool,
    }

    struct FrozenVersion has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        next_storage_id: u32,
        next_source_id: u16,
    }

    public(friend) fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun assert_package_authority_cap_is_valid<T0>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) {
        assert!(has_active_package_authority<T0>(arg0, arg1), 13835623066820149253);
    }

    public fun assert_package_version(arg0: &Config) {
        if (arg0.version > 1) {
            abort 13835341557483569155
        };
    }

    public fun assert_vendor_authority_cap_is_valid<T0, T1>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>) {
        assert!(has_vendor_authority<T0, T1>(arg0, arg1), 13835623096884920325);
    }

    fun authorize_vendor_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>) {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>(&mut arg0.id, arg1);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835058351634907137);
        Config{
            id              : 0x2::object::new(arg1),
            version         : 1,
            next_storage_id : 0,
            next_source_id  : 0,
        }
    }

    public fun freeze_package(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>(&arg0.id, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>>(arg1)), 13835622044617932805);
        let v0 = arg0.version;
        let v1 = FrozenVersion{dummy_field: false};
        0x2::dynamic_field::add<FrozenVersion, u64>(&mut arg0.id, v1, v0);
        arg0.version = 18446744073709551615;
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_froze(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>>(arg1));
    }

    public fun guardian_revoke_vendor_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>(&arg0.id, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>>(arg1)), 13835622126222311429);
        assert!(has_active_vendor_authority_cap<T0, T1>(arg0, arg2), 13835622143402180613);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>(&mut arg0.id, arg2);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_guardian_revoked_vendor_authority_cap(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2);
    }

    public(friend) fun has_active_package_authority<T0>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>() || v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() && 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&arg0.id, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>>(arg1))
    }

    fun has_active_vendor_authority_cap<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>(&arg0.id, arg1)
    }

    public(friend) fun has_vendor_authority<T0, T1>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>() && has_active_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>>(arg1))) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>() && has_active_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>>(arg1))) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::MAINTENANCE>() && has_active_vendor_authority_cap<T0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::MAINTENANCE>(arg0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>>(arg1))
        }
    }

    public(friend) fun inc_storage_id(arg0: &mut Config) : u32 {
        let v0 = arg0.next_storage_id;
        arg0.next_storage_id = v0 + 1;
        v0
    }

    public fun is_authority_cap_active<T0, T1>(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<T0, T1>(&arg0.id, arg1)
    }

    public fun is_frozen(arg0: &Config) : bool {
        let v0 = FrozenVersion{dummy_field: false};
        0x2::dynamic_field::exists_with_type<FrozenVersion, u64>(&arg0.id, v0)
    }

    public fun is_vendor_registration_open(arg0: &Config) : bool {
        let v0 = VendorRegistrationOpen{dummy_field: false};
        0x2::dynamic_field::exists_with_type<VendorRegistrationOpen, bool>(&arg0.id, v0) && *0x2::dynamic_field::borrow<VendorRegistrationOpen, bool>(&arg0.id, v0)
    }

    public fun new_package_assistant_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_multiton_package_assistant_cap(&mut arg0.id, arg2);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&mut arg0.id, &v0);
        v0
    }

    public fun new_package_freeze_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_package_freeze_guardian_cap(&mut arg0.id, arg2);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>(&mut arg0.id, &v0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_created_package_freeze_guardian_cap(0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>>(&v0));
        v0
    }

    public fun new_package_revoke_vendor_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN> {
        assert_package_version(arg0);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_package_revoke_vendor_guardian_cap(&mut arg0.id, arg2);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>(&mut arg0.id, &v0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_created_package_revoke_vendor_guardian_cap(0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>>(&v0));
        v0
    }

    public(friend) fun new_source_id<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T1>) : 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::SourceCap {
        assert_package_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T1>();
        assert_package_authority_cap_is_valid<T1>(arg0, arg1);
        let v0 = RegisteredSource<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<RegisteredSource<T0>, u16>(&arg0.id, v0), 13835903824537452551);
        let v1 = arg0.next_source_id;
        arg0.next_source_id = v1 + 1;
        0x2::dynamic_field::add<RegisteredSource<T0>, u16>(&mut arg0.id, v0, v1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_added_authorization(v1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::new_source_cap(v1)
    }

    public fun new_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT> {
        assert_package_version(arg0);
        assert_vendor_authority_cap_is_valid<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_vendor_assistant_cap<T0>(&mut arg0.id, arg2);
        authorize_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, &v0);
        v0
    }

    public fun new_vendor_maintenance_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &mut 0x2::tx_context::TxContext) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::MAINTENANCE> {
        assert_package_version(arg0);
        assert_vendor_authority_cap_is_valid<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_vendor_maintenance_cap<T0>(&mut arg0.id, arg2);
        authorize_vendor_authority_cap<T0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::MAINTENANCE>(arg0, &v0);
        v0
    }

    public fun reauthorize_vendor_admin_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::exists<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id), 13836466246210158603);
        let v0 = 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::derived_cap_id<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id);
        assert!(!0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(&arg0.id, v0), 13836747746956804109);
        0x2::dynamic_field::add<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorizedAuthorityCapKey<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, bool>(&mut arg0.id, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::authorized_authority_cap_key<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(v0), true);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_reauthorized_vendor_admin_cap(0x1::type_name::with_defining_ids<T0>(), v0);
    }

    public fun register_vendor<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::authority::VENDOR<T0>, T1>, arg2: &0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::Config, arg3: &0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::metadata::VendorMetadata<T0>) : 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN> {
        assert_package_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T1>();
        0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::config::assert_has_active_vendor_authority<T0, T1>(arg2, arg1);
        assert!(is_vendor_registration_open(arg0) || 0xe2a2f69e6818cc578b7fe506ac965c4c9aebee1984bde24a1d29b2484eb38f9f::metadata::is_domain_registration_approved<T0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE>(arg3), 13836185462723051529);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::create_vendor_admin_cap<T0>(&mut arg0.id);
        authorize_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, &v0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_registered_vendor(0x1::type_name::with_defining_ids<T0>(), 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>>(&v0));
        v0
    }

    public fun revoke_package_assistant_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&arg0.id, arg2), 13835621649480941573);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(&mut arg0.id, arg2);
    }

    public fun revoke_package_freeze_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>(&arg0.id, arg2), 13835621993078325253);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::FREEZE_GUARDIAN>(&mut arg0.id, arg2);
    }

    public fun revoke_package_revoke_vendor_guardian_cap(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        assert!(0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::is_cap_authorized<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>(&arg0.id, arg2), 13835621769740025861);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::REVOKE_VENDOR_GUARDIAN>(&mut arg0.id, arg2);
    }

    public fun revoke_vendor_assistant_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        revoke_vendor_authority_cap<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>(arg0, arg1, arg2);
    }

    fun revoke_vendor_authority_cap<T0, T1>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        assert_package_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_not_admin<T1>();
        assert_vendor_authority_cap_is_valid<T0, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>(arg0, arg1);
        assert!(has_active_vendor_authority_cap<T0, T1>(arg0, arg2), 13835623174194331653);
        0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::deauthorize_cap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>(&mut arg0.id, arg2);
    }

    public fun revoke_vendor_maintenance_cap<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: 0x2::object::ID) {
        revoke_vendor_authority_cap<T0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::MAINTENANCE>(arg0, arg1, arg2);
    }

    public fun set_authorized<T0>(arg0: &Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg2: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::SourceCap, arg3: bool) {
        assert_package_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T0>();
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::set_source_cap_authorized(arg2, arg3);
        if (arg3) {
            0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_added_authorization(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::source_id(arg2));
        } else {
            0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_removed_authorization(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::source_id(arg2));
        };
    }

    entry fun set_vendor_registration(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: bool) {
        assert_package_version(arg0);
        let v0 = &mut arg0.id;
        let v1 = VendorRegistrationOpen{dummy_field: false};
        if (!0x2::dynamic_field::exists<VendorRegistrationOpen>(v0, v1)) {
            0x2::dynamic_field::add<VendorRegistrationOpen, bool>(v0, v1, arg2);
        };
        *0x2::dynamic_field::borrow_mut<VendorRegistrationOpen, bool>(v0, v1) = arg2;
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_set_vendor_registration(arg2);
    }

    public fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun unfreeze_package(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert!(is_frozen(arg0), 13837028882631229455);
        let v0 = FrozenVersion{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove<FrozenVersion, u64>(&mut arg0.id, v0);
        assert!(v1 <= 1, 13837310379082907665);
        arg0.version = v1;
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::events::emit_unfroze(0x2::object::uid_to_inner(&arg0.id), v1);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>) {
        assert!(arg0.version < 1, 13835340801569325059);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T0>();
        assert_package_authority_cap_is_valid<T0>(arg0, arg1);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v7
}

