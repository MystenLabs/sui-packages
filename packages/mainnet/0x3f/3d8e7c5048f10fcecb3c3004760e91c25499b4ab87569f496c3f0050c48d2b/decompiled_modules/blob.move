module 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::blob {
    struct Blob has store, key {
        id: 0x2::object::UID,
        registered_epoch: u32,
        blob_id: u256,
        size: u64,
        encoding_type: u8,
        certified_epoch: 0x1::option::Option<u32>,
        storage: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage,
        deletable: bool,
    }

    struct BlobIdDerivation has drop {
        encoding_type: u8,
        size: u64,
        root_hash: u256,
    }

    public(friend) fun new(arg0: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage, arg1: u256, arg2: u256, arg3: u64, arg4: u8, arg5: bool, arg6: u32, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : Blob {
        let v0 = 0x2::object::new(arg8);
        assert!(arg6 >= 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::start_epoch(&arg0), 2);
        assert!(arg6 < 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0), 2);
        assert!(0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::encoding::encoded_blob_length(arg3, arg4, arg7) <= 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::size(&arg0), 3);
        assert!(derive_blob_id(arg2, arg4, arg3) == arg1, 6);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::events::emit_blob_registered(arg6, arg1, arg3, arg4, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0), arg5, 0x2::object::uid_to_inner(&v0));
        Blob{
            id               : v0,
            registered_epoch : arg6,
            blob_id          : arg1,
            size             : arg3,
            encoding_type    : arg4,
            certified_epoch  : 0x1::option::none<u32>(),
            storage          : arg0,
            deletable        : arg5,
        }
    }

    public(friend) fun delete(arg0: Blob, arg1: u32) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage {
        0x2::dynamic_field::remove_if_exists<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata");
        let Blob {
            id               : v0,
            registered_epoch : _,
            blob_id          : v2,
            size             : _,
            encoding_type    : _,
            certified_epoch  : v5,
            storage          : v6,
            deletable        : v7,
        } = arg0;
        let v8 = v6;
        let v9 = v5;
        let v10 = v0;
        assert!(v7, 1);
        assert!(0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&v8) > arg1, 2);
        0x2::object::delete(v10);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::events::emit_blob_deleted(arg1, v2, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&v8), 0x2::object::uid_to_inner(&v10), 0x1::option::is_some<u32>(&v9));
        v8
    }

    public fun add_metadata(arg0: &mut Blob, arg1: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 7);
        0x2::dynamic_field::add<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata", arg1);
    }

    fun metadata(arg0: &mut Blob) : &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 8);
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    public fun add_or_replace_metadata(arg0: &mut Blob, arg1: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata) : 0x1::option::Option<0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata> {
        let v0 = if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            let v1 = take_metadata(arg0);
            0x1::option::some<0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(v1)
        } else {
            0x1::option::none<0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>()
        };
        add_metadata(arg0, arg1);
        v0
    }

    public(friend) fun assert_certified_not_expired(arg0: &Blob, arg1: u32) {
        assert!(0x1::option::is_some<u32>(&arg0.certified_epoch), 0);
        assert!(arg1 < 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0.storage), 2);
    }

    public fun blob_id(arg0: &Blob) : u256 {
        arg0.blob_id
    }

    public fun burn(arg0: Blob) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata");
        let Blob {
            id               : v0,
            registered_epoch : _,
            blob_id          : _,
            size             : _,
            encoding_type    : _,
            certified_epoch  : _,
            storage          : v6,
            deletable        : _,
        } = arg0;
        0x2::object::delete(v0);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::destroy(v6);
    }

    public fun certified_epoch(arg0: &Blob) : &0x1::option::Option<u32> {
        &arg0.certified_epoch
    }

    public(friend) fun certify_with_certified_msg(arg0: &mut Blob, arg1: u32, arg2: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::CertifiedBlobMessage) {
        assert!(blob_id(arg0) == 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::certified_blob_id(&arg2), 6);
        assert!(!0x1::option::is_some<u32>(&arg0.certified_epoch), 5);
        assert!(arg1 < 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0.storage), 2);
        let v0 = 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::blob_persistence_type(&arg2);
        assert!(arg0.deletable == 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::is_deletable(&v0), 9);
        if (arg0.deletable) {
            let v1 = 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::blob_persistence_type(&arg2);
            assert!(0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::messages::object_id(&v1) == 0x2::object::id<Blob>(arg0), 10);
        };
        0x1::option::fill<u32>(&mut arg0.certified_epoch, arg1);
        emit_certified(arg0, false);
    }

    public fun derive_blob_id(arg0: u256, arg1: u8, arg2: u64) : u256 {
        let v0 = BlobIdDerivation{
            encoding_type : arg1,
            size          : arg2,
            root_hash     : arg0,
        };
        let v1 = 0x2::bcs::to_bytes<BlobIdDerivation>(&v0);
        let v2 = 0x2::bcs::new(0x2::hash::blake2b256(&v1));
        0x2::bcs::peel_u256(&mut v2)
    }

    public(friend) fun emit_certified(arg0: &Blob, arg1: bool) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::events::emit_blob_certified(*0x1::option::borrow<u32>(&arg0.certified_epoch), arg0.blob_id, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0.storage), arg0.deletable, 0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public fun encoded_size(arg0: &Blob, arg1: u16) : u64 {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::encoding::encoded_blob_length(arg0.size, arg0.encoding_type, arg1)
    }

    public fun encoding_type(arg0: &Blob) : u8 {
        arg0.encoding_type
    }

    public fun end_epoch(arg0: &Blob) : u32 {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0.storage)
    }

    public(friend) fun extend_with_resource(arg0: &mut Blob, arg1: 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage, arg2: u32) {
        assert_certified_not_expired(arg0, arg2);
        assert!(0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg1) > 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::end_epoch(&arg0.storage), 2);
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::fuse_periods(&mut arg0.storage, arg1);
        emit_certified(arg0, true);
    }

    public fun insert_or_update_metadata_pair(arg0: &mut Blob, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::insert_or_update(metadata_or_create(arg0), arg1, arg2);
    }

    fun metadata_or_create(arg0: &mut Blob) : &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            add_metadata(arg0, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::new());
        };
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    public fun object_id(arg0: &Blob) : 0x2::object::ID {
        0x2::object::id<Blob>(arg0)
    }

    public fun registered_epoch(arg0: &Blob) : u32 {
        arg0.registered_epoch
    }

    public fun remove_metadata_pair(arg0: &mut Blob, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::remove(metadata(arg0), arg1)
    }

    public fun remove_metadata_pair_if_exists(arg0: &mut Blob, arg1: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata")) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::remove_if_exists(metadata(arg0), arg1)
        }
    }

    public fun size(arg0: &Blob) : u64 {
        arg0.size
    }

    public fun storage(arg0: &Blob) : &0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage {
        &arg0.storage
    }

    public(friend) fun storage_mut(arg0: &mut Blob) : &mut 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::storage_resource::Storage {
        &mut arg0.storage
    }

    public fun take_metadata(arg0: &mut Blob) : 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"metadata"), 8);
        0x2::dynamic_field::remove<vector<u8>, 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::metadata::Metadata>(&mut arg0.id, b"metadata")
    }

    // decompiled from Move bytecode v6
}

