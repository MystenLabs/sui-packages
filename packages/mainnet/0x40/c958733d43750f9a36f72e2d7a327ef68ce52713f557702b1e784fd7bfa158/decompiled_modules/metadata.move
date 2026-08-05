module 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::metadata {
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

    public fun approve_domain_registration<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg1);
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<ApprovedDomainRegistrationKey<T1>, bool>(&mut arg0.id, v0, true);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::events::emit_approve_domain_registration_event(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
    }

    public fun is_domain_registration_approved<T0, T1>(arg0: &VendorMetadata<T0>) : bool {
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists<ApprovedDomainRegistrationKey<T1>>(&arg0.id, v0)
    }

    public fun new<T0, T1>(arg0: &mut 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::authority::VENDOR<T0>, T1>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) : VendorMetadata<T0> {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg0);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_has_active_vendor_authority<T0, T1>(arg0, arg1);
        let v0 = VendorMetadataKey<T0>{dummy_field: false};
        let v1 = 0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::borrow_mut_id(arg0);
        assert!(!0x2::derived_object::exists<VendorMetadataKey<T0>>(v1, v0), 0);
        VendorMetadata<T0>{
            id           : 0x2::derived_object::claim<VendorMetadataKey<T0>>(v1, v0),
            name         : arg2,
            description  : arg3,
            extra_fields : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        }
    }

    public fun revoke_domain_registration_approval<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg1);
        let v0 = ApprovedDomainRegistrationKey<T1>{dummy_field: false};
        0x2::dynamic_field::remove<ApprovedDomainRegistrationKey<T1>, bool>(&mut arg0.id, v0);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::events::emit_revoke_domain_registration_approval_event(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
    }

    public fun set_description<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::authority::VENDOR<T0>, T1>, arg3: 0x1::ascii::String) {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg1);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_has_active_vendor_authority<T0, T1>(arg1, arg2);
        arg0.description = arg3;
    }

    public fun set_extra_field<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::authority::VENDOR<T0>, T1>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String) {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg1);
        assert!(!0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::is_restricted_key(arg1, &arg3), 1);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_has_active_vendor_authority<T0, T1>(arg1, arg2);
        let v0 = &mut arg0.extra_fields;
        if (!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v0, &arg3)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(v0, arg3, arg4);
        } else {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v0, &arg3) = arg4;
        };
    }

    public fun set_name<T0, T1>(arg0: &mut VendorMetadata<T0>, arg1: &0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::Config, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::authority::VENDOR<T0>, T1>, arg3: 0x1::ascii::String) {
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_package_version(arg1);
        0x40c958733d43750f9a36f72e2d7a327ef68ce52713f557702b1e784fd7bfa158::config::assert_has_active_vendor_authority<T0, T1>(arg1, arg2);
        arg0.name = arg3;
    }

    // decompiled from Move bytecode v7
}

