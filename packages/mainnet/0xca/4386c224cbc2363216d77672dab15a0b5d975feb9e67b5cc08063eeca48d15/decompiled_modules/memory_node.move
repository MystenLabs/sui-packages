module 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::memory_node {
    struct MemoryNode has store, key {
        id: 0x2::object::UID,
        node_type: u8,
        namespace_id: 0x2::object::ID,
        dek_version: u64,
        created_at: u64,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NodeRecorded has copy, drop {
        namespace_id: 0x2::object::ID,
        node_id: 0x2::object::ID,
        node_type: u8,
        walrus_blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        dek_version: u64,
        storage_end_epoch: u32,
        sources: vector<0x2::object::ID>,
        by: address,
        principal: address,
    }

    struct NodeDeleted has copy, drop {
        namespace_id: 0x2::object::ID,
        node_id: 0x2::object::ID,
        walrus_blob_id: vector<u8>,
        storage_end_epoch: u32,
        by: address,
        principal: address,
    }

    struct NodeExtended has copy, drop {
        namespace_id: 0x2::object::ID,
        node_id: 0x2::object::ID,
        walrus_blob_id: vector<u8>,
        previous_storage_end_epoch: u32,
        new_storage_end_epoch: u32,
        by: address,
        principal: address,
    }

    struct NodeMetadataUpdated has copy, drop {
        namespace_id: 0x2::object::ID,
        node_id: 0x2::object::ID,
        key: 0x1::string::String,
        value: 0x1::string::String,
        by: address,
        principal: address,
    }

    struct BlobMetadataUpdated has copy, drop {
        namespace_id: 0x2::object::ID,
        node_id: 0x2::object::ID,
        walrus_blob_id: vector<u8>,
        key: 0x1::string::String,
        value: 0x1::string::String,
        by: address,
        principal: address,
    }

    entry fun delete(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: MemoryNode, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg4: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg5: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg1.id);
        assert!(arg1.namespace_id == 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg3), 300);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_write(arg0, arg2, arg3, arg4, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::dynamic_object_field::remove<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg1.id, b"blob");
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(v0);
        let MemoryNode {
            id           : v2,
            node_type    : _,
            namespace_id : v4,
            dek_version  : _,
            created_at   : _,
            metadata     : _,
        } = arg1;
        let v8 = NodeDeleted{
            namespace_id      : v4,
            node_id           : 0x2::object::id<MemoryNode>(&arg1),
            walrus_blob_id    : 0x2::bcs::to_bytes<u256>(&v1),
            storage_end_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&v0),
            by                : 0x2::tx_context::sender(arg5),
            principal         : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg2),
        };
        0x2::event::emit<NodeDeleted>(v8);
        0x2::object::delete(v2);
    }

    public fun created_at(arg0: &MemoryNode) : u64 {
        arg0.created_at
    }

    public fun dek_version(arg0: &MemoryNode) : u64 {
        arg0.dek_version
    }

    entry fun extend(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: &mut MemoryNode, arg5: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg7: u32, arg8: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg4.id);
        assert!(arg4.namespace_id == 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg2), 300);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_extend(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg8));
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg4.id, b"blob");
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(v0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg5, v0, arg7, arg6);
        let v2 = NodeExtended{
            namespace_id               : 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg2),
            node_id                    : 0x2::object::id<MemoryNode>(arg4),
            walrus_blob_id             : 0x2::bcs::to_bytes<u256>(&v1),
            previous_storage_end_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v0),
            new_storage_end_epoch      : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v0),
            by                         : 0x2::tx_context::sender(arg8),
            principal                  : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg1),
        };
        0x2::event::emit<NodeExtended>(v2);
    }

    fun has_prefix(arg0: &0x1::string::String, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        if (0x1::vector::length<u8>(v0) < v1) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(v0, v2) != *0x1::vector::borrow<u8>(&arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_write_once_blob_key(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::utf8(b"wmb_node_id");
        if (arg0 == &v0) {
            true
        } else {
            let v2 = 0x1::string::utf8(b"wmb_namespace_id");
            arg0 == &v2
        }
    }

    public fun metadata(arg0: &MemoryNode) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.metadata
    }

    entry fun migrate_v1_record(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::MigrationCap, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_migration_open(arg1);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_v1_recordable(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg5);
        mint(arg2, arg3, 0, 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::current_dek_version(arg2), 0x1::vector::empty<0x2::object::ID>(), arg4, v0, 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::owner(arg2), arg5);
    }

    entry fun migrate_v1_update_metadata(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::MigrationCap, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: &mut MemoryNode, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg1, &arg3.id);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_migration_open(arg1);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_migrated_v1(arg2);
        assert!(arg3.namespace_id == 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg2), 300);
        assert!(has_prefix(&arg4, b"wmn_"), 303);
        let v0 = NodeMetadataUpdated{
            namespace_id : arg3.namespace_id,
            node_id      : 0x2::object::id<MemoryNode>(arg3),
            key          : arg4,
            value        : arg5,
            by           : 0x2::tx_context::sender(arg6),
            principal    : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::owner(arg2),
        };
        0x2::event::emit<NodeMetadataUpdated>(v0);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg3.metadata, &arg4)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg3.metadata, &arg4);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg3.metadata, arg4, arg5);
    }

    fun mint(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: u8, arg3: u64, arg4: vector<0x2::object::ID>, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg1);
        let v1 = MemoryNode{
            id           : 0x2::object::new(arg8),
            node_type    : arg2,
            namespace_id : 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg0),
            dek_version  : arg3,
            created_at   : arg5,
            metadata     : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stamp(&mut v1.id);
        let v2 = NodeRecorded{
            namespace_id      : v1.namespace_id,
            node_id           : 0x2::object::id<MemoryNode>(&v1),
            node_type         : v1.node_type,
            walrus_blob_id    : 0x2::bcs::to_bytes<u256>(&v0),
            blob_object_id    : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg1),
            dek_version       : v1.dek_version,
            storage_end_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg1),
            sources           : arg4,
            by                : arg6,
            principal         : arg7,
        };
        0x2::event::emit<NodeRecorded>(v2);
        let v3 = 0x2::object::id<MemoryNode>(&v1);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::insert_or_update_metadata_pair(&mut arg1, 0x1::string::utf8(b"wmb_node_id"), 0x2::address::to_string(0x2::object::id_to_address(&v3)));
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::insert_or_update_metadata_pair(&mut arg1, 0x1::string::utf8(b"wmb_namespace_id"), 0x2::address::to_string(0x2::object::id_to_address(&v1.namespace_id)));
        0x2::dynamic_object_field::add<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut v1.id, b"blob", arg1);
        0x2::transfer::share_object<MemoryNode>(v1);
    }

    public fun namespace_id(arg0: &MemoryNode) : 0x2::object::ID {
        arg0.namespace_id
    }

    public fun node_type(arg0: &MemoryNode) : u8 {
        arg0.node_type
    }

    entry fun record(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: u64, arg6: u8, arg7: vector<0x2::object::ID>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 6, 301);
        assert!(0x1::vector::length<0x2::object::ID>(&arg7) <= 16, 302);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_write(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg9));
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_dek_ready_for_record(arg2, arg5);
        let v0 = 0x2::tx_context::sender(arg9);
        mint(arg2, arg4, arg6, arg5, arg7, 0x2::clock::timestamp_ms(arg8), v0, 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg1), arg9);
    }

    public fun storage_end_epoch(arg0: &MemoryNode) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x2::dynamic_object_field::borrow<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.id, b"blob"))
    }

    entry fun update_blob_metadata(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: &mut MemoryNode, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg4.id);
        assert!(arg4.namespace_id == 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg2), 300);
        assert!(has_prefix(&arg5, b"wmb_"), 303);
        assert!(!is_write_once_blob_key(&arg5), 304);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_metadata_blob_write(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg7));
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg4.id, b"blob");
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(v0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::insert_or_update_metadata_pair(v0, arg5, arg6);
        let v2 = BlobMetadataUpdated{
            namespace_id   : arg4.namespace_id,
            node_id        : 0x2::object::id<MemoryNode>(arg4),
            walrus_blob_id : 0x2::bcs::to_bytes<u256>(&v1),
            key            : arg5,
            value          : arg6,
            by             : 0x2::tx_context::sender(arg7),
            principal      : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg1),
        };
        0x2::event::emit<BlobMetadataUpdated>(v2);
    }

    entry fun update_metadata(arg0: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::ProtocolVersion, arg1: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::Account, arg2: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace, arg3: &0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::AccountRegistry, arg4: &mut MemoryNode, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::assert_current(arg0, &arg4.id);
        assert!(arg4.namespace_id == 0x2::object::id<0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::MemoryNamespace>(arg2), 300);
        assert!(has_prefix(&arg5, b"wmn_"), 303);
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::namespace::assert_metadata_write(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg7));
        let v0 = NodeMetadataUpdated{
            namespace_id : arg4.namespace_id,
            node_id      : 0x2::object::id<MemoryNode>(arg4),
            key          : arg5,
            value        : arg6,
            by           : 0x2::tx_context::sender(arg7),
            principal    : 0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::account::owner(arg1),
        };
        0x2::event::emit<NodeMetadataUpdated>(v0);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg4.metadata, &arg5)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg4.metadata, &arg5);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg4.metadata, arg5, arg6);
    }

    public fun version(arg0: &MemoryNode) : u64 {
        0xca4386c224cbc2363216d77672dab15a0b5d975feb9e67b5cc08063eeca48d15::versioning::stored(&arg0.id)
    }

    public fun walrus_blob_id(arg0: &MemoryNode) : vector<u8> {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0x2::dynamic_object_field::borrow<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.id, b"blob"));
        0x2::bcs::to_bytes<u256>(&v0)
    }

    // decompiled from Move bytecode v7
}

