module 0x6e4f5133885021c9d5d4e7c3babd189d60fb1bd3ffa95ece3c207532de337609::image {
    struct IMAGE has drop {
        dummy_field: bool,
    }

    struct CreateImageCap has store, key {
        id: 0x2::object::UID,
        number: u64,
        level: u8,
        ref: 0x2::object::ID,
    }

    struct CreateImageChunkCap has key {
        id: 0x2::object::UID,
        number: u64,
        level: u8,
        index: u8,
        hash: 0x1::string::String,
        image_id: 0x2::object::ID,
    }

    struct DeleteImagePromise {
        image_id: 0x2::object::ID,
    }

    struct Image has store, key {
        id: 0x2::object::UID,
        number: u64,
        level: u8,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        created_with: 0x2::object::ID,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct ImageChunk has key {
        id: 0x2::object::UID,
        image_id: 0x2::object::ID,
        number: u64,
        hash: 0x1::string::String,
        index: u8,
        data: 0x1::string::String,
    }

    struct RegisterImageChunkCap has key {
        id: 0x2::object::UID,
        image_id: 0x2::object::ID,
        chunk_id: 0x2::object::ID,
        chunk_hash: 0x1::string::String,
        created_with: 0x2::object::ID,
    }

    struct CreateImageCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        level: u8,
    }

    struct CreateImageChunkCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        level: u8,
        index: u8,
        hash: 0x1::string::String,
        image_id: 0x2::object::ID,
    }

    struct ImageCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        level: u8,
    }

    struct ImageChunkCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        hash: 0x1::string::String,
        index: u8,
        image_id: 0x2::object::ID,
    }

    public(friend) fun id(arg0: &Image) : 0x2::object::ID {
        0x2::object::id<Image>(arg0)
    }

    public fun create_and_transfer_image_chunk(arg0: CreateImageChunkCap, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        while (!0x1::vector::is_empty<0x1::string::String>(&arg1)) {
            0x1::string::append(&mut v0, 0x1::vector::remove<0x1::string::String>(&mut arg1, 0));
        };
        let v1 = 0x1::string::utf8(0x2::hex::encode(0x1::hash::sha2_256(*0x1::string::as_bytes(&v0))));
        assert!(v1 == arg0.hash, 1);
        let v2 = ImageChunk{
            id       : 0x2::object::new(arg2),
            image_id : arg0.image_id,
            number   : arg0.number,
            hash     : v1,
            index    : arg0.index,
            data     : v0,
        };
        let v3 = RegisterImageChunkCap{
            id           : 0x2::object::new(arg2),
            image_id     : arg0.image_id,
            chunk_id     : 0x2::object::id<ImageChunk>(&v2),
            chunk_hash   : v1,
            created_with : 0x2::object::id<CreateImageChunkCap>(&arg0),
        };
        let v4 = ImageChunkCreatedEvent{
            id       : 0x2::object::id<ImageChunk>(&v2),
            number   : arg0.number,
            hash     : v1,
            index    : arg0.index,
            image_id : arg0.image_id,
        };
        0x2::event::emit<ImageChunkCreatedEvent>(v4);
        0x2::transfer::transfer<ImageChunk>(v2, 0x2::object::id_to_address(&arg0.image_id));
        0x2::transfer::transfer<RegisterImageChunkCap>(v3, 0x2::object::id_to_address(&arg0.image_id));
        let CreateImageChunkCap {
            id       : v5,
            number   : _,
            level    : _,
            index    : _,
            hash     : _,
            image_id : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun create_image(arg0: CreateImageCap, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Image{
            id           : 0x2::object::new(arg2),
            number       : arg0.number,
            level        : arg0.level,
            encoding     : 0x1::string::utf8(b"base85"),
            mime_type    : 0x1::string::utf8(b"image/avif"),
            extension    : 0x1::string::utf8(b"avif"),
            created_with : 0x2::object::id<CreateImageCap>(&arg0),
            chunks       : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<0x1::string::String>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            let v3 = CreateImageChunkCap{
                id       : 0x2::object::new(arg2),
                number   : arg0.number,
                level    : arg0.level,
                index    : (0x1::vector::length<0x1::string::String>(&arg1) as u8),
                hash     : v2,
                image_id : 0x2::object::id<Image>(&v0),
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v0.chunks, v2, 0x1::option::none<0x2::object::ID>());
            0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0x2::object::id<CreateImageChunkCap>(&v3));
            0x2::transfer::transfer<CreateImageChunkCap>(v3, 0x2::tx_context::sender(arg2));
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v0.id, 0x1::string::utf8(b"create_image_chunk_cap_ids"), v1);
        let CreateImageCap {
            id     : v4,
            number : _,
            level  : _,
            ref    : _,
        } = arg0;
        0x2::object::delete(v4);
        0x2::transfer::transfer<Image>(v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun create_image_cap_id(arg0: &CreateImageCap) : 0x2::object::ID {
        0x2::object::id<CreateImageCap>(arg0)
    }

    public fun delete_image(arg0: Image, arg1: DeleteImagePromise) {
        assert!(0x2::object::id<Image>(&arg0) == arg1.image_id, 4);
        assert!(0x2::vec_map::is_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks), 3);
        let Image {
            id           : v0,
            number       : _,
            level        : _,
            encoding     : _,
            mime_type    : _,
            extension    : _,
            created_with : _,
            chunks       : v7,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(v7);
        0x2::object::delete(v0);
        let DeleteImagePromise {  } = arg1;
    }

    fun init(arg0: IMAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IMAGE>(arg0, arg1);
        let v1 = 0x2::display::new<ImageChunk>(&v0, arg1);
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Chakra #{number} Image Chunk"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An image chunk for Chakra #{number}."));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://source.boomplaymusic.com/buzzgroup1/M00/18/E5/rBEevF_cRkmALJL2AADixAQNp4M606.jpg"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"image_id"), 0x1::string::utf8(b"{image_id}"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"hash"), 0x1::string::utf8(b"{hash}"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"index"), 0x1::string::utf8(b"{index}"));
        0x2::display::add<ImageChunk>(&mut v1, 0x1::string::utf8(b"data"), 0x1::string::utf8(b"{data}"));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ImageChunk>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun issue_create_image_cap(arg0: u64, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : CreateImageCap {
        let v0 = CreateImageCap{
            id     : 0x2::object::new(arg3),
            number : arg0,
            level  : arg1,
            ref    : arg2,
        };
        let v1 = CreateImageCapCreatedEvent{
            id     : 0x2::object::id<CreateImageCap>(&v0),
            number : arg0,
            level  : arg1,
        };
        0x2::event::emit<CreateImageCapCreatedEvent>(v1);
        v0
    }

    public(friend) fun issue_delete_image_promise(arg0: &Image) : DeleteImagePromise {
        DeleteImagePromise{image_id: 0x2::object::id<Image>(arg0)}
    }

    public(friend) fun level(arg0: &Image) : u8 {
        arg0.level
    }

    public(friend) fun number(arg0: &Image) : u64 {
        arg0.number
    }

    public fun receive_and_destroy_image_chunk(arg0: &mut Image, arg1: 0x2::transfer::Receiving<ImageChunk>) {
        let v0 = 0x2::transfer::receive<ImageChunk>(&mut arg0.id, arg1);
        let (_, v2) = 0x2::vec_map::remove<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut arg0.chunks, &v0.hash);
        0x1::option::destroy_some<0x2::object::ID>(v2);
        let ImageChunk {
            id       : v3,
            image_id : _,
            number   : _,
            hash     : _,
            index    : _,
            data     : _,
        } = v0;
        0x2::object::delete(v3);
    }

    public fun receive_and_register_image_chunk(arg0: &mut Image, arg1: 0x2::transfer::Receiving<RegisterImageChunkCap>) {
        let v0 = 0x2::transfer::receive<RegisterImageChunkCap>(&mut arg0.id, arg1);
        assert!(v0.image_id == 0x2::object::id<Image>(arg0), 5);
        0x1::option::fill<0x2::object::ID>(0x2::vec_map::get_mut<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut arg0.chunks, &v0.chunk_hash), v0.chunk_id);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, 0x1::string::utf8(b"create_image_chunk_cap_ids"));
        0x2::vec_set::remove<0x2::object::ID>(v1, &v0.created_with);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v1)) {
            0x1::vector::destroy_empty<0x2::object::ID>(0x2::vec_set::into_keys<0x2::object::ID>(0x2::dynamic_field::remove<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, 0x1::string::utf8(b"create_image_chunk_cap_ids"))));
        };
        let RegisterImageChunkCap {
            id           : v2,
            image_id     : _,
            chunk_id     : _,
            chunk_hash   : _,
            created_with : _,
        } = v0;
        0x2::object::delete(v2);
    }

    public(friend) fun verify_image_chunks_registered(arg0: &Image) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks);
        while (!0x1::vector::is_empty<0x1::string::String>(&v0)) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut v0);
            assert!(0x1::option::is_some<0x2::object::ID>(0x2::vec_map::get<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.chunks, &v1)), 2);
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
    }

    // decompiled from Move bytecode v6
}

