module 0xf9ed7e35ec12ae14becc95d58ce52b220922321e66c05a3339b567a40c3d7c73::jarjar_fs {
    struct FileChunk has copy, drop, store {
        index: u64,
        data: vector<u8>,
    }

    struct File has key {
        id: 0x2::object::UID,
        owner: address,
        chunks: 0x2::vec_map::VecMap<u64, FileChunk>,
        chunk_order: 0x2::vec_set::VecSet<u64>,
        file_size: u64,
        file_name: 0x1::string::String,
        created_at: u64,
    }

    public fun add_chunk(arg0: &mut File, arg1: u64, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(!0x2::vec_set::contains<u64>(&arg0.chunk_order, &arg1), (1 as u64));
        let v0 = FileChunk{
            index : arg1,
            data  : arg2,
        };
        0x2::vec_map::insert<u64, FileChunk>(&mut arg0.chunks, arg1, v0);
        0x2::vec_set::insert<u64>(&mut arg0.chunk_order, arg1);
    }

    public fun chunk_count(arg0: &File) : u64 {
        0x2::vec_set::size<u64>(&arg0.chunk_order)
    }

    public fun create_file(arg0: u64, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = File{
            id          : 0x2::object::new(arg3),
            owner       : 0x2::tx_context::sender(arg3),
            chunks      : 0x2::vec_map::empty<u64, FileChunk>(),
            chunk_order : 0x2::vec_set::empty<u64>(),
            file_size   : arg0,
            file_name   : arg1,
            created_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<File>(v0, 0x2::tx_context::sender(arg3));
        0x2::object::id<File>(&v0)
    }

    public fun delete_file(arg0: File, arg1: &0x2::tx_context::TxContext) {
        let File {
            id          : v0,
            owner       : v1,
            chunks      : _,
            chunk_order : _,
            file_size   : _,
            file_name   : _,
            created_at  : _,
        } = arg0;
        assert!(0x2::tx_context::sender(arg1) == v1, 0);
        0x2::object::delete(v0);
    }

    public fun get_chunk(arg0: &File, arg1: u64) : FileChunk {
        assert!(0x2::vec_map::contains<u64, FileChunk>(&arg0.chunks, &arg1), (0 as u64));
        *0x2::vec_map::get<u64, FileChunk>(&arg0.chunks, &arg1)
    }

    public fun get_chunk_order(arg0: &File) : vector<u64> {
        0x2::vec_set::into_keys<u64>(arg0.chunk_order)
    }

    public fun get_file_info(arg0: &File) : (u64, 0x1::string::String, u64) {
        (arg0.file_size, arg0.file_name, arg0.created_at)
    }

    // decompiled from Move bytecode v6
}

