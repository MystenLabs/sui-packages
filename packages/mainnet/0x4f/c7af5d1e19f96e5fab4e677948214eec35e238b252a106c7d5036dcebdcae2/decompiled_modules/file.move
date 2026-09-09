module 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::file {
    struct EncryptedFile has key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x1::option::Option<0x2::object::ID>,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
        size: u64,
        encrypted: bool,
        allowlist_id: 0x1::option::Option<0x2::object::ID>,
        created_at_ms: u64,
    }

    struct FileCreated has copy, drop {
        file: 0x2::object::ID,
        owner: address,
        allowlist_id: 0x1::option::Option<0x2::object::ID>,
        encrypted: bool,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
        size: u64,
    }

    struct FileDeleted has copy, drop {
        file: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct FileMetadataUpdated has copy, drop {
        file: 0x2::object::ID,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
    }

    struct FileOwnershipTransferred has copy, drop {
        file: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    public fun allowlist_id(arg0: &EncryptedFile) : 0x1::option::Option<0x2::object::ID> {
        arg0.allowlist_id
    }

    fun assert_valid_blob_id(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 1);
    }

    fun assert_valid_content_type(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 3);
        assert!(0x1::string::length(arg0) <= 255, 3);
    }

    fun assert_valid_name(arg0: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 2);
        assert!(0x1::string::length(arg0) <= 256, 2);
    }

    public fun blob_id(arg0: &EncryptedFile) : vector<u8> {
        arg0.blob_id
    }

    public fun blob_object_id(arg0: &EncryptedFile) : 0x1::option::Option<0x2::object::ID> {
        arg0.blob_object_id
    }

    public fun content_type(arg0: &EncryptedFile) : 0x1::string::String {
        arg0.content_type
    }

    public fun created_at_ms(arg0: &EncryptedFile) : u64 {
        arg0.created_at_ms
    }

    public fun delete_file(arg0: EncryptedFile, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let EncryptedFile {
            id             : v0,
            owner          : _,
            blob_id        : _,
            blob_object_id : _,
            name           : v4,
            content_type   : _,
            size           : _,
            encrypted      : _,
            allowlist_id   : _,
            created_at_ms  : _,
        } = arg0;
        0x2::object::delete(v0);
        let v10 = FileDeleted{
            file : 0x2::object::id<EncryptedFile>(&arg0),
            name : v4,
        };
        0x2::event::emit<FileDeleted>(v10);
    }

    public fun is_encrypted(arg0: &EncryptedFile) : bool {
        arg0.encrypted
    }

    public fun name(arg0: &EncryptedFile) : 0x1::string::String {
        arg0.name
    }

    public fun new_encrypted_file(arg0: vector<u8>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : EncryptedFile {
        assert_valid_blob_id(&arg0);
        assert_valid_name(&arg2);
        assert_valid_content_type(&arg3);
        let v0 = EncryptedFile{
            id             : 0x2::object::new(arg7),
            owner          : 0x2::tx_context::sender(arg7),
            blob_id        : arg0,
            blob_object_id : arg1,
            name           : arg2,
            content_type   : arg3,
            size           : arg4,
            encrypted      : true,
            allowlist_id   : 0x1::option::some<0x2::object::ID>(arg5),
            created_at_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = FileCreated{
            file         : 0x2::object::id<EncryptedFile>(&v0),
            owner        : v0.owner,
            allowlist_id : 0x1::option::some<0x2::object::ID>(arg5),
            encrypted    : true,
            name         : v0.name,
            content_type : v0.content_type,
            size         : arg4,
        };
        0x2::event::emit<FileCreated>(v1);
        v0
    }

    public fun new_public_file(arg0: vector<u8>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : EncryptedFile {
        assert_valid_blob_id(&arg0);
        assert_valid_name(&arg2);
        assert_valid_content_type(&arg3);
        let v0 = EncryptedFile{
            id             : 0x2::object::new(arg6),
            owner          : 0x2::tx_context::sender(arg6),
            blob_id        : arg0,
            blob_object_id : arg1,
            name           : arg2,
            content_type   : arg3,
            size           : arg4,
            encrypted      : false,
            allowlist_id   : 0x1::option::none<0x2::object::ID>(),
            created_at_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = FileCreated{
            file         : 0x2::object::id<EncryptedFile>(&v0),
            owner        : v0.owner,
            allowlist_id : 0x1::option::none<0x2::object::ID>(),
            encrypted    : false,
            name         : v0.name,
            content_type : v0.content_type,
            size         : arg4,
        };
        0x2::event::emit<FileCreated>(v1);
        v0
    }

    public fun owner(arg0: &EncryptedFile) : address {
        arg0.owner
    }

    public fun share_file(arg0: EncryptedFile) {
        0x2::transfer::share_object<EncryptedFile>(arg0);
    }

    public fun size(arg0: &EncryptedFile) : u64 {
        arg0.size
    }

    public fun transfer_ownership(arg0: &mut EncryptedFile, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
        let v0 = FileOwnershipTransferred{
            file           : 0x2::object::id<EncryptedFile>(arg0),
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<FileOwnershipTransferred>(v0);
    }

    public fun update_metadata(arg0: &mut EncryptedFile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert_valid_name(&arg1);
        assert_valid_content_type(&arg2);
        arg0.name = arg1;
        arg0.content_type = arg2;
        let v0 = FileMetadataUpdated{
            file         : 0x2::object::id<EncryptedFile>(arg0),
            name         : arg0.name,
            content_type : arg0.content_type,
        };
        0x2::event::emit<FileMetadataUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

