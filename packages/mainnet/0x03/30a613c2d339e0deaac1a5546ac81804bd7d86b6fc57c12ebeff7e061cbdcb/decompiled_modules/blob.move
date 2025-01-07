module 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::blob {
    struct Blob has store, key {
        id: 0x2::object::UID,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
        file_id: 0x2::object::ID,
    }

    struct BlobChunk has key {
        id: 0x2::object::UID,
        data: vector<0x1::string::String>,
        hash: 0x1::string::String,
        index: u64,
    }

    struct CreateBlobChunkCap has key {
        id: 0x2::object::UID,
        blob_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
        hash: 0x1::string::String,
        index: u64,
    }

    struct DeleteBlobPromise {
        blob_id: 0x2::object::ID,
    }

    struct RegisterFileChunkCap has key {
        id: 0x2::object::UID,
        blob_chunk_id: 0x2::object::ID,
        blob_chunk_hash: 0x1::string::String,
        blob_id: 0x2::object::ID,
        create_blob_chunk_cap_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
    }

    struct BlobCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        file_id: 0x2::object::ID,
    }

    struct BlobChunkCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        blob_id: 0x2::object::ID,
        file_id: 0x2::object::ID,
        hash: 0x1::string::String,
        index: u64,
    }

    struct CreateBlobChunkCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        hash: 0x1::string::String,
        index: u64,
    }

    public fun create_blob(arg0: vector<0x1::string::String>, arg1: &0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file::File, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Blob{
            id      : 0x2::object::new(arg2),
            chunks  : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
            file_id : 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file::file_id(arg1),
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg0)) {
            let v3 = 0x1::vector::remove<0x1::string::String>(&mut arg0, 0);
            0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v0.chunks, v3, 0x1::option::none<0x2::object::ID>());
            let v4 = CreateBlobChunkCap{
                id      : 0x2::object::new(arg2),
                blob_id : 0x2::object::id<Blob>(&v0),
                file_id : 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file::file_id(arg1),
                hash    : v3,
                index   : v2,
            };
            let v5 = CreateBlobChunkCapCreatedEvent{
                id    : 0x2::object::id<CreateBlobChunkCap>(&v4),
                hash  : v3,
                index : v2,
            };
            0x2::event::emit<CreateBlobChunkCapCreatedEvent>(v5);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<CreateBlobChunkCap>(&v4));
            0x2::transfer::transfer<CreateBlobChunkCap>(v4, 0x2::object::uid_to_address(&v0.id));
            v2 = v2 + 1;
        };
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::object::ID>>(&mut v0.id, 0x1::string::utf8(b"create_blob_chunk_cap_ids"), v1);
        let v6 = BlobCreatedEvent{
            id      : 0x2::object::id<Blob>(&v0),
            file_id : 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file::file_id(arg1),
        };
        0x2::event::emit<BlobCreatedEvent>(v6);
        0x2::transfer::transfer<Blob>(v0, 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file::file_address(arg1));
    }

    public fun create_blob_chunk(arg0: CreateBlobChunkCap, arg1: vector<0x1::string::String>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.hash;
        if (arg2 == true) {
            let v1 = 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::utils::calculate_hash_for_string(0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::utils::concatenate_strings(arg1));
            v0 = v1;
            assert!(v1 == arg0.hash, 1);
        };
        let v2 = BlobChunk{
            id    : 0x2::object::new(arg3),
            data  : arg1,
            hash  : v0,
            index : arg0.index,
        };
        let v3 = BlobChunkCreatedEvent{
            id      : 0x2::object::id<BlobChunk>(&v2),
            blob_id : arg0.blob_id,
            file_id : arg0.file_id,
            hash    : v0,
            index   : arg0.index,
        };
        0x2::event::emit<BlobChunkCreatedEvent>(v3);
        let v4 = RegisterFileChunkCap{
            id                       : 0x2::object::new(arg3),
            blob_chunk_id            : 0x2::object::id<BlobChunk>(&v2),
            blob_chunk_hash          : v0,
            blob_id                  : arg0.blob_id,
            create_blob_chunk_cap_id : 0x2::object::id<CreateBlobChunkCap>(&arg0),
            file_id                  : arg0.file_id,
        };
        0x2::transfer::transfer<BlobChunk>(v2, 0x2::object::id_to_address(&arg0.blob_id));
        0x2::transfer::transfer<RegisterFileChunkCap>(v4, 0x2::object::id_to_address(&arg0.blob_id));
        let CreateBlobChunkCap {
            id      : v5,
            blob_id : _,
            file_id : _,
            hash    : _,
            index   : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun delete_blob(arg0: Blob, arg1: DeleteBlobPromise) {
        assert!(0x2::object::id<Blob>(&arg0) == arg1.blob_id, 1);
        assert!(0x2::vec_map::is_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks), 1);
        let Blob {
            id      : v0,
            chunks  : v1,
            file_id : _,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(v1);
        0x2::object::delete(v0);
        let DeleteBlobPromise {  } = arg1;
    }

    // decompiled from Move bytecode v6
}

