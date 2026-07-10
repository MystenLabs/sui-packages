module 0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::metadata {
    struct VendorMetadataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ApprovedDomainRegistrationKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VendorMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        extra_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun approve_domain_registration<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<ApprovedDomainRegistrationKey<T1>, bool>(&mut arg0.id, v0, true);
        0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::events::emit_approve_domain_registration_event(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
    }

    public fun assert_has_active_vendor_authority<T0, T1>(arg0: &VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>) {
        assert!(has_vendor_authority<T0, T1>(arg0, arg1), 2);
    }

    public(friend) fun authorize_vendor_admin_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(&mut arg0.id, arg1);
    }

    public(friend) fun authorize_vendor_assistant_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>) {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorize_cap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(&mut arg0.id, arg1);
    }

    public(friend) fun deauthorize_vendor_assistant_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: 0x2::object::ID) {
        deauthorize_vendor_authority_cap<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, arg1);
    }

    public(friend) fun deauthorize_vendor_authority_cap<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: 0x2::object::ID) {
        assert!(is_vendor_authority_cap_authorized<T0, T1>(arg0, arg1), 2);
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::deauthorize_cap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>(&mut arg0.id, arg1);
    }

    public(friend) fun has_vendor_authority<T0, T1>(arg0: &VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>() && is_vendor_authority_cap_authorized<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>>(arg1)) || v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>() && is_vendor_authority_cap_authorized<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>>(arg1))
    }

    public fun is_domain_registration_approved<T0, T1>(arg0: &VendorMetadata<T0>) : bool {
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists<ApprovedDomainRegistrationKey<T1>>(&arg0.id, v0)
    }

    public(friend) fun is_vendor_authority_cap_authorized<T0, T1>(arg0: &VendorMetadata<T0>, arg1: 0x2::object::ID) : bool {
        0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::is_cap_authorized<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>(&arg0.id, arg1)
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : VendorMetadata<T0> {
        let v0 = VendorMetadataKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<VendorMetadataKey<T0>>(arg0, v0), 0);
        VendorMetadata<T0>{
            id           : 0x2::derived_object::claim<VendorMetadataKey<T0>>(arg0, v0),
            name         : arg1,
            description  : arg2,
            extra_fields : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        }
    }

    public(friend) fun reauthorize_vendor_admin_cap<T0>(arg0: &mut VendorMetadata<T0>, arg1: 0x2::object::ID) {
        0x2::dynamic_field::add<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorizedAuthorityCapKey<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, bool>(&mut arg0.id, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::authorized_authority_cap_key<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg1), true);
    }

    public fun revoke_domain_registration_approval<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::remove<ApprovedDomainRegistrationKey<T1>, bool>(&mut arg0.id, v0);
        0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::events::emit_revoke_domain_registration_approval_event(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
    }

    public fun set_description<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String) {
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        arg0.description = arg2;
    }

    public fun set_extra_field<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        let v0 = vector[];
        assert!(!0x1::vector::contains<vector<u8>>(&v0, 0x1::ascii::as_bytes(&arg2)), 1);
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        let v1 = &mut arg0.extra_fields;
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v1, &arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v1, arg2, arg3);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v1, &arg2) = arg3;
        };
    }

    public fun set_name<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String) {
        assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        arg0.name = arg2;
    }

    // decompiled from Move bytecode v7
}

