module 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::pool_vault {
    struct KraterionPoolVault has key {
        id: 0x2::object::UID,
        pool: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool,
        created_by: address,
        project_id: vector<u8>,
        platform_authorized: bool,
    }

    public fun id(arg0: &KraterionPoolVault) : &0x2::object::UID {
        &arg0.id
    }

    public fun anchor_session(arg0: &mut KraterionPoolVault, arg1: &0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg8);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_session_anchored(0x2::object::id<KraterionPoolVault>(arg0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::blob_object_id(&arg0.pool, arg2), arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::sender(arg8));
    }

    public fun certify_blob(arg0: &mut KraterionPoolVault, arg1: &0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u256, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg7);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_pooled_blob(arg2, &mut arg0.pool, arg3, arg4, arg5, arg6);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pooled_blob_certified(0x2::object::id<KraterionPoolVault>(arg0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::blob_object_id(&arg0.pool, arg3), arg3, 0x2::tx_context::sender(arg7));
    }

    public fun create_vault(arg0: &mut 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u64, arg3: u32, arg4: u64, arg5: address, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg0, arg7);
        let v0 = 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::pull_wal(arg0, arg4, arg7);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::create_storage_pool(arg1, arg2, arg3, &mut v0, arg7);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::deposit_wal(arg0, v0);
        let v2 = KraterionPoolVault{
            id                  : 0x2::object::new(arg7),
            pool                : v1,
            created_by          : arg5,
            project_id          : arg6,
            platform_authorized : true,
        };
        0x2::transfer::share_object<KraterionPoolVault>(v2);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_vault_created(0x2::object::id<KraterionPoolVault>(&v2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::object_id(&v1), arg5, v2.project_id, arg2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::start_epoch(&v1), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::end_epoch(&v1));
    }

    public fun created_by(arg0: &KraterionPoolVault) : address {
        arg0.created_by
    }

    public fun delete_blob(arg0: &mut KraterionPoolVault, arg1: &0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg4);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_pooled_blob(arg2, &mut arg0.pool, arg3);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pooled_blob_deleted(0x2::object::id<KraterionPoolVault>(arg0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::blob_object_id(&arg0.pool, arg3), arg3, 0x2::tx_context::sender(arg4));
    }

    public fun extend(arg0: &mut KraterionPoolVault, arg1: &mut 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg5);
        let v0 = 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::pull_wal(arg1, arg4, arg5);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_storage_pool(arg2, &mut arg0.pool, arg3, &mut v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::deposit_wal(arg1, v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pool_extended(0x2::object::id<KraterionPoolVault>(arg0), arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::end_epoch(&arg0.pool), 0x2::tx_context::sender(arg5));
    }

    public fun platform_authorized(arg0: &KraterionPoolVault) : bool {
        arg0.platform_authorized
    }

    public fun pool(arg0: &KraterionPoolVault) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool {
        &arg0.pool
    }

    public fun project_id(arg0: &KraterionPoolVault) : &vector<u8> {
        &arg0.project_id
    }

    public fun register_blob(arg0: &mut KraterionPoolVault, arg1: &mut 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg13);
        let v0 = 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::pull_wal(arg1, arg12, arg13);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_pooled_blob(arg2, &mut arg0.pool, arg3, arg4, arg5, arg6, true, &mut v0, arg13);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::deposit_wal(arg1, v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pooled_blob_registered(0x2::object::id<KraterionPoolVault>(arg0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::blob_object_id(&arg0.pool, arg3), arg3, arg7, arg8, arg0.created_by, 0x2::tx_context::sender(arg13), arg9, arg10, arg11);
    }

    public fun resize_grow(arg0: &mut KraterionPoolVault, arg1: &mut 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg5);
        let v0 = 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::pull_wal(arg1, arg4, arg5);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::increase_storage_pool_capacity(arg2, &mut arg0.pool, arg3, &mut v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::deposit_wal(arg1, v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pool_resized_grow(0x2::object::id<KraterionPoolVault>(arg0), arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::reserved_encoded_capacity_bytes(&arg0.pool), 0x2::tx_context::sender(arg5));
    }

    public fun resize_shrink(arg0: &mut KraterionPoolVault, arg1: &mut 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::PlatformReserve, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_authorized, 1);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve::assert_caller_authorized(arg1, arg4);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::destroy(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::decrease_storage_pool_unused_capacity_by_percent(arg2, &mut arg0.pool, arg3, arg4));
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_pool_resized_shrink(0x2::object::id<KraterionPoolVault>(arg0), arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::reserved_encoded_capacity_bytes(&arg0.pool), 0x2::tx_context::sender(arg4));
    }

    public fun revoke_all(arg0: &mut KraterionPoolVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.created_by, 0);
        if (arg0.platform_authorized) {
            arg0.platform_authorized = false;
            0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_vault_revoked(0x2::object::id<KraterionPoolVault>(arg0), arg0.created_by);
        };
    }

    // decompiled from Move bytecode v7
}

