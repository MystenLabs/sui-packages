module 0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::chunk {
    struct CHUNK has drop {
        dummy_field: bool,
    }

    struct Chunk has store, key {
        id: 0x2::object::UID,
        data: vector<u8>,
        hash: vector<u8>,
        index: u16,
        size: u32,
    }

    struct CreateChunkCap has store, key {
        id: 0x2::object::UID,
        file_id: 0x2::object::ID,
        index: u16,
        hash: vector<u8>,
    }

    struct RegisterChunkCap has store, key {
        id: 0x2::object::UID,
        chunk_id: 0x2::object::ID,
        hash: vector<u8>,
        index: u16,
        size: u32,
    }

    struct VerifyChunkCap {
        chunk_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
    }

    struct ChunkCreatedEvent has copy, drop {
        chunk_id: 0x2::object::ID,
        chunk_index: u16,
        chunk_hash: vector<u8>,
        file_id: 0x2::object::ID,
    }

    struct ChunkVerifiedEvent has copy, drop {
        chunk_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
        register_chunk_cap_id: 0x2::object::ID,
    }

    public fun new(arg0: CreateChunkCap, arg1: &mut 0x2::tx_context::TxContext) : (Chunk, VerifyChunkCap) {
        let v0 = Chunk{
            id    : 0x2::object::new(arg1),
            data  : 0x1::vector::empty<u8>(),
            hash  : arg0.hash,
            index : arg0.index,
            size  : 0,
        };
        let v1 = ChunkCreatedEvent{
            chunk_id    : id(&v0),
            chunk_index : v0.index,
            chunk_hash  : v0.hash,
            file_id     : arg0.file_id,
        };
        0x2::event::emit<ChunkCreatedEvent>(v1);
        let v2 = VerifyChunkCap{
            chunk_id : 0x2::object::id<Chunk>(&v0),
            file_id  : arg0.file_id,
        };
        let CreateChunkCap {
            id      : v3,
            file_id : _,
            index   : _,
            hash    : _,
        } = arg0;
        0x2::object::delete(v3);
        (v0, v2)
    }

    public fun id(arg0: &Chunk) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_data(arg0: &mut Chunk, arg1: vector<vector<u8>>) {
        while (!0x1::vector::is_empty<vector<u8>>(&arg1)) {
            0x1::vector::append<u8>(&mut arg0.data, 0x1::vector::pop_back<vector<u8>>(&mut arg1));
        };
    }

    public fun data(arg0: &Chunk) : vector<u8> {
        arg0.data
    }

    public(friend) fun drop(arg0: Chunk) {
        let Chunk {
            id    : v0,
            data  : _,
            hash  : _,
            index : _,
            size  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun drop_create_chunk_cap(arg0: CreateChunkCap) {
        let CreateChunkCap {
            id      : v0,
            file_id : _,
            index   : _,
            hash    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun drop_register_chunk_cap(arg0: RegisterChunkCap) {
        let RegisterChunkCap {
            id       : v0,
            chunk_id : _,
            hash     : _,
            index    : _,
            size     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun hash(arg0: &Chunk) : vector<u8> {
        arg0.hash
    }

    public fun index(arg0: &Chunk) : u16 {
        arg0.index
    }

    fun init(arg0: CHUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHUNK>(arg0, arg1);
        let v1 = 0x2::display::new<Chunk>(&v0, arg1);
        0x2::display::add<Chunk>(&mut v1, 0x1::string::utf8(b"hash"), 0x1::string::utf8(b"{hash}"));
        0x2::display::add<Chunk>(&mut v1, 0x1::string::utf8(b"index"), 0x1::string::utf8(b"{index}"));
        0x2::display::add<Chunk>(&mut v1, 0x1::string::utf8(b"size"), 0x1::string::utf8(b"{size}"));
        0x2::transfer::public_transfer<0x2::display::Display<Chunk>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_create_chunk_cap(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : CreateChunkCap {
        CreateChunkCap{
            id      : 0x2::object::new(arg3),
            file_id : arg0,
            index   : arg2,
            hash    : arg1,
        }
    }

    public fun register_chunk_cap_hash(arg0: &RegisterChunkCap) : vector<u8> {
        arg0.hash
    }

    public fun register_chunk_cap_id(arg0: &RegisterChunkCap) : 0x2::object::ID {
        arg0.chunk_id
    }

    public fun register_chunk_cap_index(arg0: &RegisterChunkCap) : u16 {
        arg0.index
    }

    public fun register_chunk_cap_size(arg0: &RegisterChunkCap) : u32 {
        arg0.size
    }

    public fun size(arg0: &Chunk) : u32 {
        arg0.size
    }

    public fun verify(arg0: VerifyChunkCap, arg1: Chunk, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.chunk_id == 0x2::object::id<Chunk>(&arg1), 2);
        assert!(0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::utils::calculate_chunk_identifier_hash(arg1.index, 0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::utils::calculate_hash(&arg1.data)) == arg1.hash, 1);
        arg1.size = (0x1::vector::length<u8>(&arg1.data) as u32);
        let v0 = RegisterChunkCap{
            id       : 0x2::object::new(arg2),
            chunk_id : 0x2::object::id<Chunk>(&arg1),
            hash     : arg1.hash,
            index    : arg1.index,
            size     : arg1.size,
        };
        let v1 = ChunkVerifiedEvent{
            chunk_id              : id(&arg1),
            file_id               : arg0.file_id,
            register_chunk_cap_id : register_chunk_cap_id(&v0),
        };
        0x2::event::emit<ChunkVerifiedEvent>(v1);
        0x2::transfer::public_transfer<Chunk>(arg1, 0x2::object::id_to_address(&arg0.file_id));
        0x2::transfer::public_transfer<RegisterChunkCap>(v0, 0x2::object::id_to_address(&arg0.file_id));
        let VerifyChunkCap {
            chunk_id : _,
            file_id  : _,
        } = arg0;
    }

    // decompiled from Move bytecode v6
}

