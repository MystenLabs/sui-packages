module 0x5fb5e42a29597138bc8123e171c2d0507c767eed7b063f0b1f4c447ffdc8dc94::lofi {
    struct Blog has store, key {
        id: 0x2::object::UID,
        author: address,
        content: 0x1::string::String,
        likes: u64,
    }

    struct BlogPublished has copy, drop {
        blog_id: address,
        author: address,
        content: 0x1::string::String,
    }

    struct BlogLiked has copy, drop {
        blog_id: address,
        liked_by: address,
        total_likes: u64,
    }

    public entry fun create_blog(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = publish_blog(arg0, arg1);
        0x2::transfer::transfer<Blog>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun delete_blog(arg0: Blog, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 0);
        let Blog {
            id      : v0,
            author  : _,
            content : _,
            likes   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun edit_content(arg0: &mut Blog, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg2), 0);
        arg0.content = arg1;
    }

    public fun get_author(arg0: &Blog) : address {
        arg0.author
    }

    public fun get_content(arg0: &Blog) : 0x1::string::String {
        arg0.content
    }

    public fun get_likes(arg0: &Blog) : u64 {
        arg0.likes
    }

    public fun like_blog(arg0: &mut Blog, arg1: &0x2::tx_context::TxContext) {
        arg0.likes = arg0.likes + 1;
        let v0 = BlogLiked{
            blog_id     : 0x2::object::uid_to_address(&arg0.id),
            liked_by    : 0x2::tx_context::sender(arg1),
            total_likes : arg0.likes,
        };
        0x2::event::emit<BlogLiked>(v0);
    }

    public fun publish_blog(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Blog {
        let v0 = Blog{
            id      : 0x2::object::new(arg1),
            author  : 0x2::tx_context::sender(arg1),
            content : arg0,
            likes   : 0,
        };
        let v1 = BlogPublished{
            blog_id : 0x2::object::uid_to_address(&v0.id),
            author  : 0x2::tx_context::sender(arg1),
            content : arg0,
        };
        0x2::event::emit<BlogPublished>(v1);
        v0
    }

    public fun share_blog(arg0: Blog, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_share_object<Blog>(arg0);
    }

    public fun transfer_blog(arg0: Blog, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::transfer<Blog>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

