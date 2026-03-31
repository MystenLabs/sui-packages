module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::file_system {
    struct FileSystemAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Folder has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        created_at: u64,
        updated_at: u64,
        item_count: u64,
        version: u64,
    }

    struct FileEntry has copy, drop, store {
        name: 0x1::string::String,
        blob_id: 0x1::string::String,
        mime_type: 0x1::string::String,
        size_bytes: u64,
        created_by: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
        tags: vector<0x1::string::String>,
        description: 0x1::string::String,
    }

    struct SubfolderRef has copy, drop, store {
        folder_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct FolderCreated has copy, drop {
        folder_id: 0x2::object::ID,
        name: 0x1::string::String,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        created_by: address,
        timestamp: u64,
    }

    struct FileAdded has copy, drop {
        folder_id: 0x2::object::ID,
        file_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        mime_type: 0x1::string::String,
        size_bytes: u64,
        created_by: 0x1::string::String,
        timestamp: u64,
    }

    struct FileRemoved has copy, drop {
        folder_id: 0x2::object::ID,
        file_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        removed_by: address,
        timestamp: u64,
    }

    struct SubfolderLinked has copy, drop {
        parent_id: 0x2::object::ID,
        child_id: 0x2::object::ID,
        child_name: 0x1::string::String,
        timestamp: u64,
    }

    public fun add_file(arg0: &mut Folder, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1), 201);
        let v1 = FileEntry{
            name        : arg1,
            blob_id     : arg2,
            mime_type   : arg3,
            size_bytes  : arg4,
            created_by  : arg5,
            created_at  : v0,
            updated_at  : v0,
            tags        : arg6,
            description : arg7,
        };
        0x2::dynamic_field::add<0x1::string::String, FileEntry>(&mut arg0.id, arg1, v1);
        arg0.item_count = arg0.item_count + 1;
        arg0.updated_at = v0;
        let v2 = FileAdded{
            folder_id  : 0x2::object::id<Folder>(arg0),
            file_name  : arg1,
            blob_id    : arg2,
            mime_type  : arg3,
            size_bytes : arg4,
            created_by : arg5,
            timestamp  : v0,
        };
        0x2::event::emit<FileAdded>(v2);
    }

    entry fun create_and_transfer_root_folder(arg0: &FileSystemAdminCap, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_root_folder(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Folder>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_root_folder(arg0: &FileSystemAdminCap, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Folder {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Folder{
            id         : 0x2::object::new(arg3),
            name       : arg1,
            parent_id  : 0x1::option::none<0x2::object::ID>(),
            owner      : v1,
            created_at : v0,
            updated_at : v0,
            item_count : 0,
            version    : 1,
        };
        let v3 = FolderCreated{
            folder_id  : 0x2::object::id<Folder>(&v2),
            name       : v2.name,
            parent_id  : 0x1::option::none<0x2::object::ID>(),
            created_by : v1,
            timestamp  : v0,
        };
        0x2::event::emit<FolderCreated>(v3);
        v2
    }

    public fun create_subfolder(arg0: &mut Folder, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Folder {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = make_dir_key(&arg1);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v2), 204);
        let v3 = Folder{
            id         : 0x2::object::new(arg3),
            name       : arg1,
            parent_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<Folder>(arg0)),
            owner      : v1,
            created_at : v0,
            updated_at : v0,
            item_count : 0,
            version    : 1,
        };
        let v4 = 0x2::object::id<Folder>(&v3);
        let v5 = v3.name;
        let v6 = SubfolderRef{
            folder_id : v4,
            name      : v5,
        };
        0x2::dynamic_field::add<vector<u8>, SubfolderRef>(&mut arg0.id, v2, v6);
        arg0.item_count = arg0.item_count + 1;
        arg0.updated_at = v0;
        let v7 = FolderCreated{
            folder_id  : v4,
            name       : v5,
            parent_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<Folder>(arg0)),
            created_by : v1,
            timestamp  : v0,
        };
        0x2::event::emit<FolderCreated>(v7);
        let v8 = SubfolderLinked{
            parent_id  : 0x2::object::id<Folder>(arg0),
            child_id   : v4,
            child_name : v5,
            timestamp  : v0,
        };
        0x2::event::emit<SubfolderLinked>(v8);
        v3
    }

    public fun file_blob_id(arg0: &FileEntry) : 0x1::string::String {
        arg0.blob_id
    }

    public fun file_created_at(arg0: &FileEntry) : u64 {
        arg0.created_at
    }

    public fun file_created_by(arg0: &FileEntry) : 0x1::string::String {
        arg0.created_by
    }

    public fun file_mime_type(arg0: &FileEntry) : 0x1::string::String {
        arg0.mime_type
    }

    public fun file_name(arg0: &FileEntry) : 0x1::string::String {
        arg0.name
    }

    public fun file_size_bytes(arg0: &FileEntry) : u64 {
        arg0.size_bytes
    }

    public fun file_tags(arg0: &FileEntry) : vector<0x1::string::String> {
        arg0.tags
    }

    public fun folder_created_at(arg0: &Folder) : u64 {
        arg0.created_at
    }

    public fun folder_item_count(arg0: &Folder) : u64 {
        arg0.item_count
    }

    public fun folder_name(arg0: &Folder) : 0x1::string::String {
        arg0.name
    }

    public fun folder_owner(arg0: &Folder) : address {
        arg0.owner
    }

    public fun folder_parent_id(arg0: &Folder) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent_id
    }

    public fun folder_updated_at(arg0: &Folder) : u64 {
        arg0.updated_at
    }

    public fun get_file(arg0: &Folder, arg1: 0x1::string::String) : FileEntry {
        *0x2::dynamic_field::borrow<0x1::string::String, FileEntry>(&arg0.id, arg1)
    }

    public fun get_subfolder_ref(arg0: &Folder, arg1: 0x1::string::String) : SubfolderRef {
        *0x2::dynamic_field::borrow<vector<u8>, SubfolderRef>(&arg0.id, make_dir_key(&arg1))
    }

    public fun has_file(arg0: &Folder, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun has_subfolder(arg0: &Folder, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, make_dir_key(&arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FileSystemAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FileSystemAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun insert_file(arg0: &mut Folder, arg1: FileEntry, arg2: &0x2::clock::Clock) {
        let v0 = arg1.name;
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 201);
        0x2::dynamic_field::add<0x1::string::String, FileEntry>(&mut arg0.id, v0, arg1);
        arg0.item_count = arg0.item_count + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun is_root(arg0: &Folder) : bool {
        0x1::option::is_none<0x2::object::ID>(&arg0.parent_id)
    }

    fun make_dir_key(arg0: &0x1::string::String) : vector<u8> {
        let v0 = b"dir:";
        0x1::vector::append<u8>(&mut v0, *0x1::string::bytes(arg0));
        v0
    }

    public fun remove_file(arg0: &mut Folder, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : FileEntry {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1), 202);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::dynamic_field::remove<0x1::string::String, FileEntry>(&mut arg0.id, arg1);
        arg0.item_count = arg0.item_count - 1;
        arg0.updated_at = v0;
        let v2 = FileRemoved{
            folder_id  : 0x2::object::id<Folder>(arg0),
            file_name  : arg1,
            blob_id    : v1.blob_id,
            removed_by : 0x2::tx_context::sender(arg3),
            timestamp  : v0,
        };
        0x2::event::emit<FileRemoved>(v2);
        v1
    }

    public fun subfolder_id(arg0: &SubfolderRef) : 0x2::object::ID {
        arg0.folder_id
    }

    public fun subfolder_name(arg0: &SubfolderRef) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

