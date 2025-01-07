module 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::file {
    struct File has store, key {
        id: 0x2::object::UID,
        chunks: FileChunks,
        created_at: u64,
        extension: 0x1::string::String,
        mime_type: 0x1::string::String,
        size: u32,
    }

    struct FileChunks has store {
        count: u32,
        hash: vector<u8>,
        partitions: 0x2::vec_map::VecMap<vector<u8>, 0x1::option::Option<0x2::object::ID>>,
    }

    struct VerifyFileCap {
        file_id: 0x2::object::ID,
    }

    struct FileCreatedEvent has copy, drop {
        chunk_size: u32,
        created_at: u64,
        file_id: 0x2::object::ID,
        mime_type: 0x1::string::String,
        chunks_hash: vector<u8>,
    }

    struct ChunkRegisteredEvent has copy, drop {
        chunk_hash: vector<u8>,
        chunk_id: 0x2::object::ID,
        chunk_index: u16,
        file_id: 0x2::object::ID,
    }

    public fun destroy_empty(arg0: File) {
        assert!(0x2::vec_map::is_empty<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks.partitions), 1);
        let File {
            id         : v0,
            chunks     : v1,
            created_at : _,
            extension  : _,
            mime_type  : _,
            size       : _,
        } = arg0;
        0x2::object::delete(v0);
        let FileChunks {
            count      : _,
            hash       : _,
            partitions : v8,
        } = v1;
        0x2::vec_map::destroy_empty<vector<u8>, 0x1::option::Option<0x2::object::ID>>(v8);
    }

    public fun id(arg0: &File) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new(arg0: u32, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (File, VerifyFileCap) {
        assert!(arg0 <= 128000, 4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 2);
        let v0 = FileChunks{
            count      : 0,
            hash       : arg3,
            partitions : 0x2::vec_map::empty<vector<u8>, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = File{
            id         : 0x2::object::new(arg5),
            chunks     : v0,
            created_at : 0x2::clock::timestamp_ms(arg4),
            extension  : arg1,
            mime_type  : arg2,
            size       : 0,
        };
        0x2::dynamic_field::add<vector<u8>, vector<0x2::object::ID>>(&mut v1.id, b"create_chunk_cap_ids", 0x1::vector::empty<0x2::object::ID>());
        let v2 = VerifyFileCap{file_id: 0x2::object::uid_to_inner(&v1.id)};
        let v3 = FileCreatedEvent{
            chunk_size  : arg0,
            created_at  : v1.created_at,
            file_id     : 0x2::object::uid_to_inner(&v1.id),
            mime_type   : v1.mime_type,
            chunks_hash : v1.chunks.hash,
        };
        0x2::event::emit<FileCreatedEvent>(v3);
        (v1, v2)
    }

    public fun size(arg0: &File) : u32 {
        arg0.size
    }

    public fun add_chunk_hash(arg0: &VerifyFileCap, arg1: &mut File, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::CreateChunkCap {
        assert!(arg0.file_id == 0x2::object::id<File>(arg1), 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 2);
        let v0 = 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::new_create_chunk_cap(0x2::object::id<File>(arg1), arg2, (0x2::vec_map::size<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&arg1.chunks.partitions) as u16), arg3);
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<0x2::object::ID>>(&mut arg1.id, b"create_chunk_cap_ids"), 0x2::object::id<0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::CreateChunkCap>(&v0));
        0x2::vec_map::insert<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut arg1.chunks.partitions, arg2, 0x1::option::none<0x2::object::ID>());
        v0
    }

    public fun chunks_count(arg0: &File) : u32 {
        arg0.chunks.count
    }

    public fun chunks_hash(arg0: &File) : vector<u8> {
        arg0.chunks.hash
    }

    public fun chunks_partitions(arg0: &File) : 0x2::vec_map::VecMap<vector<u8>, 0x1::option::Option<0x2::object::ID>> {
        arg0.chunks.partitions
    }

    public fun created_at(arg0: &File) : u64 {
        arg0.created_at
    }

    public fun extension(arg0: &File) : 0x1::string::String {
        arg0.extension
    }

    public fun mime_type(arg0: &File) : 0x1::string::String {
        arg0.mime_type
    }

    public fun receive_and_delete_chunk(arg0: &mut File, arg1: 0x2::transfer::Receiving<0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::Chunk>) {
        let v0 = 0x2::transfer::public_receive<0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::Chunk>(&mut arg0.id, arg1);
        let v1 = 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::hash(&v0);
        let (_, _) = 0x2::vec_map::remove<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut arg0.chunks.partitions, &v1);
        0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::drop(v0);
    }

    public fun receive_and_register_chunk(arg0: &mut File, arg1: 0x2::transfer::Receiving<0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::RegisterChunkCap>) {
        let v0 = 0x2::transfer::public_receive<0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::RegisterChunkCap>(&mut arg0.id, arg1);
        let v1 = 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::register_chunk_cap_id(&v0);
        let v2 = 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::register_chunk_cap_hash(&v0);
        let v3 = ChunkRegisteredEvent{
            chunk_hash  : v2,
            chunk_id    : v1,
            chunk_index : 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::register_chunk_cap_index(&v0),
            file_id     : id(arg0),
        };
        0x2::event::emit<ChunkRegisteredEvent>(v3);
        0x1::option::fill<0x2::object::ID>(0x2::vec_map::get_mut<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut arg0.chunks.partitions, &v2), v1);
        arg0.size = arg0.size + 0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::register_chunk_cap_size(&v0);
        0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::chunk::drop_register_chunk_cap(v0);
    }

    public fun verify(arg0: VerifyFileCap, arg1: &File) {
        assert!(arg0.file_id == 0x2::object::id<File>(arg1), 3);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&arg1.chunks.partitions)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<vector<u8>, 0x1::option::Option<0x2::object::ID>>(&arg1.chunks.partitions, v1);
            0x1::vector::append<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        assert!(0x51bfc5ce4827d03da39c3bed8910fcc6995aa48c0d31ce5749a05ae546485864::utils::calculate_hash(&v0) == arg1.chunks.hash, 5);
        let VerifyFileCap {  } = arg0;
    }

    // decompiled from Move bytecode v6
}

