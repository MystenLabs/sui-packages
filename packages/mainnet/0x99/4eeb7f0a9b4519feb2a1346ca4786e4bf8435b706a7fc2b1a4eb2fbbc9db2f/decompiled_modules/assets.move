module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets {
    struct AssetSlot has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        is_public: bool,
        deleted: bool,
        asset_type: u8,
        created_at_ms: u64,
    }

    struct SoulAssets has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        assets: 0x2::table::Table<0x1::string::String, vector<AssetSlot>>,
        asset_count: u64,
    }

    struct AssetBlobKey has copy, drop, store {
        asset_name: 0x1::string::String,
        version_index: u64,
    }

    struct SoulAssetsCreated has copy, drop {
        assets_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct AssetVersionAppended has copy, drop {
        assets_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        asset_name: 0x1::string::String,
        version_index: u64,
        is_public: bool,
        asset_type: u8,
        created_at_ms: u64,
        blob_object_id: 0x2::object::ID,
    }

    struct AssetVersionDeleted has copy, drop {
        assets_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        asset_name: 0x1::string::String,
        version_index: u64,
        deleted_by: address,
    }

    public(friend) fun append_initial_version(arg0: &mut SoulAssets, arg1: 0x1::string::String, arg2: bool, arg3: u8, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        append_version_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun append_version_as_granted_agent(arg0: &mut SoulAssets, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg3: 0x1::string::String, arg4: bool, arg5: u8, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_assets_matches_state(arg0, arg1);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg2, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_assets(), arg7, arg8);
        append_version_impl(arg0, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun append_version_as_owner(arg0: &mut SoulAssets, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: bool, arg4: u8, arg5: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_assets_matches_state(arg0, arg1);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg7));
        append_version_impl(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun append_version_impl(arg0: &mut SoulAssets, arg1: 0x1::string::String, arg2: bool, arg3: u8, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x1::string::is_empty(&arg1), 5);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&arg4);
        let v2 = AssetSlot{
            blob_object_id : v1,
            is_public      : arg2,
            deleted        : false,
            asset_type     : arg3,
            created_at_ms  : v0,
        };
        let v3 = if (0x2::table::contains<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1)) {
            let v4 = 0x2::table::borrow_mut<0x1::string::String, vector<AssetSlot>>(&mut arg0.assets, arg1);
            0x1::vector::push_back<AssetSlot>(v4, v2);
            0x1::vector::length<AssetSlot>(v4)
        } else {
            let v5 = 0x1::vector::empty<AssetSlot>();
            0x1::vector::push_back<AssetSlot>(&mut v5, v2);
            0x2::table::add<0x1::string::String, vector<AssetSlot>>(&mut arg0.assets, arg1, v5);
            arg0.asset_count = arg0.asset_count + 1;
            0
        };
        let v6 = AssetBlobKey{
            asset_name    : arg1,
            version_index : v3,
        };
        0x2::dynamic_object_field::add<AssetBlobKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.id, v6, arg4);
        let v7 = AssetVersionAppended{
            assets_id      : 0x2::object::id<SoulAssets>(arg0),
            soul_id        : arg0.soul_id,
            asset_name     : arg1,
            version_index  : v3,
            is_public      : arg2,
            asset_type     : arg3,
            created_at_ms  : v0,
            blob_object_id : v1,
        };
        0x2::event::emit<AssetVersionAppended>(v7);
        v3
    }

    fun assert_assets_matches_state(arg0: &SoulAssets, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState) {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 1);
    }

    fun assert_matching_document_id(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        let v0 = b"soul-asset:";
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0x1::string::as_bytes(&arg2);
        let v3 = 0x1::vector::length<u8>(v2);
        let v4 = 0x2::object::id_to_bytes(&arg1);
        let v5 = 0x1::vector::length<u8>(&v4);
        assert!(0x1::vector::length<u8>(&arg0) == v1 + 1 + v5 + v3 + 1 + 8 + 16, 6);
        let v6 = 0;
        while (v6 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v6) == *0x1::vector::borrow<u8>(&v0, v6), 1);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v1) == 1, 1);
        let v7 = v1 + 1;
        v6 = 0;
        while (v6 < v5) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v7 + v6) == *0x1::vector::borrow<u8>(&v4, v6), 1);
            v6 = v6 + 1;
        };
        let v8 = v7 + v5;
        v6 = 0;
        while (v6 < v3) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v8 + v6) == *0x1::vector::borrow<u8>(v2, v6), 1);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v8 + v3) == 0, 1);
        assert_u64_segment(&arg0, v8 + v3 + 1, arg3);
    }

    fun assert_u64_segment(arg0: &vector<u8>, arg1: u64, arg2: u64) {
        let v0 = 56;
        let v1 = 0;
        while (v1 < 8) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v1) == ((arg2 >> v0 & 255) as u8), 1);
            let v2 = if (v0 >= 8) {
                v0 - 8
            } else {
                0
            };
            v0 = v2;
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_valid_asset_seal_request(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulAssets, arg3: 0x1::string::String, arg4: u64) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulAssets>(arg2), arg3, arg4);
        assert_assets_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
    }

    public fun asset_count(arg0: &SoulAssets) : u64 {
        arg0.asset_count
    }

    public fun assets_id(arg0: &SoulAssets) : 0x2::object::ID {
        0x2::object::id<SoulAssets>(arg0)
    }

    public fun blob_object_id_for(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : 0x2::object::ID {
        borrow_slot(arg0, arg1, arg2).blob_object_id
    }

    fun borrow_slot(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : &AssetSlot {
        assert!(0x2::table::contains<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1), 2);
        let v0 = 0x2::table::borrow<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1);
        assert!(arg2 < 0x1::vector::length<AssetSlot>(v0), 3);
        0x1::vector::borrow<AssetSlot>(v0, arg2)
    }

    fun borrow_slot_mut(arg0: &mut SoulAssets, arg1: 0x1::string::String, arg2: u64) : &mut AssetSlot {
        assert!(0x2::table::contains<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, vector<AssetSlot>>(&mut arg0.assets, arg1);
        assert!(arg2 < 0x1::vector::length<AssetSlot>(v0), 3);
        0x1::vector::borrow_mut<AssetSlot>(v0, arg2)
    }

    public fun contains_asset(arg0: &SoulAssets, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : SoulAssets {
        let v0 = SoulAssets{
            id          : 0x2::object::new(arg1),
            soul_id     : arg0,
            assets      : 0x2::table::new<0x1::string::String, vector<AssetSlot>>(arg1),
            asset_count : 0,
        };
        let v1 = SoulAssetsCreated{
            assets_id : 0x2::object::id<SoulAssets>(&v0),
            soul_id   : arg0,
        };
        0x2::event::emit<SoulAssetsCreated>(v1);
        v0
    }

    public fun delete_version_as_granted_agent(arg0: &mut SoulAssets, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg3: 0x1::string::String, arg4: u64, arg5: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_assets_matches_state(arg0, arg2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::assert_matches_state(arg1, arg2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg2, arg5, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_assets(), arg6, arg7);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::assert_asset_version_not_active(arg1, arg3, arg4);
        let v0 = borrow_slot_mut(arg0, arg3, arg4);
        assert!(!v0.deleted, 4);
        v0.deleted = true;
        let v1 = AssetVersionDeleted{
            assets_id     : 0x2::object::id<SoulAssets>(arg0),
            soul_id       : arg0.soul_id,
            asset_name    : arg3,
            version_index : arg4,
            deleted_by    : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<AssetVersionDeleted>(v1);
    }

    public fun delete_version_as_owner(arg0: &mut SoulAssets, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_assets_matches_state(arg0, arg2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::assert_matches_state(arg1, arg2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg2, 0x2::tx_context::sender(arg5));
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::assert_asset_version_not_active(arg1, arg3, arg4);
        let v0 = borrow_slot_mut(arg0, arg3, arg4);
        assert!(!v0.deleted, 4);
        v0.deleted = true;
        let v1 = AssetVersionDeleted{
            assets_id     : 0x2::object::id<SoulAssets>(arg0),
            soul_id       : arg0.soul_id,
            asset_name    : arg3,
            version_index : arg4,
            deleted_by    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AssetVersionDeleted>(v1);
    }

    entry fun seal_approve_asset_read_granted_agent(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulAssets, arg3: 0x1::string::String, arg4: u64, arg5: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulAssets>(arg2), arg3, arg4);
        assert_assets_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg5, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_assets(), arg6, arg7);
    }

    entry fun seal_approve_asset_read_owner(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &SoulAssets, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_matching_document_id(arg0, 0x2::object::id<SoulAssets>(arg2), arg3, arg4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg5));
        assert_assets_matches_state(arg2, arg1);
        assert!(!borrow_slot(arg2, arg3, arg4).deleted, 4);
    }

    public(friend) fun share_assets(arg0: SoulAssets) {
        0x2::transfer::share_object<SoulAssets>(arg0);
    }

    public fun soul_id(arg0: &SoulAssets) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun version_asset_type(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : u8 {
        borrow_slot(arg0, arg1, arg2).asset_type
    }

    public fun version_count(arg0: &SoulAssets, arg1: 0x1::string::String) : u64 {
        if (!0x2::table::contains<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1)) {
            return 0
        };
        0x1::vector::length<AssetSlot>(0x2::table::borrow<0x1::string::String, vector<AssetSlot>>(&arg0.assets, arg1))
    }

    public fun version_created_at_ms(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : u64 {
        borrow_slot(arg0, arg1, arg2).created_at_ms
    }

    public fun version_is_deleted(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : bool {
        borrow_slot(arg0, arg1, arg2).deleted
    }

    public fun version_is_public(arg0: &SoulAssets, arg1: 0x1::string::String, arg2: u64) : bool {
        borrow_slot(arg0, arg1, arg2).is_public
    }

    // decompiled from Move bytecode v7
}

