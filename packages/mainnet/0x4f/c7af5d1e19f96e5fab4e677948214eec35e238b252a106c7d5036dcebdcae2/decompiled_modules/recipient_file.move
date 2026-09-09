module 0x4fc7af5d1e19f96e5fab4e677948214eec35e238b252a106c7d5036dcebdcae2::recipient_file {
    struct RecipientFile has key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x1::option::Option<0x2::object::ID>,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
        size: u64,
        members: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
    }

    struct RecipientFileCreated has copy, drop {
        file: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
        size: u64,
        members: vector<address>,
    }

    struct RecipientFileDeleted has copy, drop {
        file: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct RecipientFileMetadataUpdated has copy, drop {
        file: 0x2::object::ID,
        name: 0x1::string::String,
        content_type: 0x1::string::String,
    }

    struct RecipientFileOwnershipTransferred has copy, drop {
        file: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    struct RecipientAdded has copy, drop {
        file: 0x2::object::ID,
        recipient: address,
    }

    struct RecipientRemoved has copy, drop {
        file: 0x2::object::ID,
        recipient: address,
    }

    struct SealPrefixKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecipientFileSealPrefixAttached has copy, drop {
        file: 0x2::object::ID,
        seal_id_prefix: vector<u8>,
    }

    public fun add_recipient(arg0: &mut RecipientFile, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x2::vec_set::contains<address>(&arg0.members, &arg1), 4);
        0x2::vec_set::insert<address>(&mut arg0.members, arg1);
        let v0 = RecipientAdded{
            file      : 0x2::object::id<RecipientFile>(arg0),
            recipient : arg1,
        };
        0x2::event::emit<RecipientAdded>(v0);
    }

    fun assert_id_matches_prefix(arg0: &vector<u8>, arg1: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(0x1::vector::length<u8>(arg1) > v0 + 1, 6);
        let v1 = 0;
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u8>(arg0, v1) == *0x1::vector::borrow<u8>(arg1, v1), 6);
            v1 = v1 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(arg1, v0) == 3, 7);
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

    fun assert_valid_recipient_file_seal_id(arg0: &RecipientFile, arg1: &vector<u8>) {
        let v0 = 0x2::object::id<RecipientFile>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert_id_matches_prefix(&v1, arg1);
    }

    public fun blob_id(arg0: &RecipientFile) : vector<u8> {
        arg0.blob_id
    }

    public fun blob_object_id(arg0: &RecipientFile) : 0x1::option::Option<0x2::object::ID> {
        arg0.blob_object_id
    }

    public fun content_type(arg0: &RecipientFile) : 0x1::string::String {
        arg0.content_type
    }

    public fun created_at_ms(arg0: &RecipientFile) : u64 {
        arg0.created_at_ms
    }

    public fun delete_file(arg0: RecipientFile, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let RecipientFile {
            id             : v0,
            owner          : _,
            blob_id        : _,
            blob_object_id : _,
            name           : v4,
            content_type   : _,
            size           : _,
            members        : _,
            created_at_ms  : _,
        } = arg0;
        0x2::object::delete(v0);
        let v9 = RecipientFileDeleted{
            file : 0x2::object::id<RecipientFile>(&arg0),
            name : v4,
        };
        0x2::event::emit<RecipientFileDeleted>(v9);
    }

    public fun is_recipient(arg0: &RecipientFile, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun name(arg0: &RecipientFile) : 0x1::string::String {
        arg0.name
    }

    public fun new_recipient_file(arg0: vector<u8>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : RecipientFile {
        assert_valid_blob_id(&arg0);
        assert_valid_name(&arg2);
        assert_valid_content_type(&arg3);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg5)) {
            let v3 = *0x1::vector::borrow<address>(&arg5, v2);
            if (!0x2::vec_set::contains<address>(&v1, &v3)) {
                0x2::vec_set::insert<address>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RecipientFile{
            id             : 0x2::object::new(arg7),
            owner          : v0,
            blob_id        : arg0,
            blob_object_id : arg1,
            name           : arg2,
            content_type   : arg3,
            size           : arg4,
            members        : v1,
            created_at_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        let v5 = RecipientFileCreated{
            file         : 0x2::object::id<RecipientFile>(&v4),
            owner        : v0,
            name         : v4.name,
            content_type : v4.content_type,
            size         : arg4,
            members      : *0x2::vec_set::keys<address>(&v1),
        };
        0x2::event::emit<RecipientFileCreated>(v5);
        v4
    }

    public fun new_recipient_file_with_seal_prefix(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : RecipientFile {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 9);
        let v0 = new_recipient_file(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = SealPrefixKey{dummy_field: false};
        0x2::dynamic_field::add<SealPrefixKey, vector<u8>>(&mut v0.id, v1, arg0);
        let v2 = RecipientFileSealPrefixAttached{
            file           : 0x2::object::id<RecipientFile>(&v0),
            seal_id_prefix : arg0,
        };
        0x2::event::emit<RecipientFileSealPrefixAttached>(v2);
        v0
    }

    public fun owner(arg0: &RecipientFile) : address {
        arg0.owner
    }

    public fun recipient_count(arg0: &RecipientFile) : u64 {
        0x2::vec_set::length<address>(&arg0.members)
    }

    public fun remove_recipient(arg0: &mut RecipientFile, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &arg1), 5);
        0x2::vec_set::remove<address>(&mut arg0.members, &arg1);
        let v0 = RecipientRemoved{
            file      : 0x2::object::id<RecipientFile>(arg0),
            recipient : arg1,
        };
        0x2::event::emit<RecipientRemoved>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &RecipientFile, arg2: &0x2::tx_context::TxContext) {
        assert_valid_recipient_file_seal_id(arg1, &arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v0), 8);
    }

    entry fun seal_approve_with_prefix(arg0: vector<u8>, arg1: &RecipientFile, arg2: &0x2::tx_context::TxContext) {
        let v0 = SealPrefixKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<SealPrefixKey>(&arg1.id, v0), 10);
        let v1 = SealPrefixKey{dummy_field: false};
        assert_id_matches_prefix(0x2::dynamic_field::borrow<SealPrefixKey, vector<u8>>(&arg1.id, v1), &arg0);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg1.members, &v2), 8);
    }

    public fun seal_id_prefix(arg0: &RecipientFile) : 0x1::option::Option<vector<u8>> {
        let v0 = SealPrefixKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<SealPrefixKey>(&arg0.id, v0)) {
            let v2 = SealPrefixKey{dummy_field: false};
            0x1::option::some<vector<u8>>(*0x2::dynamic_field::borrow<SealPrefixKey, vector<u8>>(&arg0.id, v2))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun share_recipient_file(arg0: RecipientFile) {
        0x2::transfer::share_object<RecipientFile>(arg0);
    }

    public fun size(arg0: &RecipientFile) : u64 {
        arg0.size
    }

    public fun transfer_ownership(arg0: &mut RecipientFile, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
        let v0 = RecipientFileOwnershipTransferred{
            file           : 0x2::object::id<RecipientFile>(arg0),
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<RecipientFileOwnershipTransferred>(v0);
    }

    public fun update_metadata(arg0: &mut RecipientFile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert_valid_name(&arg1);
        assert_valid_content_type(&arg2);
        arg0.name = arg1;
        arg0.content_type = arg2;
        let v0 = RecipientFileMetadataUpdated{
            file         : 0x2::object::id<RecipientFile>(arg0),
            name         : arg0.name,
            content_type : arg0.content_type,
        };
        0x2::event::emit<RecipientFileMetadataUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

