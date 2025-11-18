module 0xea58b110bf51d7121036f010ae4a88210a958d8865196b09d98058ce1861b3d7::post_metadata {
    struct PostMetadata has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        excerpt: 0x1::string::String,
        author: 0x1::string::String,
        date: 0x1::string::String,
        read_time: 0x1::string::String,
        category: 0x1::string::String,
        blob_id: 0x1::string::String,
        slug: 0x1::string::String,
        featured: bool,
    }

    public fun create_post(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = PostMetadata{
            id        : 0x2::object::new(arg9),
            title     : arg0,
            excerpt   : arg1,
            author    : arg2,
            date      : arg3,
            read_time : arg4,
            category  : arg5,
            blob_id   : arg6,
            slug      : arg7,
            featured  : arg8,
        };
        0x2::transfer::share_object<PostMetadata>(v0);
    }

    // decompiled from Move bytecode v6
}

