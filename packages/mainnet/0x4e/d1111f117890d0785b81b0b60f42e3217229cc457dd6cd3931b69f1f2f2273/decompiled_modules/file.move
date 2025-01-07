module 0x4ed1111f117890d0785b81b0b60f42e3217229cc457dd6cd3931b69f1f2f2273::file {
    struct File has store, key {
        id: 0x2::object::UID,
        name: 0x1::option::Option<0x1::string::String>,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        hash: 0x1::string::String,
        delivery_metadata: FileDeliveryMetadata,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct FileDeliveryMetadata has store {
        chunk_size: u8,
        sublist_size: u16,
    }

    struct FileChunk has store, key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct FileChunkTest has store, key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        data: vector<0x1::string::String>,
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

    public fun create_file_chunk(arg0: CreateFileChunkCap, arg1: vector<0x1::string::String>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = concatenate_string_vector(arg1);
        let v1 = arg0.hash;
        if (arg2 == true) {
            let v2 = calculate_hash_for_string(v0);
            v1 = v2;
            assert!(v2 == arg0.hash, 1);
        };
        let v3 = FileChunk{
            id   : 0x2::object::new(arg3),
            hash : v1,
            data : v0,
        };
        let v4 = RegisterFileChunkCap{
            id         : 0x2::object::new(arg3),
            file_id    : arg0.file_id,
            chunk_id   : 0x2::object::id<FileChunk>(&v3),
            chunk_hash : v1,
        };
        0x2::transfer::transfer<FileChunk>(v3, 0x2::object::id_to_address(&arg0.file_id));
        0x2::transfer::transfer<RegisterFileChunkCap>(v4, 0x2::object::id_to_address(&arg0.file_id));
        let CreateFileChunkCap {
            id      : v5,
            hash    : _,
            file_id : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun create_file_chunk_test(arg0: vector<0x1::string::String>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FileChunkTest{
            id   : 0x2::object::new(arg2),
            hash : arg1,
            data : arg0,
        };
        0x2::transfer::transfer<FileChunkTest>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun initialize_file(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u16, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : File {
        let v0 = FileDeliveryMetadata{
            chunk_size   : arg4,
            sublist_size : arg5,
        };
        let v1 = File{
            id                : 0x2::object::new(arg7),
            name              : 0x1::option::none<0x1::string::String>(),
            encoding          : arg0,
            mime_type         : arg1,
            extension         : arg2,
            hash              : arg3,
            delivery_metadata : v0,
            chunks            : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v2 = 0x2::vec_set::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<0x1::string::String>(&arg6)) {
            let v3 = 0x1::vector::remove<0x1::string::String>(&mut arg6, 0);
            0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v1.chunks, v3, 0x1::option::none<0x2::object::ID>());
            let v4 = CreateFileChunkCap{
                id      : 0x2::object::new(arg7),
                hash    : v3,
                file_id : 0x2::object::id<File>(&v1),
            };
            let v5 = CreateFileChunkCapCreatedEvent{
                id   : 0x2::object::id<CreateFileChunkCap>(&v4),
                hash : v3,
            };
            0x2::event::emit<CreateFileChunkCapCreatedEvent>(v5);
            0x2::vec_set::insert<0x2::object::ID>(&mut v2, 0x2::object::id<CreateFileChunkCap>(&v4));
            0x2::transfer::transfer<CreateFileChunkCap>(v4, 0x2::object::uid_to_address(&v1.id));
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v1.id, 0x1::string::utf8(b"create_file_chunk_cap_ids"), v2);
        let v6 = FileCreatedEvent{id: 0x2::object::id<File>(&v1)};
        0x2::event::emit<FileCreatedEvent>(v6);
        v1
    }

    public fun receive_create_file_chunk_cap(arg0: &mut File, arg1: 0x2::transfer::Receiving<CreateFileChunkCap>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<CreateFileChunkCap>(0x2::transfer::receive<CreateFileChunkCap>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

