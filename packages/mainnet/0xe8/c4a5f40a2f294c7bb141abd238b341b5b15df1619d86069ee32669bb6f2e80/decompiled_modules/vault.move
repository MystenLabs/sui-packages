module 0xe8c4a5f40a2f294c7bb141abd238b341b5b15df1619d86069ee32669bb6f2e80::vault {
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
        encrypted_name: 0x1::string::String,
        mime_type: 0x1::string::String,
        blob_id: 0x1::string::String,
        iv: vector<u8>,
        size: u64,
        created_at: u64,
    }

    struct FileVault has key {
        id: 0x2::object::UID,
        site_id: 0x2::object::ID,
        salt: vector<u8>,
        file_count: u64,
    }

    public fun add_file<T0: key>(arg0: &mut FileVault, arg1: &T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<T0>(arg1) == arg0.site_id, 6);
        assert!(!0x1::string::is_empty(&arg2), 0);
        assert!(!0x1::string::is_empty(&arg4), 1);
        assert!(arg6 > 0, 2);
        assert!(arg0.file_count < 1000, 3);
        assert!(!0x2::dynamic_field::exists<0x1::string::String>(&arg0.id, arg4), 7);
        let v0 = FileRecord{
            encrypted_name : arg2,
            mime_type      : arg3,
            blob_id        : arg4,
            iv             : arg5,
            size           : arg6,
            created_at     : arg7,
        };
        0x2::dynamic_field::add<0x1::string::String, FileRecord>(&mut arg0.id, arg4, v0);
        arg0.file_count = arg0.file_count + 1;
        let v1 = FileAdded{
            vault_id : 0x2::object::id<FileVault>(arg0),
            blob_id  : arg4,
            name     : arg2,
            size     : arg6,
            owner    : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<FileAdded>(v1);
    }

    public fun initialize(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FileVault{
            id         : 0x2::object::new(arg2),
            site_id    : arg0,
            salt       : arg1,
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

    // decompiled from Move bytecode v7
}

