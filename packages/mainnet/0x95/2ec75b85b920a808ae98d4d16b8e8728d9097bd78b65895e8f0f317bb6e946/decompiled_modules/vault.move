module 0x952ec75b85b920a808ae98d4d16b8e8728d9097bd78b65895e8f0f317bb6e946::vault {
    struct FileAdded has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        name: 0x1::string::String,
        size: u64,
        owner: address,
    }

    struct FileRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        owner: address,
    }

    struct FileRecord has copy, drop, store {
        identity: 0x1::string::String,
        encrypted_name: vector<u8>,
        mime_type: 0x1::string::String,
        blob_id: 0x1::string::String,
        size: u64,
        created_at: u64,
    }

    struct FileVault has key {
        id: 0x2::object::UID,
        site_id: 0x2::object::ID,
        file_count: u64,
    }

    public fun add_file<T0: key>(arg0: &mut FileVault, arg1: &T0, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(arg1) == arg0.site_id, 6);
        assert!(!0x1::string::is_empty(&arg2), 0);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 0);
        assert!(!0x1::string::is_empty(&arg5), 1);
        assert!(arg6 > 0, 2);
        assert!(arg0.file_count < 1000, 3);
        assert!(!0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, arg5), 7);
        let v0 = FileRecord{
            identity       : arg2,
            encrypted_name : arg3,
            mime_type      : arg4,
            blob_id        : arg5,
            size           : arg6,
            created_at     : arg7,
        };
        0x2::dynamic_field::add<0x1::string::String, FileRecord>(&mut arg0.id, arg5, v0);
        arg0.file_count = arg0.file_count + 1;
        let v1 = FileAdded{
            vault_id : 0x2::object::id<FileVault>(arg0),
            blob_id  : arg5,
            name     : 0x1::string::utf8(b"encrypted"),
            size     : arg6,
            owner    : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<FileAdded>(v1);
    }

    public fun initialize(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FileVault{
            id         : 0x2::object::new(arg1),
            site_id    : arg0,
            file_count : 0,
        };
        0x2::transfer::share_object<FileVault>(v0);
    }

    public fun remove_file<T0: key>(arg0: &mut FileVault, arg1: &T0, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(arg1) == arg0.site_id, 6);
        assert!(0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, arg2), 5);
        0x2::dynamic_field::remove<0x1::string::String, FileRecord>(&mut arg0.id, arg2);
        arg0.file_count = arg0.file_count - 1;
        let v0 = FileRemoved{
            vault_id : 0x2::object::id<FileVault>(arg0),
            blob_id  : arg2,
            owner    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FileRemoved>(v0);
    }

    entry fun seal_approve_access<T0: key>(arg0: vector<u8>, arg1: &FileVault, arg2: &T0, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(arg2) == arg1.site_id, 6);
    }

    // decompiled from Move bytecode v7
}

