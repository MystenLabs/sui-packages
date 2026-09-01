module 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events {
    struct KraterionBucketCreated has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        name: vector<u8>,
        encryption_mode: u8,
    }

    struct ApiAccessGranted has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        granted_to: address,
    }

    struct ApiAccessRevoked has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
    }

    struct BucketVisibilityChanged has copy, drop {
        bucket_id: 0x2::object::ID,
        owner: address,
        old_mode: u8,
        new_mode: u8,
    }

    struct ReserveCreated has copy, drop {
        reserve_id: 0x2::object::ID,
        admin: address,
    }

    struct ReserveCallerAuthorized has copy, drop {
        reserve_id: 0x2::object::ID,
        admin: address,
        caller: address,
    }

    struct ReserveCallerDeauthorized has copy, drop {
        reserve_id: 0x2::object::ID,
        admin: address,
        caller: address,
    }

    struct ReserveFunded has copy, drop {
        reserve_id: 0x2::object::ID,
        amount: u64,
    }

    struct ReserveWithdrawn has copy, drop {
        reserve_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        amount: u64,
    }

    struct KraterionVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        created_by: address,
        project_id: vector<u8>,
        reserved_encoded_capacity_bytes: u64,
        start_epoch: u32,
        end_epoch: u32,
    }

    struct KraterionVaultRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        revoked_by: address,
    }

    struct KraterionPooledBlobRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        pooled_blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        s3_key: vector<u8>,
        content_type: vector<u8>,
        owner_address: address,
        registered_by: address,
        seal_identity: vector<u8>,
        size_bytes: u64,
        etag_md5: vector<u8>,
    }

    struct KraterionPooledBlobCertified has copy, drop {
        vault_id: 0x2::object::ID,
        pooled_blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        certified_by: address,
    }

    struct KraterionPooledBlobDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        pooled_blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        deleted_by: address,
    }

    struct KraterionPoolExtended has copy, drop {
        vault_id: 0x2::object::ID,
        extended_epochs: u32,
        new_end_epoch: u32,
        extended_by: address,
    }

    struct KraterionPoolResizedGrow has copy, drop {
        vault_id: 0x2::object::ID,
        additional_encoded_capacity_bytes: u64,
        new_reserved_encoded_capacity_bytes: u64,
        resized_by: address,
    }

    struct KraterionPoolResizedShrink has copy, drop {
        vault_id: 0x2::object::ID,
        percent_shrunk: u8,
        new_reserved_encoded_capacity_bytes: u64,
        resized_by: address,
    }

    struct KraterionSessionAnchored has copy, drop {
        vault_id: 0x2::object::ID,
        pooled_blob_object_id: 0x2::object::ID,
        walrus_blob_id: u256,
        seal_identity: vector<u8>,
        trace_hash: vector<u8>,
        session_id: vector<u8>,
        agent_id: vector<u8>,
        invocation_count: u32,
        anchored_by: address,
    }

    public(friend) fun emit_api_access_granted(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ApiAccessGranted{
            bucket_id  : arg0,
            owner      : arg1,
            granted_to : arg2,
        };
        0x2::event::emit<ApiAccessGranted>(v0);
    }

    public(friend) fun emit_api_access_revoked(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ApiAccessRevoked{
            bucket_id : arg0,
            owner     : arg1,
        };
        0x2::event::emit<ApiAccessRevoked>(v0);
    }

    public(friend) fun emit_bucket_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u8) {
        let v0 = KraterionBucketCreated{
            bucket_id       : arg0,
            owner           : arg1,
            name            : arg2,
            encryption_mode : arg3,
        };
        0x2::event::emit<KraterionBucketCreated>(v0);
    }

    public(friend) fun emit_bucket_visibility_changed(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u8) {
        let v0 = BucketVisibilityChanged{
            bucket_id : arg0,
            owner     : arg1,
            old_mode  : arg2,
            new_mode  : arg3,
        };
        0x2::event::emit<BucketVisibilityChanged>(v0);
    }

    public(friend) fun emit_pool_extended(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: address) {
        let v0 = KraterionPoolExtended{
            vault_id        : arg0,
            extended_epochs : arg1,
            new_end_epoch   : arg2,
            extended_by     : arg3,
        };
        0x2::event::emit<KraterionPoolExtended>(v0);
    }

    public(friend) fun emit_pool_resized_grow(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = KraterionPoolResizedGrow{
            vault_id                            : arg0,
            additional_encoded_capacity_bytes   : arg1,
            new_reserved_encoded_capacity_bytes : arg2,
            resized_by                          : arg3,
        };
        0x2::event::emit<KraterionPoolResizedGrow>(v0);
    }

    public(friend) fun emit_pool_resized_shrink(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address) {
        let v0 = KraterionPoolResizedShrink{
            vault_id                            : arg0,
            percent_shrunk                      : arg1,
            new_reserved_encoded_capacity_bytes : arg2,
            resized_by                          : arg3,
        };
        0x2::event::emit<KraterionPoolResizedShrink>(v0);
    }

    public(friend) fun emit_pooled_blob_certified(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: address) {
        let v0 = KraterionPooledBlobCertified{
            vault_id              : arg0,
            pooled_blob_object_id : arg1,
            walrus_blob_id        : arg2,
            certified_by          : arg3,
        };
        0x2::event::emit<KraterionPooledBlobCertified>(v0);
    }

    public(friend) fun emit_pooled_blob_deleted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: address) {
        let v0 = KraterionPooledBlobDeleted{
            vault_id              : arg0,
            pooled_blob_object_id : arg1,
            walrus_blob_id        : arg2,
            deleted_by            : arg3,
        };
        0x2::event::emit<KraterionPooledBlobDeleted>(v0);
    }

    public(friend) fun emit_pooled_blob_registered(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: address, arg7: vector<u8>, arg8: u64, arg9: vector<u8>) {
        let v0 = KraterionPooledBlobRegistered{
            vault_id              : arg0,
            pooled_blob_object_id : arg1,
            walrus_blob_id        : arg2,
            s3_key                : arg3,
            content_type          : arg4,
            owner_address         : arg5,
            registered_by         : arg6,
            seal_identity         : arg7,
            size_bytes            : arg8,
            etag_md5              : arg9,
        };
        0x2::event::emit<KraterionPooledBlobRegistered>(v0);
    }

    public(friend) fun emit_reserve_caller_authorized(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ReserveCallerAuthorized{
            reserve_id : arg0,
            admin      : arg1,
            caller     : arg2,
        };
        0x2::event::emit<ReserveCallerAuthorized>(v0);
    }

    public(friend) fun emit_reserve_caller_deauthorized(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = ReserveCallerDeauthorized{
            reserve_id : arg0,
            admin      : arg1,
            caller     : arg2,
        };
        0x2::event::emit<ReserveCallerDeauthorized>(v0);
    }

    public(friend) fun emit_reserve_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ReserveCreated{
            reserve_id : arg0,
            admin      : arg1,
        };
        0x2::event::emit<ReserveCreated>(v0);
    }

    public(friend) fun emit_reserve_funded(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ReserveFunded{
            reserve_id : arg0,
            amount     : arg1,
        };
        0x2::event::emit<ReserveFunded>(v0);
    }

    public(friend) fun emit_reserve_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = ReserveWithdrawn{
            reserve_id : arg0,
            admin      : arg1,
            recipient  : arg2,
            amount     : arg3,
        };
        0x2::event::emit<ReserveWithdrawn>(v0);
    }

    public(friend) fun emit_session_anchored(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: address) {
        let v0 = KraterionSessionAnchored{
            vault_id              : arg0,
            pooled_blob_object_id : arg1,
            walrus_blob_id        : arg2,
            seal_identity         : arg3,
            trace_hash            : arg4,
            session_id            : arg5,
            agent_id              : arg6,
            invocation_count      : arg7,
            anchored_by           : arg8,
        };
        0x2::event::emit<KraterionSessionAnchored>(v0);
    }

    public(friend) fun emit_vault_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: u32) {
        let v0 = KraterionVaultCreated{
            vault_id                        : arg0,
            pool_id                         : arg1,
            created_by                      : arg2,
            project_id                      : arg3,
            reserved_encoded_capacity_bytes : arg4,
            start_epoch                     : arg5,
            end_epoch                       : arg6,
        };
        0x2::event::emit<KraterionVaultCreated>(v0);
    }

    public(friend) fun emit_vault_revoked(arg0: 0x2::object::ID, arg1: address) {
        let v0 = KraterionVaultRevoked{
            vault_id   : arg0,
            revoked_by : arg1,
        };
        0x2::event::emit<KraterionVaultRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

