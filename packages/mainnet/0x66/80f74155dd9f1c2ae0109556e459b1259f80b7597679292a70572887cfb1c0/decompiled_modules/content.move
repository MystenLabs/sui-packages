module 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::content {
    struct ContentKey has copy, drop, store {
        kind: u32,
        name: 0x1::string::String,
    }

    struct ContentBlobKey has copy, drop, store {
        kind: u32,
        name: 0x1::string::String,
        version_index: u64,
    }

    struct ContentSlot has copy, drop, store {
        version: u64,
        kind: u32,
        blob_object_id: 0x2::object::ID,
        is_public: bool,
        deleted: bool,
        purged: bool,
        download_policy: u8,
        grant_scope_mask: u64,
        read_mode_mask: u64,
        op_mask: u64,
        seal_encrypted: bool,
        created_at_ms: u64,
    }

    struct ActiveBinding has copy, drop, store {
        version: u64,
        kind: u32,
        name: 0x1::string::String,
        version_index: u64,
        download_policy: u8,
    }

    struct SoulContent has key {
        id: 0x2::object::UID,
        version: u64,
        soul_id: 0x2::object::ID,
        items: 0x2::table::Table<ContentKey, vector<ContentSlot>>,
        count_by_kind: 0x2::table::Table<u32, u64>,
        active: 0x2::table::Table<u32, ActiveBinding>,
    }

    struct SoulContentCreated has copy, drop {
        content_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct ContentVersionAppended has copy, drop {
        content_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        kind: u32,
        kind_name: 0x1::string::String,
        name: 0x1::string::String,
        version_index: u64,
        is_public: bool,
        download_policy: u8,
        grant_scope_mask: u64,
        read_mode_mask: u64,
        op_mask: u64,
        seal_encrypted: bool,
        blob_object_id: 0x2::object::ID,
        created_at_ms: u64,
    }

    struct ContentVersionDeleted has copy, drop {
        content_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        kind: u32,
        kind_name: 0x1::string::String,
        name: 0x1::string::String,
        version_index: u64,
        deleted_by: address,
    }

    struct ContentVersionPurged has copy, drop {
        content_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        kind: u32,
        kind_name: 0x1::string::String,
        name: 0x1::string::String,
        version_index: u64,
        purged_by: address,
    }

    struct ActiveBindingUpdated has copy, drop {
        content_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        kind: u32,
        kind_name: 0x1::string::String,
        binding: 0x1::option::Option<ActiveBinding>,
        updater: address,
    }

    public fun active_binding(arg0: &SoulContent, arg1: u32) : 0x1::option::Option<ActiveBinding> {
        if (!0x2::table::contains<u32, ActiveBinding>(&arg0.active, arg1)) {
            return 0x1::option::none<ActiveBinding>()
        };
        0x1::option::some<ActiveBinding>(*0x2::table::borrow<u32, ActiveBinding>(&arg0.active, arg1))
    }

    public fun active_binding_download_policy(arg0: &ActiveBinding) : u8 {
        arg0.download_policy
    }

    public fun active_binding_kind(arg0: &ActiveBinding) : u32 {
        arg0.kind
    }

    public fun active_binding_name(arg0: &ActiveBinding) : &0x1::string::String {
        &arg0.name
    }

    public fun active_binding_version(arg0: &ActiveBinding) : u64 {
        arg0.version
    }

    public fun active_binding_version_index(arg0: &ActiveBinding) : u64 {
        arg0.version_index
    }

    public(friend) fun append_initial_invariant_version(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0x2::clock::Clock) : u64 {
        if (arg2 == 0) {
            assert!(arg3 == soul_doc_name(), 23);
            let v0 = ContentKey{
                kind : arg2,
                name : arg3,
            };
            assert!(!0x2::table::contains<ContentKey, vector<ContentSlot>>(&arg0.items, v0), 21);
        } else {
            assert!(arg2 == 1, 24);
            assert!(arg3 == memory_name(), 22);
        };
        assert!(arg4 == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_owner() | 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_grant(), 19);
        append_version_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false)
    }

    public(friend) fun append_initial_user_version(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0x2::clock::Clock) : u64 {
        assert!(arg2 != 0, 23);
        assert!(arg2 != 1, 22);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_op_mask(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg1, arg2)) & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_append() != 0, 24);
        append_version_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false)
    }

    public fun append_version_as_granted_agent(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::SoulGrant, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: u8, arg8: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        assert_content_matches_state(arg0, arg1);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_active_with_scope(arg1, arg3, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_default_grant_scope_mask(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg4)), arg9, arg10);
        append_version_impl(arg0, arg2, arg4, arg5, arg6, arg7, arg8, arg9, true)
    }

    public fun append_version_as_owner(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: u8, arg7: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg1, 0x2::tx_context::sender(arg9));
        assert_content_matches_state(arg0, arg1);
        append_version_impl(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, true)
    }

    fun append_version_impl(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0x2::clock::Clock, arg8: bool) : u64 {
        assert_valid_content_name(&arg3);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::assert_kind_active(arg1, arg2);
        assert_canonical_name_for_kind(arg2, &arg3);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg1, arg2);
        if (arg8) {
            assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_op_mask(v0) & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_append() != 0, 18);
        };
        assert!(arg4 != 0, 25);
        assert!(arg4 & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_read_mode_mask(v0) == arg4, 19);
        assert!(arg4 & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_owner() != 0, 29);
        let v1 = arg4 & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_public() != 0;
        assert_valid_download_policy(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_requires_download_policy(v0), arg5);
        if (v1) {
            assert!(arg5 == 0, 26);
        };
        let v2 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_default_grant_scope_mask(v0);
        let v3 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_op_mask(v0);
        let v4 = true;
        let v5 = 0x2::clock::timestamp_ms(arg7);
        let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&arg6);
        let v7 = ContentSlot{
            version          : 1,
            kind             : arg2,
            blob_object_id   : v6,
            is_public        : v1,
            deleted          : false,
            purged           : false,
            download_policy  : arg5,
            grant_scope_mask : v2,
            read_mode_mask   : arg4,
            op_mask          : v3,
            seal_encrypted   : v4,
            created_at_ms    : v5,
        };
        let v8 = ContentKey{
            kind : arg2,
            name : arg3,
        };
        let v9 = if (0x2::table::contains<ContentKey, vector<ContentSlot>>(&arg0.items, v8)) {
            let v10 = 0x2::table::borrow_mut<ContentKey, vector<ContentSlot>>(&mut arg0.items, v8);
            0x1::vector::push_back<ContentSlot>(v10, v7);
            0x1::vector::length<ContentSlot>(v10)
        } else {
            let v11 = 0x1::vector::empty<ContentSlot>();
            0x1::vector::push_back<ContentSlot>(&mut v11, v7);
            0x2::table::add<ContentKey, vector<ContentSlot>>(&mut arg0.items, v8, v11);
            if (0x2::table::contains<u32, u64>(&arg0.count_by_kind, arg2)) {
                let v12 = 0x2::table::borrow_mut<u32, u64>(&mut arg0.count_by_kind, arg2);
                *v12 = *v12 + 1;
            } else {
                0x2::table::add<u32, u64>(&mut arg0.count_by_kind, arg2, 1);
            };
            0
        };
        let v13 = ContentBlobKey{
            kind          : arg2,
            name          : arg3,
            version_index : v9,
        };
        0x2::dynamic_object_field::add<ContentBlobKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.id, v13, arg6);
        let v14 = ContentVersionAppended{
            content_id       : 0x2::object::id<SoulContent>(arg0),
            soul_id          : arg0.soul_id,
            kind             : arg2,
            kind_name        : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(v0),
            name             : arg3,
            version_index    : v9,
            is_public        : v1,
            download_policy  : arg5,
            grant_scope_mask : v2,
            read_mode_mask   : arg4,
            op_mask          : v3,
            seal_encrypted   : v4,
            blob_object_id   : v6,
            created_at_ms    : v5,
        };
        0x2::event::emit<ContentVersionAppended>(v14);
        v9
    }

    fun assert_canonical_name_for_kind(arg0: u32, arg1: &0x1::string::String) {
        if (arg0 == 0) {
            let v0 = soul_doc_name();
            assert!(arg1 == &v0, 23);
        } else if (arg0 == 1) {
            let v1 = memory_name();
            assert!(arg1 == &v1, 22);
        };
    }

    fun assert_content_matches_state(arg0: &SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState) {
        assert!(arg0.soul_id == 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::soul_id(arg1), 3);
        let v0 = 0x2::object::id<SoulContent>(arg0);
        assert!(0x1::option::contains<0x2::object::ID>(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::content_id(arg1), &v0), 3);
    }

    public(friend) fun assert_initial_content_complete(arg0: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg1: &SoulContent) {
        assert_content_matches_state(arg1, arg0);
        assert!(version_count(arg1, 0, soul_doc_name()) == 1, 27);
        assert!(version_count(arg1, 1, memory_name()) >= 1, 28);
    }

    fun assert_matching_document_id(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u32, arg3: 0x1::string::String, arg4: u64) {
        let v0 = b"soul-content:";
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 == 13, 8);
        let v2 = 0x2::object::id_to_bytes(&arg1);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(v3 == 32, 8);
        let v4 = 0x1::string::as_bytes(&arg3);
        let v5 = 0x1::vector::length<u8>(v4);
        assert!(0x1::vector::length<u8>(&arg0) == v1 + 1 + 4 + v3 + v5 + 1 + 8 + 16, 8);
        let v6 = 0;
        while (v6 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v6) == *0x1::vector::borrow<u8>(&v0, v6), 9);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v1) == 1, 9);
        let v7 = v1 + 1;
        assert_u32_segment(&arg0, v7, arg2);
        let v8 = v7 + 4;
        v6 = 0;
        while (v6 < v3) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v8 + v6) == *0x1::vector::borrow<u8>(&v2, v6), 9);
            v6 = v6 + 1;
        };
        let v9 = v8 + v3;
        v6 = 0;
        while (v6 < v5) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v9 + v6) == *0x1::vector::borrow<u8>(v4, v6), 9);
            v6 = v6 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v9 + v5) == 0, 9);
        assert_u64_segment(&arg0, v9 + v5 + 1, arg4);
    }

    fun assert_slot_op_allowed(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        assert!(borrow_slot(arg0, arg1, arg2, arg3).op_mask & arg4 != 0, 18);
    }

    public(friend) fun assert_slot_paid_read_allowed(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) {
        assert!(borrow_slot(arg0, arg1, arg2, arg3).read_mode_mask & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_paid() != 0, 19);
    }

    fun assert_u32_segment(arg0: &vector<u8>, arg1: u64, arg2: u32) {
        let v0 = 24;
        let v1 = 0;
        while (v1 < 4) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v1) == ((arg2 >> v0 & 255) as u8), 9);
            let v2 = if (v0 >= 8) {
                v0 - 8
            } else {
                0
            };
            v0 = v2;
            v1 = v1 + 1;
        };
    }

    fun assert_u64_segment(arg0: &vector<u8>, arg1: u64, arg2: u64) {
        let v0 = 56;
        let v1 = 0;
        while (v1 < 8) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v1) == ((arg2 >> v0 & 255) as u8), 9);
            let v2 = if (v0 >= 8) {
                v0 - 8
            } else {
                0
            };
            v0 = v2;
            v1 = v1 + 1;
        };
    }

    fun assert_valid_content_name(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        assert!(v1 >= 1 && v1 <= 32, 12);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = v3 >= 97 && v3 <= 122;
            let v5 = v3 >= 48 && v3 <= 57;
            let v6 = if (v4) {
                true
            } else if (v5) {
                true
            } else if (v3 == 95) {
                true
            } else {
                v3 == 45
            };
            assert!(v6, 13);
            v2 = v2 + 1;
        };
    }

    public(friend) fun assert_valid_content_seal_request(arg0: vector<u8>, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &SoulContent, arg3: u32, arg4: 0x1::string::String, arg5: u64) : u64 {
        assert_content_matches_state(arg2, arg1);
        assert_canonical_name_for_kind(arg3, &arg4);
        assert_matching_document_id(arg0, 0x2::object::id<SoulContent>(arg2), arg3, arg4, arg5);
        let v0 = borrow_slot(arg2, arg3, arg4, arg5);
        assert!(!v0.deleted, 6);
        assert!(!v0.purged, 7);
        v0.grant_scope_mask
    }

    fun assert_valid_download_policy(arg0: bool, arg1: u8) {
        if (arg0) {
            let v0 = if (arg1 == 0) {
                true
            } else if (arg1 == 1) {
                true
            } else {
                arg1 == 2
            };
            assert!(v0, 11);
        } else {
            assert!(arg1 == 0, 10);
        };
    }

    public fun assert_version_not_active(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) {
        assert!(!is_version_active(arg0, arg1, arg2, arg3), 15);
    }

    public fun blob_object_id_for(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : 0x2::object::ID {
        borrow_slot(arg0, arg1, arg2, arg3).blob_object_id
    }

    public fun borrow_slot(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : &ContentSlot {
        let v0 = ContentKey{
            kind : arg1,
            name : arg2,
        };
        assert!(0x2::table::contains<ContentKey, vector<ContentSlot>>(&arg0.items, v0), 4);
        let v1 = 0x2::table::borrow<ContentKey, vector<ContentSlot>>(&arg0.items, v0);
        assert!(arg3 < 0x1::vector::length<ContentSlot>(v1), 5);
        0x1::vector::borrow<ContentSlot>(v1, arg3)
    }

    public(friend) fun clear_active(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        assert_content_matches_state(arg0, arg1);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg3);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_has_active_binding(v0), 14);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_op_mask(v0) & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_active_bind() != 0, 18);
        if (0x2::table::contains<u32, ActiveBinding>(&arg0.active, arg3)) {
            0x2::table::remove<u32, ActiveBinding>(&mut arg0.active, arg3);
        };
        let v1 = ActiveBindingUpdated{
            content_id : 0x2::object::id<SoulContent>(arg0),
            soul_id    : arg0.soul_id,
            kind       : arg3,
            kind_name  : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(v0),
            binding    : 0x1::option::none<ActiveBinding>(),
            updater    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ActiveBindingUpdated>(v1);
    }

    public fun content_id(arg0: &SoulContent) : 0x2::object::ID {
        0x2::object::id<SoulContent>(arg0)
    }

    public fun content_version(arg0: &SoulContent) : u64 {
        arg0.version
    }

    public fun count_for_kind(arg0: &SoulContent, arg1: u32) : u64 {
        if (!0x2::table::contains<u32, u64>(&arg0.count_by_kind, arg1)) {
            return 0
        };
        *0x2::table::borrow<u32, u64>(&arg0.count_by_kind, arg1)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : SoulContent {
        let v0 = SoulContent{
            id            : 0x2::object::new(arg1),
            version       : 1,
            soul_id       : arg0,
            items         : 0x2::table::new<ContentKey, vector<ContentSlot>>(arg1),
            count_by_kind : 0x2::table::new<u32, u64>(arg1),
            active        : 0x2::table::new<u32, ActiveBinding>(arg1),
        };
        let v1 = SoulContentCreated{
            content_id : 0x2::object::id<SoulContent>(&v0),
            soul_id    : arg0,
        };
        0x2::event::emit<SoulContentCreated>(v1);
        v0
    }

    public fun delete_version_as_granted_agent(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::SoulGrant, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_content_matches_state(arg0, arg1);
        assert_canonical_name_for_kind(arg4, &arg5);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg4);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_active_with_scope(arg1, arg3, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_default_grant_scope_mask(v0), arg7, arg8);
        assert_slot_op_allowed(arg0, arg4, arg5, arg6, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_delete());
        if (0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_has_active_binding(v0)) {
            assert_version_not_active(arg0, arg4, arg5, arg6);
        };
        mark_slot_deleted(arg0, arg4, arg5, arg6, arg8, *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(v0));
    }

    public fun delete_version_as_owner(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg1, 0x2::tx_context::sender(arg6));
        assert_content_matches_state(arg0, arg1);
        assert_canonical_name_for_kind(arg3, &arg4);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg3);
        assert_slot_op_allowed(arg0, arg3, arg4, arg5, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_delete());
        if (0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_has_active_binding(v0)) {
            assert_version_not_active(arg0, arg3, arg4, arg5);
        };
        mark_slot_deleted(arg0, arg3, arg4, arg5, arg6, *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(v0));
    }

    public fun download_policy_allowlist() : u8 {
        2
    }

    public fun download_policy_owner_only() : u8 {
        1
    }

    public fun download_policy_public() : u8 {
        0
    }

    public fun has_active(arg0: &SoulContent, arg1: u32) : bool {
        0x2::table::contains<u32, ActiveBinding>(&arg0.active, arg1)
    }

    public fun is_version_active(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : bool {
        if (!0x2::table::contains<u32, ActiveBinding>(&arg0.active, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u32, ActiveBinding>(&arg0.active, arg1);
        v0.name == arg2 && v0.version_index == arg3
    }

    fun mark_slot_deleted(arg0: &mut SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext, arg5: 0x1::string::String) {
        let v0 = ContentKey{
            kind : arg1,
            name : arg2,
        };
        assert!(0x2::table::contains<ContentKey, vector<ContentSlot>>(&arg0.items, v0), 4);
        let v1 = 0x2::table::borrow_mut<ContentKey, vector<ContentSlot>>(&mut arg0.items, v0);
        assert!(arg3 < 0x1::vector::length<ContentSlot>(v1), 5);
        let v2 = 0x1::vector::borrow_mut<ContentSlot>(v1, arg3);
        assert!(!v2.deleted, 6);
        v2.deleted = true;
        let v3 = ContentVersionDeleted{
            content_id    : 0x2::object::id<SoulContent>(arg0),
            soul_id       : arg0.soul_id,
            kind          : arg1,
            kind_name     : arg5,
            name          : arg2,
            version_index : arg3,
            deleted_by    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ContentVersionDeleted>(v3);
    }

    public fun memory_name() : 0x1::string::String {
        0x1::string::utf8(b"default")
    }

    fun new_active_binding(arg0: u32, arg1: 0x1::string::String, arg2: u64, arg3: u8) : ActiveBinding {
        ActiveBinding{
            version         : 1,
            kind            : arg0,
            name            : arg1,
            version_index   : arg2,
            download_policy : arg3,
        }
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun purge_deleted_version_as_owner(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg1, 0x2::tx_context::sender(arg6));
        assert_content_matches_state(arg0, arg1);
        assert_canonical_name_for_kind(arg3, &arg4);
        assert_slot_op_allowed(arg0, arg3, arg4, arg5, 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_purge());
        let v0 = borrow_slot(arg0, arg3, arg4, arg5);
        assert!(v0.deleted, 16);
        assert!(!v0.purged, 7);
        let v1 = ContentBlobKey{
            kind          : arg3,
            name          : arg4,
            version_index : arg5,
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(0x2::dynamic_object_field::remove<ContentBlobKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.id, v1));
        let v2 = ContentKey{
            kind : arg3,
            name : arg4,
        };
        0x1::vector::borrow_mut<ContentSlot>(0x2::table::borrow_mut<ContentKey, vector<ContentSlot>>(&mut arg0.items, v2), arg5).purged = true;
        let v3 = ContentVersionPurged{
            content_id    : 0x2::object::id<SoulContent>(arg0),
            soul_id       : arg0.soul_id,
            kind          : arg3,
            kind_name     : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg3)),
            name          : arg4,
            version_index : arg5,
            purged_by     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ContentVersionPurged>(v3);
    }

    public fun seal_approve_content_granted_agent(arg0: vector<u8>, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &SoulContent, arg3: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::SoulGrant, arg4: u32, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_content_matches_state(arg2, arg1);
        assert_canonical_name_for_kind(arg4, &arg5);
        assert_matching_document_id(arg0, 0x2::object::id<SoulContent>(arg2), arg4, arg5, arg6);
        let v0 = borrow_slot(arg2, arg4, arg5, arg6);
        assert!(!v0.deleted, 6);
        assert!(!v0.purged, 7);
        assert!(v0.read_mode_mask & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_grant() != 0, 19);
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::grant::assert_active_with_scope(arg1, arg3, v0.grant_scope_mask, arg7, arg8);
    }

    public fun seal_approve_content_owner(arg0: vector<u8>, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &SoulContent, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::assert_owner(arg1, 0x2::tx_context::sender(arg6));
        assert_content_matches_state(arg2, arg1);
        assert_canonical_name_for_kind(arg3, &arg4);
        assert_matching_document_id(arg0, 0x2::object::id<SoulContent>(arg2), arg3, arg4, arg5);
        let v0 = borrow_slot(arg2, arg3, arg4, arg5);
        assert!(!v0.deleted, 6);
        assert!(!v0.purged, 7);
        assert!(v0.read_mode_mask & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_owner() != 0, 19);
    }

    public fun seal_approve_content_public(arg0: vector<u8>, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &SoulContent, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_content_matches_state(arg2, arg1);
        assert_canonical_name_for_kind(arg3, &arg4);
        assert_matching_document_id(arg0, 0x2::object::id<SoulContent>(arg2), arg3, arg4, arg5);
        let v0 = borrow_slot(arg2, arg3, arg4, arg5);
        assert!(!v0.deleted, 6);
        assert!(!v0.purged, 7);
        assert!(v0.read_mode_mask & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::read_public() != 0, 19);
        assert!(v0.seal_encrypted, 20);
    }

    public(friend) fun set_active(arg0: &mut SoulContent, arg1: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::soul::SoulState, arg2: &0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::KindRegistry, arg3: u32, arg4: 0x1::string::String, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert_content_matches_state(arg0, arg1);
        let v0 = 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::borrow_descriptor(arg2, arg3);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_has_active_binding(v0), 14);
        assert!(0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_op_mask(v0) & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_active_bind() != 0, 18);
        let v1 = borrow_slot(arg0, arg3, arg4, arg5);
        assert!(!v1.deleted, 6);
        assert!(!v1.purged, 7);
        assert!(v1.op_mask & 0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::op_active_bind() != 0, 18);
        let v2 = new_active_binding(arg3, arg4, arg5, v1.download_policy);
        if (0x2::table::contains<u32, ActiveBinding>(&arg0.active, arg3)) {
            *0x2::table::borrow_mut<u32, ActiveBinding>(&mut arg0.active, arg3) = v2;
        } else {
            0x2::table::add<u32, ActiveBinding>(&mut arg0.active, arg3, v2);
        };
        let v3 = ActiveBindingUpdated{
            content_id : 0x2::object::id<SoulContent>(arg0),
            soul_id    : arg0.soul_id,
            kind       : arg3,
            kind_name  : *0x6680f74155dd9f1c2ae0109556e459b1259f80b7597679292a70572887cfb1c0::kind_registry::descriptor_name(v0),
            binding    : 0x1::option::some<ActiveBinding>(v2),
            updater    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ActiveBindingUpdated>(v3);
    }

    public(friend) fun share_content(arg0: SoulContent) {
        0x2::transfer::share_object<SoulContent>(arg0);
    }

    public fun slot_blob_object_id(arg0: &ContentSlot) : 0x2::object::ID {
        arg0.blob_object_id
    }

    public fun slot_created_at_ms(arg0: &ContentSlot) : u64 {
        arg0.created_at_ms
    }

    public fun slot_deleted(arg0: &ContentSlot) : bool {
        arg0.deleted
    }

    public fun slot_download_policy(arg0: &ContentSlot) : u8 {
        arg0.download_policy
    }

    public fun slot_grant_scope_mask(arg0: &ContentSlot) : u64 {
        arg0.grant_scope_mask
    }

    public fun slot_is_public(arg0: &ContentSlot) : bool {
        arg0.is_public
    }

    public fun slot_kind(arg0: &ContentSlot) : u32 {
        arg0.kind
    }

    public fun slot_op_mask(arg0: &ContentSlot) : u64 {
        arg0.op_mask
    }

    public fun slot_purged(arg0: &ContentSlot) : bool {
        arg0.purged
    }

    public fun slot_read_mode_mask(arg0: &ContentSlot) : u64 {
        arg0.read_mode_mask
    }

    public fun slot_seal_encrypted(arg0: &ContentSlot) : bool {
        arg0.seal_encrypted
    }

    public fun slot_version(arg0: &ContentSlot) : u64 {
        arg0.version
    }

    public fun soul_doc_name() : 0x1::string::String {
        0x1::string::utf8(b"soul")
    }

    public fun soul_id(arg0: &SoulContent) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun version_count(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String) : u64 {
        let v0 = ContentKey{
            kind : arg1,
            name : arg2,
        };
        if (!0x2::table::contains<ContentKey, vector<ContentSlot>>(&arg0.items, v0)) {
            return 0
        };
        0x1::vector::length<ContentSlot>(0x2::table::borrow<ContentKey, vector<ContentSlot>>(&arg0.items, v0))
    }

    public fun version_grant_scope_mask(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : u64 {
        borrow_slot(arg0, arg1, arg2, arg3).grant_scope_mask
    }

    public fun version_is_deleted(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : bool {
        borrow_slot(arg0, arg1, arg2, arg3).deleted
    }

    public fun version_is_public(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : bool {
        borrow_slot(arg0, arg1, arg2, arg3).is_public
    }

    public fun version_is_purged(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : bool {
        borrow_slot(arg0, arg1, arg2, arg3).purged
    }

    public fun version_read_mode_mask(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : u64 {
        borrow_slot(arg0, arg1, arg2, arg3).read_mode_mask
    }

    public fun version_seal_encrypted(arg0: &SoulContent, arg1: u32, arg2: 0x1::string::String, arg3: u64) : bool {
        borrow_slot(arg0, arg1, arg2, arg3).seal_encrypted
    }

    // decompiled from Move bytecode v7
}

