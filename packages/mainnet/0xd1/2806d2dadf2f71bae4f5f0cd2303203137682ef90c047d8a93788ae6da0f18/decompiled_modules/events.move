module 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::events {
    struct CreatedPriceFeedStorage has copy, drop {
        price_feed_storage_obj_id: 0x2::object::ID,
        storage_id: u32,
        symbol: 0x1::string::String,
    }

    struct CreatedSource has copy, drop {
        source_id: u16,
        source_object_id: 0x2::object::ID,
    }

    struct AddedAuthorization has copy, drop {
        source_id: u16,
    }

    struct RemovedAuthorization has copy, drop {
        source_id: u16,
    }

    struct CreatedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
        price: u128,
        timestamp_ms: u64,
    }

    struct RemovedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
    }

    struct UpdatedPriceFeed has copy, drop {
        storage_id: u32,
        source_id: u16,
        old_price: u128,
        old_timestamp_ms: u64,
        old_twap_price: u128,
        new_price: u128,
        new_timestamp_ms: u64,
        new_twap_price: u128,
    }

    struct UpdatedTwapPeriodMs has copy, drop {
        storage_id: u32,
        source_id: u16,
        old_twap_period_ms: u64,
        new_twap_period_ms: u64,
    }

    struct SetVendorRegistration has copy, drop {
        open: bool,
    }

    struct RegisteredVendor has copy, drop {
        vendor_key: 0x1::type_name::TypeName,
        vendor_admin_cap_id: 0x2::object::ID,
    }

    struct CreatedPackageRevokeVendorGuardianCap has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct GuardianRevokedVendorAuthorityCap has copy, drop {
        vendor_key: 0x1::type_name::TypeName,
        role: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct ReauthorizedVendorAdminCap has copy, drop {
        vendor_key: 0x1::type_name::TypeName,
        cap_id: 0x2::object::ID,
    }

    struct CreatedPackageFreezeGuardianCap has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct Froze has copy, drop {
        id: 0x2::object::ID,
        resume_version: u64,
        guardian_cap_id: 0x2::object::ID,
    }

    struct Unfroze has copy, drop {
        id: 0x2::object::ID,
        version: u64,
    }

    public(friend) fun emit_added_authorization(arg0: u16) {
        let v0 = AddedAuthorization{source_id: arg0};
        0x2::event::emit<AddedAuthorization>(v0);
    }

    public(friend) fun emit_created_package_freeze_guardian_cap(arg0: 0x2::object::ID) {
        let v0 = CreatedPackageFreezeGuardianCap{cap_id: arg0};
        0x2::event::emit<CreatedPackageFreezeGuardianCap>(v0);
    }

    public(friend) fun emit_created_package_revoke_vendor_guardian_cap(arg0: 0x2::object::ID) {
        let v0 = CreatedPackageRevokeVendorGuardianCap{cap_id: arg0};
        0x2::event::emit<CreatedPackageRevokeVendorGuardianCap>(v0);
    }

    public(friend) fun emit_created_price_feed(arg0: u32, arg1: u16, arg2: u128, arg3: u64) {
        let v0 = CreatedPriceFeed{
            storage_id   : arg0,
            source_id    : arg1,
            price        : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<CreatedPriceFeed>(v0);
    }

    public(friend) fun emit_created_price_feed_storage(arg0: 0x2::object::ID, arg1: u32, arg2: 0x1::string::String) {
        let v0 = CreatedPriceFeedStorage{
            price_feed_storage_obj_id : arg0,
            storage_id                : arg1,
            symbol                    : arg2,
        };
        0x2::event::emit<CreatedPriceFeedStorage>(v0);
    }

    public(friend) fun emit_created_source(arg0: u16, arg1: 0x2::object::ID) {
        let v0 = CreatedSource{
            source_id        : arg0,
            source_object_id : arg1,
        };
        0x2::event::emit<CreatedSource>(v0);
    }

    public(friend) fun emit_froze(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = Froze{
            id              : arg0,
            resume_version  : arg1,
            guardian_cap_id : arg2,
        };
        0x2::event::emit<Froze>(v0);
    }

    public(friend) fun emit_guardian_revoked_vendor_authority_cap(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = GuardianRevokedVendorAuthorityCap{
            vendor_key : arg0,
            role       : arg1,
            cap_id     : arg2,
        };
        0x2::event::emit<GuardianRevokedVendorAuthorityCap>(v0);
    }

    public(friend) fun emit_reauthorized_vendor_admin_cap(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = ReauthorizedVendorAdminCap{
            vendor_key : arg0,
            cap_id     : arg1,
        };
        0x2::event::emit<ReauthorizedVendorAdminCap>(v0);
    }

    public(friend) fun emit_registered_vendor(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID) {
        let v0 = RegisteredVendor{
            vendor_key          : arg0,
            vendor_admin_cap_id : arg1,
        };
        0x2::event::emit<RegisteredVendor>(v0);
    }

    public(friend) fun emit_removed_authorization(arg0: u16) {
        let v0 = RemovedAuthorization{source_id: arg0};
        0x2::event::emit<RemovedAuthorization>(v0);
    }

    public(friend) fun emit_removed_price_feed(arg0: u32, arg1: u16) {
        let v0 = RemovedPriceFeed{
            storage_id : arg0,
            source_id  : arg1,
        };
        0x2::event::emit<RemovedPriceFeed>(v0);
    }

    public(friend) fun emit_set_vendor_registration(arg0: bool) {
        let v0 = SetVendorRegistration{open: arg0};
        0x2::event::emit<SetVendorRegistration>(v0);
    }

    public(friend) fun emit_unfroze(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Unfroze{
            id      : arg0,
            version : arg1,
        };
        0x2::event::emit<Unfroze>(v0);
    }

    public(friend) fun emit_updated_price_feed(arg0: u32, arg1: u16, arg2: u128, arg3: u64, arg4: u128, arg5: u128, arg6: u64, arg7: u128) {
        let v0 = UpdatedPriceFeed{
            storage_id       : arg0,
            source_id        : arg1,
            old_price        : arg2,
            old_timestamp_ms : arg3,
            old_twap_price   : arg4,
            new_price        : arg5,
            new_timestamp_ms : arg6,
            new_twap_price   : arg7,
        };
        0x2::event::emit<UpdatedPriceFeed>(v0);
    }

    public(friend) fun emit_updated_twap_period_ms(arg0: u32, arg1: u16, arg2: u64, arg3: u64) {
        let v0 = UpdatedTwapPeriodMs{
            storage_id         : arg0,
            source_id          : arg1,
            old_twap_period_ms : arg2,
            new_twap_period_ms : arg3,
        };
        0x2::event::emit<UpdatedTwapPeriodMs>(v0);
    }

    // decompiled from Move bytecode v7
}

