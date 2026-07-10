module 0x3dd2f9b8bfccb909e142b2fdbe719f119eae309dcbbfa74123aa1b62e6bcef03::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct ApproveDomainRegistrationEventV1 has copy, drop {
        vendor_key: 0x1::ascii::String,
        domain: 0x1::ascii::String,
    }

    struct RevokeDomainRegistrationApprovalEventV1 has copy, drop {
        vendor_key: 0x1::ascii::String,
        domain: 0x1::ascii::String,
    }

    struct CreatePackageRevokeVendorGuardianCapEventV1 has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct DeauthorizePackageRevokeVendorGuardianCapEventV1 has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct GuardianRevokeVendorAuthorityCapEventV1 has copy, drop {
        vendor_key: 0x1::ascii::String,
        role: 0x1::ascii::String,
        cap_id: 0x2::object::ID,
    }

    struct ReauthorizeVendorAdminCapEventV1 has copy, drop {
        vendor_key: 0x1::ascii::String,
        cap_id: 0x2::object::ID,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_approve_domain_registration_event(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = ApproveDomainRegistrationEventV1{
            vendor_key : 0x1::type_name::into_string(arg0),
            domain     : 0x1::type_name::into_string(arg1),
        };
        emit<ApproveDomainRegistrationEventV1>(v0);
    }

    public(friend) fun emit_create_package_revoke_vendor_guardian_cap_event(arg0: 0x2::object::ID) {
        let v0 = CreatePackageRevokeVendorGuardianCapEventV1{cap_id: arg0};
        emit<CreatePackageRevokeVendorGuardianCapEventV1>(v0);
    }

    public(friend) fun emit_deauthorize_package_revoke_vendor_guardian_cap_event(arg0: 0x2::object::ID) {
        let v0 = DeauthorizePackageRevokeVendorGuardianCapEventV1{cap_id: arg0};
        emit<DeauthorizePackageRevokeVendorGuardianCapEventV1>(v0);
    }

    public(friend) fun emit_guardian_revoke_vendor_authority_cap_event(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = GuardianRevokeVendorAuthorityCapEventV1{
            vendor_key : 0x1::type_name::into_string(arg0),
            role       : 0x1::type_name::into_string(arg1),
            cap_id     : arg2,
        };
        emit<GuardianRevokeVendorAuthorityCapEventV1>(v0);
    }

    public(friend) fun emit_reauthorize_vendor_admin_cap_event(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = ReauthorizeVendorAdminCapEventV1{
            vendor_key : 0x1::type_name::into_string(arg0),
            cap_id     : arg1,
        };
        emit<ReauthorizeVendorAdminCapEventV1>(v0);
    }

    public(friend) fun emit_revoke_domain_registration_approval_event(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = RevokeDomainRegistrationApprovalEventV1{
            vendor_key : 0x1::type_name::into_string(arg0),
            domain     : 0x1::type_name::into_string(arg1),
        };
        emit<RevokeDomainRegistrationApprovalEventV1>(v0);
    }

    // decompiled from Move bytecode v7
}

