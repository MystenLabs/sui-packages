module 0x6a08569813ccc75f8e387930fc5054466a16f7d94b13a5f76f63e7179efcd9ac::pui_post {
    struct Post has store, key {
        id: 0x2::object::UID,
        author: address,
        content: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
    }

    struct PostCreatedEvent has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        has_image: bool,
    }

    entry fun create_post(arg0: vector<u8>, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = Post{
            id        : v1,
            author    : v0,
            content   : 0x1::string::utf8(arg0),
            image_url : arg1,
        };
        let v3 = PostCreatedEvent{
            post_id   : 0x2::object::uid_to_inner(&v1),
            author    : v0,
            has_image : 0x1::option::is_some<0x1::string::String>(&arg1),
        };
        0x2::event::emit<PostCreatedEvent>(v3);
        0x2::transfer::share_object<Post>(v2);
    }

    entry fun delete_post(arg0: Post, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 0);
        let Post {
            id        : v0,
            author    : _,
            content   : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

