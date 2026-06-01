module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::post {
    struct Post has store, key {
        id: 0x2::object::UID,
        author: address,
        walrus_blob_id: 0x1::string::String,
        blob_hash: vector<u8>,
        content_type: u8,
        visibility: u8,
        reply_to: 0x1::option::Option<0x2::object::ID>,
        repost_of: 0x1::option::Option<0x2::object::ID>,
        like_count: u64,
        comment_count: u64,
        repost_count: u64,
        created_at: u64,
    }

    public entry fun create_post(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = Post{
            id             : v1,
            author         : v0,
            walrus_blob_id : arg0,
            blob_hash      : arg1,
            content_type   : arg2,
            visibility     : arg3,
            reply_to       : arg4,
            repost_of      : arg5,
            like_count     : 0,
            comment_count  : 0,
            repost_count   : 0,
            created_at     : v2,
        };
        0x2::transfer::share_object<Post>(v3);
        0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::events::emit_post_created(0x2::object::uid_to_inner(&v1), v0, arg0, arg2, v2);
    }

    public fun get_author(arg0: &Post) : address {
        arg0.author
    }

    public fun get_like_count(arg0: &Post) : u64 {
        arg0.like_count
    }

    public fun get_walrus_blob_id(arg0: &Post) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    public(friend) fun increment_comment_count(arg0: &mut Post) {
        arg0.comment_count = arg0.comment_count + 1;
    }

    public(friend) fun increment_like_count(arg0: &mut Post) {
        arg0.like_count = arg0.like_count + 1;
    }

    public(friend) fun increment_repost_count(arg0: &mut Post) {
        arg0.repost_count = arg0.repost_count + 1;
    }

    // decompiled from Move bytecode v7
}

