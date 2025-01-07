module 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file_old {
    struct File has store, key {
        id: 0x2::object::UID,
        name: 0x1::option::Option<0x1::string::String>,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        size: u64,
        created_at_ts: u64,
        hash: 0x1::string::String,
        config: FileConfig,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct FileConfig has drop, store {
        chunk_size: u8,
        sublist_size: u16,
        compression_algorithm: 0x1::option::Option<0x1::string::String>,
        compression_level: 0x1::option::Option<u8>,
    }

    struct FileChunk has key {
        id: 0x2::object::UID,
        index: u64,
        hash: 0x1::string::String,
        data: vector<0x1::string::String>,
    }

    struct CreateFileChunkCap has store, key {
        id: 0x2::object::UID,
        index: u64,
        hash: 0x1::string::String,
        file_id: 0x2::object::ID,
    }

    struct RegisterFileChunkCap has key {
        id: 0x2::object::UID,
        file_id: 0x2::object::ID,
        chunk_id: 0x2::object::ID,
        chunk_hash: 0x1::string::String,
        created_with: 0x2::object::ID,
    }

    struct FileCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreateFileChunkCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        index: u64,
        hash: 0x1::string::String,
    }

    struct FileChunkCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        file_id: 0x2::object::ID,
        index: u64,
        hash: 0x1::string::String,
    }

    struct DeleteFilePromise {
        file_id: 0x2::object::ID,
    }

    fun calculate_hash_for_string(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(0x2::hash::blake2b256(0x1::string::bytes(&arg0))))
    }

    fun concatenate_string_vector(arg0: vector<0x1::string::String>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        while (!0x1::vector::is_empty<0x1::string::String>(&arg0)) {
            0x1::string::append(&mut v0, 0x1::vector::remove<0x1::string::String>(&mut arg0, 0));
        };
        v0
    }

    public fun create_file(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: FileConfig, arg6: vector<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : File {
        let v0 = File{
            id            : 0x2::object::new(arg8),
            name          : 0x1::option::none<0x1::string::String>(),
            encoding      : arg0,
            mime_type     : arg1,
            extension     : arg2,
            size          : arg3,
            created_at_ts : 0x2::clock::timestamp_ms(arg7),
            hash          : arg4,
            config        : arg5,
            chunks        : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        let v2 = 0;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg6)) {
            let v3 = 0x1::vector::remove<0x1::string::String>(&mut arg6, 0);
            0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v0.chunks, v3, 0x1::option::none<0x2::object::ID>());
            let v4 = CreateFileChunkCap{
                id      : 0x2::object::new(arg8),
                index   : v2,
                hash    : v3,
                file_id : 0x2::object::id<File>(&v0),
            };
            let v5 = CreateFileChunkCapCreatedEvent{
                id    : 0x2::object::id<CreateFileChunkCap>(&v4),
                index : v2,
                hash  : v3,
            };
            0x2::event::emit<CreateFileChunkCapCreatedEvent>(v5);
            0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0x2::object::id<CreateFileChunkCap>(&v4));
            0x2::transfer::transfer<CreateFileChunkCap>(v4, 0x2::object::uid_to_address(&v0.id));
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_file_chunk(arg0: CreateFileChunkCap, arg1: vector<0x1::string::String>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.hash;
        if (arg2 == true) {
            let v1 = calculate_hash_for_string(concatenate_string_vector(arg1));
            v0 = v1;
            assert!(v1 == arg0.hash, 1);
        };
        let v2 = FileChunk{
            id    : 0x2::object::new(arg3),
            index : arg0.index,
            hash  : v0,
            data  : arg1,
        };
        let v3 = FileChunkCreatedEvent{
            id      : 0x2::object::id<FileChunk>(&v2),
            file_id : arg0.file_id,
            index   : arg0.index,
            hash    : v0,
        };
        0x2::event::emit<FileChunkCreatedEvent>(v3);
        let v4 = RegisterFileChunkCap{
            id           : 0x2::object::new(arg3),
            file_id      : arg0.file_id,
            chunk_id     : 0x2::object::id<FileChunk>(&v2),
            chunk_hash   : v0,
            created_with : 0x2::object::id<CreateFileChunkCap>(&arg0),
        };
        0x2::transfer::transfer<FileChunk>(v2, 0x2::object::id_to_address(&arg0.file_id));
        0x2::transfer::transfer<RegisterFileChunkCap>(v4, 0x2::object::id_to_address(&arg0.file_id));
        let CreateFileChunkCap {
            id      : v5,
            index   : _,
            hash    : _,
            file_id : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun create_file_config(arg0: u8, arg1: u16, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<u8>) : FileConfig {
        FileConfig{
            chunk_size            : arg0,
            sublist_size          : arg1,
            compression_algorithm : arg2,
            compression_level     : arg3,
        }
    }

    public fun delete_file(arg0: File, arg1: DeleteFilePromise) {
        assert!(0x2::object::id<File>(&arg0) == arg1.file_id, 2);
        assert!(0x2::vec_map::is_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks), 3);
        let File {
            id            : v0,
            name          : _,
            encoding      : _,
            mime_type     : _,
            extension     : _,
            size          : _,
            created_at_ts : _,
            hash          : _,
            config        : _,
            chunks        : v9,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(v9);
        0x2::object::delete(v0);
        let DeleteFilePromise {  } = arg1;
    }

    public fun receive_create_file_chunk_cap(arg0: &mut File, arg1: 0x2::transfer::Receiving<CreateFileChunkCap>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<CreateFileChunkCap>(0x2::transfer::receive<CreateFileChunkCap>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun register_file_chunk(arg0: &mut File, arg1: 0x2::transfer::Receiving<RegisterFileChunkCap>) {
        let v0 = 0x2::transfer::receive<RegisterFileChunkCap>(&mut arg0.id, arg1);
        0x1::option::fill<0x2::object::ID>(0x2::vec_map::get_mut<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut arg0.chunks, &v0.chunk_hash), v0.chunk_id);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, 0x1::string::utf8(b"create_file_chunk_cap_ids"));
        0x2::vec_set::remove<0x2::object::ID>(v1, &v0.created_with);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v1)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, 0x1::string::utf8(b"create_file_chunk_cap_ids"));
        };
        let RegisterFileChunkCap {
            id           : v2,
            file_id      : _,
            chunk_id     : _,
            chunk_hash   : _,
            created_with : _,
        } = v0;
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

