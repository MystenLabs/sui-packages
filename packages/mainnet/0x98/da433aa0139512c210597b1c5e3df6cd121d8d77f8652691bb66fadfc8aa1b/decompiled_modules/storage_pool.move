module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool {
    struct StoragePool has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct StoragePoolInnerV1 has store {
        storage: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage,
        used_encoded_bytes: u64,
        blob_count: u64,
        blobs: 0x2::object_table::ObjectTable<u256, PooledBlob>,
    }

    struct PooledBlob has store, key {
        id: 0x2::object::UID,
        registered_epoch: u32,
        blob_id: u256,
        unencoded_size: u64,
        encoding_type: u8,
        certified_epoch: 0x1::option::Option<u32>,
        storage_pool_id: 0x2::object::ID,
        deletable: bool,
    }

    public(friend) fun is_deletable(arg0: &PooledBlob) : bool {
        arg0.deletable
    }

    public fun object_id(arg0: &StoragePool) : 0x2::object::ID {
        0x2::object::id<StoragePool>(arg0)
    }

    fun metadata(arg0: &mut PooledBlob) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 13);
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    public(friend) fun add_blob(arg0: &mut StoragePool, arg1: PooledBlob, arg2: u64) {
        let v0 = inner_mut(arg0);
        v0.blob_count = v0.blob_count + 1;
        v0.used_encoded_bytes = v0.used_encoded_bytes + arg2;
        assert!(v0.used_encoded_bytes <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v0.storage), 6);
        0x2::object_table::add<u256, PooledBlob>(&mut v0.blobs, arg1.blob_id, arg1);
    }

    public fun add_blob_metadata(arg0: &mut StoragePool, arg1: u256, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata) {
        let v0 = borrow_blob_mut(arg0, arg1);
        add_metadata(v0, arg2);
    }

    fun add_metadata(arg0: &mut PooledBlob, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 12);
        0x2::dynamic_field::add<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata", arg1);
    }

    public fun add_or_replace_blob_metadata(arg0: &mut StoragePool, arg1: u256, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata) : 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata> {
        let v0 = borrow_blob_mut(arg0, arg1);
        add_or_replace_metadata(v0, arg2)
    }

    fun add_or_replace_metadata(arg0: &mut PooledBlob, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata) : 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata> {
        let v0 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            let v1 = take_metadata(arg0);
            0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(v1)
        } else {
            0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>()
        };
        add_metadata(arg0, arg1);
        v0
    }

    public fun available_encoded_bytes(arg0: &StoragePool) : u64 {
        let v0 = inner(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v0.storage) - v0.used_encoded_bytes
    }

    public fun blob_count(arg0: &StoragePool) : u64 {
        inner(arg0).blob_count
    }

    public fun blob_object_id(arg0: &StoragePool, arg1: u256) : 0x2::object::ID {
        0x2::object::id<PooledBlob>(0x2::object_table::borrow<u256, PooledBlob>(&inner(arg0).blobs, arg1))
    }

    public(friend) fun borrow_blob(arg0: &StoragePool, arg1: u256) : &PooledBlob {
        0x2::object_table::borrow<u256, PooledBlob>(&inner(arg0).blobs, arg1)
    }

    public(friend) fun borrow_blob_mut(arg0: &mut StoragePool, arg1: u256) : &mut PooledBlob {
        0x2::object_table::borrow_mut<u256, PooledBlob>(&mut inner_mut(arg0).blobs, arg1)
    }

    public(friend) fun burn_blob_object(arg0: PooledBlob) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata");
        let PooledBlob {
            id               : v0,
            registered_epoch : _,
            blob_id          : _,
            unencoded_size   : _,
            encoding_type    : _,
            certified_epoch  : _,
            storage_pool_id  : _,
            deletable        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun certify(arg0: &mut PooledBlob, arg1: u32, arg2: u32, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::CertifiedBlobMessage) {
        assert!(arg0.blob_id == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::certified_blob_id(&arg3), 3);
        assert!(arg1 < arg2, 1);
        assert!(!0x1::option::is_some<u32>(&arg0.certified_epoch), 2);
        arg0.certified_epoch = 0x1::option::some<u32>(arg1);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::blob_persistence_type(&arg3);
        assert!(arg0.deletable == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::is_deletable(&v0), 4);
        if (arg0.deletable) {
            let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::blob_persistence_type(&arg3);
            assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::messages::object_id(&v1) == 0x2::object::id<PooledBlob>(arg0), 5);
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::events::emit_pooled_blob_certified(arg1, arg0.blob_id, arg0.deletable, 0x2::object::uid_to_inner(&arg0.id), arg0.storage_pool_id);
    }

    public fun contains_blob(arg0: &StoragePool, arg1: u256) : bool {
        0x2::object_table::contains<u256, PooledBlob>(&inner(arg0).blobs, arg1)
    }

    public(friend) fun create(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg1: &mut 0x2::tx_context::TxContext) : StoragePool {
        let v0 = StoragePool{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        let v1 = StoragePoolInnerV1{
            storage            : arg0,
            used_encoded_bytes : 0,
            blob_count         : 0,
            blobs              : 0x2::object_table::new<u256, PooledBlob>(arg1),
        };
        0x2::dynamic_field::add<u64, StoragePoolInnerV1>(&mut v0.id, 1, v1);
        v0
    }

    public(friend) fun decrease_capacity_by_size(arg0: &mut StoragePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage> {
        if (arg1 == 0) {
            return 0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>()
        };
        let v0 = inner_mut(arg0);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v0.storage) - v0.used_encoded_bytes >= arg1, 6);
        0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::split_by_size(&mut v0.storage, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v0.storage) - arg1, arg2))
    }

    public(friend) fun decrease_unused_capacity_by_percent(arg0: &mut StoragePool, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage> {
        assert!(arg1 <= 100, 14);
        let v0 = inner(arg0);
        decrease_capacity_by_size(arg0, ((((0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v0.storage) - v0.used_encoded_bytes) as u128) * (arg1 as u128) / 100) as u64), arg2)
    }

    public(friend) fun delete_blob_object(arg0: PooledBlob, arg1: u32) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata");
        let PooledBlob {
            id               : v0,
            registered_epoch : _,
            blob_id          : v2,
            unencoded_size   : _,
            encoding_type    : _,
            certified_epoch  : v5,
            storage_pool_id  : v6,
            deletable        : v7,
        } = arg0;
        let v8 = v5;
        let v9 = v0;
        assert!(v7, 0);
        0x2::object::delete(v9);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::events::emit_pooled_blob_deleted(arg1, v2, 0x2::object::uid_to_inner(&v9), 0x1::option::is_some<u32>(&v8), v6);
    }

    public fun destroy(arg0: StoragePool) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        let StoragePool {
            id      : v0,
            version : v1,
        } = arg0;
        let v2 = v0;
        let StoragePoolInnerV1 {
            storage            : v3,
            used_encoded_bytes : _,
            blob_count         : v5,
            blobs              : v6,
        } = 0x2::dynamic_field::remove<u64, StoragePoolInnerV1>(&mut v2, v1);
        assert!(v5 == 0, 7);
        0x2::object_table::destroy_empty<u256, PooledBlob>(v6);
        0x2::object::delete(v2);
        v3
    }

    public fun end_epoch(arg0: &StoragePool) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&inner(arg0).storage)
    }

    public(friend) fun extend_end_epoch(arg0: &mut StoragePool, arg1: u32) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::extend_end_epoch(&mut inner_mut(arg0).storage, arg1);
    }

    public(friend) fun increase_capacity_with_storage(arg0: &mut StoragePool, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg2: u32) {
        let v0 = inner_mut(arg0);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&arg1) <= arg2, 1);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&arg1) == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v0.storage), 11);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::increase_size(&mut v0.storage, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&arg1));
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::destroy(arg1);
    }

    public(friend) fun increase_reserved_encoded_capacity(arg0: &mut StoragePool, arg1: u64) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::increase_size(&mut inner_mut(arg0).storage, arg1);
    }

    fun inner(arg0: &StoragePool) : &StoragePoolInnerV1 {
        assert!(arg0.version == 1, 10);
        0x2::dynamic_field::borrow<u64, StoragePoolInnerV1>(&arg0.id, arg0.version)
    }

    fun inner_mut(arg0: &mut StoragePool) : &mut StoragePoolInnerV1 {
        assert!(arg0.version == 1, 10);
        0x2::dynamic_field::borrow_mut<u64, StoragePoolInnerV1>(&mut arg0.id, arg0.version)
    }

    public fun insert_or_update_blob_metadata_pair(arg0: &mut StoragePool, arg1: u256, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = borrow_blob_mut(arg0, arg1);
        insert_or_update_metadata_pair(v0, arg2, arg3);
    }

    fun insert_or_update_metadata_pair(arg0: &mut PooledBlob, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::insert_or_update(metadata_or_create(arg0), arg1, arg2);
    }

    public(friend) fun is_certified(arg0: &PooledBlob) : bool {
        0x1::option::is_some<u32>(&arg0.certified_epoch)
    }

    fun metadata_or_create(arg0: &mut PooledBlob) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            add_metadata(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::new());
        };
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    public(friend) fun new_pooled_blob(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u64, arg4: u8, arg5: bool, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : PooledBlob {
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::derive_blob_id(arg2, arg4, arg3) == arg1, 3);
        let v0 = 0x2::object::new(arg7);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::events::emit_pooled_blob_registered(arg6, arg1, arg3, arg4, arg5, 0x2::object::uid_to_inner(&v0), arg0);
        PooledBlob{
            id               : v0,
            registered_epoch : arg6,
            blob_id          : arg1,
            unencoded_size   : arg3,
            encoding_type    : arg4,
            certified_epoch  : 0x1::option::none<u32>(),
            storage_pool_id  : arg0,
            deletable        : arg5,
        }
    }

    public(friend) fun remove_blob(arg0: &mut StoragePool, arg1: u256, arg2: u16) : PooledBlob {
        let v0 = inner_mut(arg0);
        let v1 = 0x2::object_table::borrow<u256, PooledBlob>(&v0.blobs, arg1);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(v1.unencoded_size, v1.encoding_type, arg2);
        assert!(v0.used_encoded_bytes >= v2, 8);
        v0.used_encoded_bytes = v0.used_encoded_bytes - v2;
        assert!(v0.blob_count >= 1, 9);
        v0.blob_count = v0.blob_count - 1;
        0x2::object_table::remove<u256, PooledBlob>(&mut v0.blobs, arg1)
    }

    public fun remove_blob_metadata_pair(arg0: &mut StoragePool, arg1: u256, arg2: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        let v0 = borrow_blob_mut(arg0, arg1);
        remove_metadata_pair(v0, arg2)
    }

    public fun remove_blob_metadata_pair_if_exists(arg0: &mut StoragePool, arg1: u256, arg2: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        let v0 = borrow_blob_mut(arg0, arg1);
        remove_metadata_pair_if_exists(v0, arg2)
    }

    fun remove_metadata_pair(arg0: &mut PooledBlob, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove(metadata(arg0), arg1)
    }

    fun remove_metadata_pair_if_exists(arg0: &mut PooledBlob, arg1: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            0x1::option::none<0x1::string::String>()
        } else {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(metadata(arg0), arg1)
        }
    }

    public fun reserved_encoded_capacity_bytes(arg0: &StoragePool) : u64 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&inner(arg0).storage)
    }

    public fun start_epoch(arg0: &StoragePool) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&inner(arg0).storage)
    }

    public fun storage(arg0: &StoragePool) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        &inner(arg0).storage
    }

    public fun take_blob_metadata(arg0: &mut StoragePool, arg1: u256) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata {
        let v0 = borrow_blob_mut(arg0, arg1);
        take_metadata(v0)
    }

    fun take_metadata(arg0: &mut PooledBlob) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 13);
        0x2::dynamic_field::remove<vector<u8>, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    public fun used_encoded_bytes(arg0: &StoragePool) : u64 {
        inner(arg0).used_encoded_bytes
    }

    // decompiled from Move bytecode v7
}

