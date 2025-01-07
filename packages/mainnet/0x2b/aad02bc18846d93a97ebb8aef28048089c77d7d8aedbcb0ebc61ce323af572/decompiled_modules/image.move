module 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image {
    struct IMAGE has drop {
        dummy_field: bool,
    }

    struct Image has store, key {
        id: 0x2::object::UID,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        content: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct ImageContent has key {
        id: 0x2::object::UID,
        image_id: 0x2::object::ID,
        hash: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct CreateImageContentCap has key {
        id: 0x2::object::UID,
        hash: 0x1::string::String,
        image_id: 0x2::object::ID,
    }

    struct RegisterImageContentCap has key {
        id: 0x2::object::UID,
        image_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        content_hash: 0x1::string::String,
        created_with: 0x2::object::ID,
    }

    struct DeleteImagePromise {
        image_id: 0x2::object::ID,
    }

    struct CreateImageContentCapCreated has copy, drop {
        id: 0x2::object::ID,
        hash: 0x1::string::String,
        image_id: 0x2::object::ID,
    }

    struct ImageCreated has copy, drop {
        id: 0x2::object::ID,
    }

    struct ImageContentCreated has copy, drop {
        id: 0x2::object::ID,
        hash: 0x1::string::String,
        image_id: 0x2::object::ID,
    }

    fun create_and_transfer_image_content(arg0: CreateImageContentCap, arg1: vector<0x1::string::String>, arg2: &mut Image, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        while (!0x1::vector::is_empty<0x1::string::String>(&arg1)) {
            0x1::string::append(&mut v0, 0x1::vector::remove<0x1::string::String>(&mut arg1, 0));
        };
        let v1 = 0x1::string::utf8(0x2::hex::encode(0x1::hash::sha2_256(*0x1::string::bytes(&v0))));
        assert!(v1 == arg0.hash, 1);
        let v2 = ImageContent{
            id       : 0x2::object::new(arg3),
            image_id : arg0.image_id,
            hash     : v1,
            data     : v0,
        };
        let v3 = RegisterImageContentCap{
            id           : 0x2::object::new(arg3),
            image_id     : arg0.image_id,
            content_id   : 0x2::object::id<ImageContent>(&v2),
            content_hash : v1,
            created_with : 0x2::object::id<CreateImageContentCap>(&arg0),
        };
        let v4 = ImageContentCreated{
            id       : 0x2::object::id<ImageContent>(&v2),
            hash     : v1,
            image_id : arg0.image_id,
        };
        0x2::event::emit<ImageContentCreated>(v4);
        0x2::transfer::transfer<ImageContent>(v2, 0x2::object::id_to_address(&arg0.image_id));
        let CreateImageContentCap {
            id       : v5,
            hash     : _,
            image_id : _,
        } = arg0;
        0x2::object::delete(v5);
        register_image_content(v3, arg2);
    }

    public fun create_image(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) : Image {
        let v0 = Image{
            id        : 0x2::object::new(arg2),
            encoding  : 0x1::string::utf8(b"base85"),
            mime_type : 0x1::string::utf8(b"image/avif"),
            extension : 0x1::string::utf8(b"avif"),
            content   : 0x2::vec_map::empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(),
        };
        let v1 = CreateImageContentCap{
            id       : 0x2::object::new(arg2),
            hash     : arg0,
            image_id : 0x2::object::id<Image>(&v0),
        };
        let v2 = CreateImageContentCapCreated{
            id       : 0x2::object::id<CreateImageContentCap>(&v1),
            hash     : arg0,
            image_id : 0x2::object::id<Image>(&v0),
        };
        0x2::event::emit<CreateImageContentCapCreated>(v2);
        0x2::vec_map::insert<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut v0.content, arg0, 0x1::option::none<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut v0.id, 0x1::string::utf8(b"create_image_content_cap_id"), 0x2::object::id<CreateImageContentCap>(&v1));
        let v3 = ImageCreated{id: 0x2::object::id<Image>(&v0)};
        0x2::event::emit<ImageCreated>(v3);
        let v4 = &mut v0;
        create_and_transfer_image_content(v1, arg1, v4, arg2);
        v0
    }

    public fun delete_image(arg0: Image, arg1: DeleteImagePromise) {
        assert!(0x2::object::id<Image>(&arg0) == arg1.image_id, 3);
        assert!(0x2::vec_map::is_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.content), 4);
        let Image {
            id        : v0,
            encoding  : _,
            mime_type : _,
            extension : _,
            content   : v4,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(v4);
        0x2::object::delete(v0);
        let DeleteImagePromise {  } = arg1;
    }

    public fun delete_image_content(arg0: &mut Image, arg1: ImageContent) {
        let (_, v1) = 0x2::vec_map::remove<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut arg0.content, &arg1.hash);
        0x1::option::destroy_some<0x2::object::ID>(v1);
        let ImageContent {
            id       : v2,
            image_id : _,
            hash     : _,
            data     : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public(friend) fun issue_delete_image_promise(arg0: &Image) : DeleteImagePromise {
        DeleteImagePromise{image_id: 0x2::object::id<Image>(arg0)}
    }

    fun register_image_content(arg0: RegisterImageContentCap, arg1: &mut Image) {
        assert!(arg0.image_id == 0x2::object::id<Image>(arg1), 2);
        0x1::option::fill<0x2::object::ID>(0x2::vec_map::get_mut<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&mut arg1.content, &arg0.content_hash), arg0.content_id);
        0x2::dynamic_field::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.id, 0x1::string::utf8(b"create_image_content_cap_id"));
        let RegisterImageContentCap {
            id           : v0,
            image_id     : _,
            content_id   : _,
            content_hash : _,
            created_with : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun verify_image_content_registered(arg0: &Image) {
        let v0 = 0x2::vec_map::keys<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.content);
        while (!0x1::vector::is_empty<0x1::string::String>(&v0)) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut v0);
            assert!(0x1::option::is_some<0x2::object::ID>(0x2::vec_map::get<0x1::string::String, 0x1::option::Option<0x2::object::ID>>(&arg0.content, &v1)), 5);
        };
        0x1::vector::destroy_empty<0x1::string::String>(v0);
    }

    // decompiled from Move bytecode v6
}

