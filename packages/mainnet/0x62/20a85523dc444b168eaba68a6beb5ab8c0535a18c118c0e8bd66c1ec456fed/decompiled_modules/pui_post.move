module 0x6220a85523dc444b168eaba68a6beb5ab8c0535a18c118c0e8bd66c1ec456fed::pui_post {
    struct Post has store, key {
        id: 0x2::object::UID,
        author: address,
        content: 0x1::string::String,
        image_urls: vector<0x1::string::String>,
        timestamp_ms: u64,
    }

    struct PostCreatedEvent has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        image_count: u64,
        timestamp_ms: u64,
    }

    entry fun create_post(arg0: vector<u8>, arg1: vector<0x1::string::String>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = Post{
            id           : v1,
            author       : v0,
            content      : 0x1::string::utf8(arg0),
            image_urls   : arg1,
            timestamp_ms : v2,
        };
        let v4 = PostCreatedEvent{
            post_id      : 0x2::object::uid_to_inner(&v1),
            author       : v0,
            image_count  : 0x1::vector::length<0x1::string::String>(&arg1),
            timestamp_ms : v2,
        };
        0x2::event::emit<PostCreatedEvent>(v4);
        0x2::transfer::share_object<Post>(v3);
    }

    entry fun delete_post(arg0: Post, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 0);
        let Post {
            id           : v0,
            author       : _,
            content      : _,
            image_urls   : _,
            timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v7
}

