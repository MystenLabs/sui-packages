module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::encryption_history {
    struct EncryptionHistoryTag has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct PermissionedGroupTag has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct EncryptionKeyRotator has drop {
        dummy_field: bool,
    }

    struct EncryptionHistory has store, key {
        id: 0x2::object::UID,
        group_id: 0x2::object::ID,
        uuid: 0x1::string::String,
        encrypted_keys: 0x2::table_vec::TableVec<vector<u8>>,
    }

    struct EncryptionHistoryCreated has copy, drop {
        encryption_history_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        uuid: 0x1::string::String,
        initial_encrypted_dek: vector<u8>,
    }

    struct EncryptionKeyRotated has copy, drop {
        encryption_history_id: 0x2::object::ID,
        group_id: 0x2::object::ID,
        new_key_version: u64,
        new_encrypted_dek: vector<u8>,
    }

    public fun current_encrypted_key(arg0: &EncryptionHistory) : &vector<u8> {
        encrypted_key(arg0, current_key_version(arg0))
    }

    public fun current_key_version(arg0: &EncryptionHistory) : u64 {
        0x2::table_vec::length<vector<u8>>(&arg0.encrypted_keys) - 1
    }

    public fun encrypted_key(arg0: &EncryptionHistory, arg1: u64) : &vector<u8> {
        assert!(arg1 < 0x2::table_vec::length<vector<u8>>(&arg0.encrypted_keys), 1);
        0x2::table_vec::borrow<vector<u8>>(&arg0.encrypted_keys, arg1)
    }

    public fun group_id(arg0: &EncryptionHistory) : 0x2::object::ID {
        arg0.group_id
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : EncryptionHistory {
        let v0 = EncryptionHistoryTag{pos0: arg1};
        assert!(!0x2::derived_object::exists<EncryptionHistoryTag>(arg0, v0), 0);
        assert!(0x1::vector::length<u8>(&arg3) <= 1024, 2);
        let v1 = 0x2::table_vec::empty<vector<u8>>(arg4);
        0x2::table_vec::push_back<vector<u8>>(&mut v1, arg3);
        let v2 = EncryptionHistoryTag{pos0: arg1};
        let v3 = EncryptionHistory{
            id             : 0x2::derived_object::claim<EncryptionHistoryTag>(arg0, v2),
            group_id       : arg2,
            uuid           : arg1,
            encrypted_keys : v1,
        };
        let v4 = EncryptionHistoryCreated{
            encryption_history_id : 0x2::object::id<EncryptionHistory>(&v3),
            group_id              : arg2,
            uuid                  : v3.uuid,
            initial_encrypted_dek : arg3,
        };
        0x2::event::emit<EncryptionHistoryCreated>(v4);
        v3
    }

    public(friend) fun permissions_group_tag(arg0: 0x1::string::String) : PermissionedGroupTag {
        PermissionedGroupTag{pos0: arg0}
    }

    public(friend) fun rotate_key(arg0: &mut EncryptionHistory, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 1024, 2);
        0x2::table_vec::push_back<vector<u8>>(&mut arg0.encrypted_keys, arg1);
        let v0 = EncryptionKeyRotated{
            encryption_history_id : 0x2::object::id<EncryptionHistory>(arg0),
            group_id              : arg0.group_id,
            new_key_version       : 0x2::table_vec::length<vector<u8>>(&arg0.encrypted_keys) - 1,
            new_encrypted_dek     : arg1,
        };
        0x2::event::emit<EncryptionKeyRotated>(v0);
    }

    public fun uuid(arg0: &EncryptionHistory) : 0x1::string::String {
        arg0.uuid
    }

    // decompiled from Move bytecode v6
}

