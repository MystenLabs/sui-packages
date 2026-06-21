module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::file_registry {
    struct FileObject has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        size: u64,
        mime_type: vector<u8>,
        blob_id: vector<u8>,
        encryption_nonce: vector<u8>,
        master_policy_id: address,
        collection_id: address,
        created_at_ms: u64,
        updated_at_ms: u64,
        starred: bool,
        tags: vector<u8>,
    }

    struct FileUploadedEvent has copy, drop {
        file_id: address,
        owner: address,
        name: vector<u8>,
        size: u64,
        blob_id: vector<u8>,
        master_policy_id: address,
    }

    struct FileDeletedEvent has copy, drop {
        file_id: address,
        owner: address,
        blob_id: vector<u8>,
    }

    struct FileMetadataEditedEvent has copy, drop {
        file_id: address,
        edited_by: address,
        is_owner: bool,
    }

    fun assert_shared_edit_access(arg0: &FileObject, arg1: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::AccessPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::file_id(arg1) == 0x2::object::id_address<FileObject>(arg0), 203);
        assert!(!0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::is_revoked(arg1), 203);
        assert!(0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::can_edit(arg1), 203);
        let v0 = 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::expires_at(arg1);
        if (v0 > 0) {
            assert!(0x2::clock::timestamp_ms(arg2) < v0, 203);
        };
        let v1 = 0x2::tx_context::sender(arg3);
        if (v1 != 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::owner(arg1)) {
            assert!(0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::is_public(arg1) || 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::is_allowed(arg1, v1), 203);
        };
    }

    public fun blob_id(arg0: &FileObject) : &vector<u8> {
        &arg0.blob_id
    }

    public fun collection_id(arg0: &FileObject) : address {
        arg0.collection_id
    }

    public fun created_at(arg0: &FileObject) : u64 {
        arg0.created_at_ms
    }

    public fun delete_file(arg0: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg1: FileObject, arg2: &mut 0x2::tx_context::TxContext) {
        let FileObject {
            id               : v0,
            name             : _,
            size             : v2,
            mime_type        : _,
            blob_id          : v4,
            encryption_nonce : _,
            master_policy_id : _,
            collection_id    : _,
            created_at_ms    : _,
            updated_at_ms    : _,
            starred          : _,
            tags             : _,
        } = arg1;
        let v12 = v0;
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_delete(arg0, v2);
        let v13 = FileDeletedEvent{
            file_id : 0x2::object::uid_to_address(&v12),
            owner   : 0x2::tx_context::sender(arg2),
            blob_id : v4,
        };
        0x2::event::emit<FileDeletedEvent>(v13);
        0x2::object::delete(v12);
    }

    public fun is_starred(arg0: &FileObject) : bool {
        arg0.starred
    }

    public fun master_policy_id(arg0: &FileObject) : address {
        arg0.master_policy_id
    }

    public fun mime_type(arg0: &FileObject) : &vector<u8> {
        &arg0.mime_type
    }

    public fun name(arg0: &FileObject) : &vector<u8> {
        &arg0.name
    }

    public fun register_file(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : FileObject {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 202);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 201);
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::assert_can_upload(arg1, arg3, arg9);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = FileObject{
            id               : 0x2::object::new(arg10),
            name             : arg2,
            size             : arg3,
            mime_type        : arg4,
            blob_id          : arg5,
            encryption_nonce : arg6,
            master_policy_id : arg7,
            collection_id    : @0x0,
            created_at_ms    : v0,
            updated_at_ms    : v0,
            starred          : false,
            tags             : arg8,
        };
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_upload(arg1, arg3);
        let v2 = FileUploadedEvent{
            file_id          : 0x2::object::id_address<FileObject>(&v1),
            owner            : 0x2::tx_context::sender(arg10),
            name             : v1.name,
            size             : arg3,
            blob_id          : v1.blob_id,
            master_policy_id : arg7,
        };
        0x2::event::emit<FileUploadedEvent>(v2);
        v1
    }

    public fun remove_from_collection(arg0: &mut FileObject, arg1: &0x2::clock::Clock) {
        arg0.collection_id = @0x0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun rename_file(arg0: &mut FileObject, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 202);
        arg0.name = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = FileMetadataEditedEvent{
            file_id   : 0x2::object::id_address<FileObject>(arg0),
            edited_by : @0x0,
            is_owner  : true,
        };
        0x2::event::emit<FileMetadataEditedEvent>(v0);
    }

    public fun rename_file_shared(arg0: &mut FileObject, arg1: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::AccessPolicy, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 202);
        assert_shared_edit_access(arg0, arg1, arg3, arg4);
        arg0.name = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FileMetadataEditedEvent{
            file_id   : 0x2::object::id_address<FileObject>(arg0),
            edited_by : 0x2::tx_context::sender(arg4),
            is_owner  : false,
        };
        0x2::event::emit<FileMetadataEditedEvent>(v0);
    }

    public fun set_collection(arg0: &mut FileObject, arg1: address, arg2: &0x2::clock::Clock) {
        arg0.collection_id = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun size(arg0: &FileObject) : u64 {
        arg0.size
    }

    public fun tags(arg0: &FileObject) : &vector<u8> {
        &arg0.tags
    }

    public fun toggle_star(arg0: &mut FileObject, arg1: &0x2::clock::Clock) {
        arg0.starred = !arg0.starred;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun update_tags(arg0: &mut FileObject, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        arg0.tags = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public fun update_tags_shared(arg0: &mut FileObject, arg1: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::AccessPolicy, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_shared_edit_access(arg0, arg1, arg3, arg4);
        arg0.tags = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FileMetadataEditedEvent{
            file_id   : 0x2::object::id_address<FileObject>(arg0),
            edited_by : 0x2::tx_context::sender(arg4),
            is_owner  : false,
        };
        0x2::event::emit<FileMetadataEditedEvent>(v0);
    }

    public fun updated_at(arg0: &FileObject) : u64 {
        arg0.updated_at_ms
    }

    // decompiled from Move bytecode v7
}

