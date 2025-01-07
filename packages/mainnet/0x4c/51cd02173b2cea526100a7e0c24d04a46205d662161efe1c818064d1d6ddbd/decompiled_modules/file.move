module 0x4c51cd02173b2cea526100a7e0c24d04a46205d662161efe1c818064d1d6ddbd::file {
    struct File has store, key {
        id: 0x2::object::UID,
        name: 0x1::option::Option<0x1::string::String>,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        hash: 0x1::string::String,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct FileChunkTest has store, key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        data: vector<0x1::string::String>,
    }

    struct FileChunk has store, key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        data: vector<u8>,
    }

    struct CreateFileChunkCap has key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        file_id: 0x2::object::ID,
    }

    struct RegisterFileChunkCap has key {
        id: 0x2::object::UID,
        file_id: 0x2::object::ID,
        chunk_id: 0x2::object::ID,
        chunk_hash: 0x1::string::String,
    }

    struct FileCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct CreateFileChunkCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        hash: 0x1::string::String,
    }

    struct FileChunkCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        file_id: 0x2::object::ID,
        hash: 0x1::string::String,
        index: u64,
    }

    public fun create_file_chunk(arg0: CreateFileChunkCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(0x2::hash::blake2b256(&arg1));
        let v1 = FileChunk{
            id   : 0x2::object::new(arg2),
            hash : v0,
            data : arg1,
        };
        let v2 = RegisterFileChunkCap{
            id         : 0x2::object::new(arg2),
            file_id    : arg0.file_id,
            chunk_id   : 0x2::object::id<FileChunk>(&v1),
            chunk_hash : v0,
        };
        0x2::transfer::transfer<FileChunk>(v1, 0x2::object::id_to_address(&arg0.file_id));
        0x2::transfer::transfer<RegisterFileChunkCap>(v2, 0x2::object::id_to_address(&arg0.file_id));
        let CreateFileChunkCap {
            id      : v3,
            hash    : _,
            file_id : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    public fun create_file_chunk_test(arg0: vector<0x1::string::String>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FileChunkTest{
            id   : 0x2::object::new(arg2),
            hash : arg1,
            data : arg0,
        };
        0x2::transfer::transfer<FileChunkTest>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun initialize_file(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : File {
        let v0 = File{
            id        : 0x2::object::new(arg5),
            name      : 0x1::option::none<0x1::string::String>(),
            encoding  : arg0,
            mime_type : arg1,
            extension : arg2,
            hash      : arg3,
            chunks    : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<0x1::string::String>(&arg4)) {
            let v2 = 0x1::vector::remove<0x1::string::String>(&mut arg4, 0);
            0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v0.chunks, v2, 0x1::option::none<0x2::object::ID>());
            let v3 = CreateFileChunkCap{
                id      : 0x2::object::new(arg5),
                hash    : v2,
                file_id : 0x2::object::id<File>(&v0),
            };
            let v4 = CreateFileChunkCapCreatedEvent{
                id   : 0x2::object::id<CreateFileChunkCap>(&v3),
                hash : v2,
            };
            0x2::event::emit<CreateFileChunkCapCreatedEvent>(v4);
            0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0x2::object::id<CreateFileChunkCap>(&v3));
            0x2::transfer::transfer<CreateFileChunkCap>(v3, 0x2::object::uid_to_address(&v0.id));
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v0.id, 0x1::string::utf8(b"create_file_chunk_cap_ids"), v1);
        let v5 = FileCreatedEvent{id: 0x2::object::id<File>(&v0)};
        0x2::event::emit<FileCreatedEvent>(v5);
        v0
    }

    public fun receive_create_file_chunk_cap(arg0: &mut File, arg1: 0x2::transfer::Receiving<CreateFileChunkCap>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<CreateFileChunkCap>(0x2::transfer::receive<CreateFileChunkCap>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

