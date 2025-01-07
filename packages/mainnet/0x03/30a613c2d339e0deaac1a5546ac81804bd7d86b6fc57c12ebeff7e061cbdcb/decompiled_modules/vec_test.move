module 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::vec_test {
    struct Chunk has store, key {
        id: 0x2::object::UID,
        data: vector<vector<u8>>,
        length: u64,
        hash: u256,
    }

    struct ChunkStr has store, key {
        id: 0x2::object::UID,
        data: vector<0x1::string::String>,
        length: u64,
        hash: u256,
    }

    struct VerifyChunkCap {
        chunk_id: 0x2::object::ID,
        verify: bool,
    }

    struct RegisterChunkCap has store, key {
        id: 0x2::object::UID,
        chunk_hash: u256,
        chunk_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
    }

    struct File has store, key {
        id: 0x2::object::UID,
        chunks: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    public fun new(arg0: bool, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : (Chunk, VerifyChunkCap) {
        let v0 = Chunk{
            id     : 0x2::object::new(arg2),
            data   : vector[],
            length : 0,
            hash   : arg1,
        };
        let v1 = VerifyChunkCap{
            chunk_id : 0x2::object::id<Chunk>(&v0),
            verify   : arg0,
        };
        (v0, v1)
    }

    public fun confirm(arg0: VerifyChunkCap, arg1: &mut Chunk) {
        assert!(0x2::object::id<Chunk>(arg1) == arg0.chunk_id, 1);
        if (arg0.verify == true) {
            let v0 = b"";
            let v1 = 0;
            while (v1 < 0x1::vector::length<vector<u8>>(&arg1.data)) {
                0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg1.data, v1));
                v1 = v1 + 1;
            };
            assert!(arg1.hash == hash_to_u256(&v0), 1);
        };
        let VerifyChunkCap {
            chunk_id : _,
            verify   : _,
        } = arg0;
    }

    fun hash_to_u256(arg0: &vector<u8>) : u256 {
        0x2::address::to_u256(0x2::address::from_bytes(0x2::hash::blake2b256(arg0)))
    }

    public fun insert(arg0: &mut Chunk, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.data, arg1);
        arg0.length = arg0.length + 0x1::vector::length<u8>(&arg1);
    }

    // decompiled from Move bytecode v6
}

