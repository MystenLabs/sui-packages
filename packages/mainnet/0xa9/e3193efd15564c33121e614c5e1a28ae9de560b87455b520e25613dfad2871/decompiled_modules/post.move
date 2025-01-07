module 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::post {
    struct PostOwnerCap has store, key {
        id: 0x2::object::UID,
        post: 0x2::object::ID,
        seq: u64,
        content: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct Post has store, key {
        id: 0x2::object::UID,
        seq: u64,
        image_url: 0x1::option::Option<0x2::url::Url>,
        content: 0x1::string::String,
        created_at: u64,
        profile: 0x2::object::ID,
        parent: 0x1::option::Option<0x2::object::ID>,
        comment_count: u64,
        like_count: u64,
        author: 0x2::object::ID,
    }

    struct CreatePostEvent has copy, drop {
        post_id: 0x2::object::ID,
        author: 0x2::object::ID,
        content: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct CreateCommentEvent has copy, drop {
        post_id: 0x2::object::ID,
        post_author: 0x2::object::ID,
        comment_id: 0x2::object::ID,
        comment_author: 0x2::object::ID,
        content: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct LikePostEvent has copy, drop {
        post_author: 0x2::object::ID,
        post_id: 0x2::object::ID,
        profile: 0x2::object::ID,
        like_count: u64,
    }

    public fun assert_post_owner(arg0: &Post, arg1: &PostOwnerCap) {
        assert!(0x2::object::id<Post>(arg0) == arg1.post, 0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff::error::not_owner());
    }

    fun comments_key() : 0x1::string::String {
        0x1::string::utf8(b"comments")
    }

    public fun create_cap_display() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Releap Post #{seq}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{content}"));
        (v0, v2)
    }

    public(friend) fun create_comment(arg0: &mut Post, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Post, PostOwnerCap) {
        let v0 = Post{
            id            : 0x2::object::new(arg5),
            seq           : arg4,
            image_url     : 0x1::option::none<0x2::url::Url>(),
            content       : arg2,
            created_at    : 0x2::clock::timestamp_ms(arg3),
            profile       : arg0.profile,
            parent        : 0x1::option::some<0x2::object::ID>(0x2::object::id<Post>(arg0)),
            comment_count : 0,
            like_count    : 0,
            author        : arg1,
        };
        let v1 = PostOwnerCap{
            id        : 0x2::object::new(arg5),
            post      : 0x2::object::id<Post>(&v0),
            seq       : arg4,
            content   : arg2,
            image_url : 0x1::option::none<0x2::url::Url>(),
        };
        arg0.comment_count = arg0.comment_count + 1;
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.id, comments_key()), 0x2::object::id<Post>(&v0));
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::object::ID>>(&mut v0.id, comments_key(), 0x1::vector::empty<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v0.id, liked_set_key(), 0x2::vec_set::empty<0x2::object::ID>());
        let v2 = CreateCommentEvent{
            post_id        : 0x2::object::id<Post>(arg0),
            post_author    : arg0.author,
            comment_id     : 0x2::object::id<Post>(&v0),
            comment_author : arg1,
            content        : arg0.content,
            image_url      : arg0.image_url,
        };
        0x2::event::emit<CreateCommentEvent>(v2);
        (v0, v1)
    }

    public fun create_display() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"like_count"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"comments_count"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Releap Post #{seq}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{content}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{like_count}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{comment_count}"));
        (v0, v2)
    }

    public(friend) fun create_post(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Post, PostOwnerCap) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        if (!0x1::string::is_empty(&arg1)) {
            v0 = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::string::to_ascii(arg1)));
        };
        let v1 = Post{
            id            : 0x2::object::new(arg5),
            seq           : arg4,
            image_url     : v0,
            content       : arg2,
            created_at    : 0x2::clock::timestamp_ms(arg3),
            profile       : arg0,
            parent        : 0x1::option::none<0x2::object::ID>(),
            comment_count : 0,
            like_count    : 0,
            author        : arg0,
        };
        let v2 = PostOwnerCap{
            id        : 0x2::object::new(arg5),
            post      : 0x2::object::id<Post>(&v1),
            seq       : arg4,
            content   : arg2,
            image_url : v0,
        };
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::object::ID>>(&mut v1.id, comments_key(), 0x1::vector::empty<0x2::object::ID>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v1.id, liked_set_key(), 0x2::vec_set::empty<0x2::object::ID>());
        let v3 = CreatePostEvent{
            post_id   : 0x2::object::id<Post>(&v1),
            author    : arg0,
            content   : v1.content,
            image_url : v1.image_url,
        };
        0x2::event::emit<CreatePostEvent>(v3);
        (v1, v2)
    }

    public fun get_post_content(arg0: &Post) : 0x1::string::String {
        arg0.content
    }

    public fun get_post_liked_count(arg0: &Post) : u64 {
        arg0.like_count
    }

    public fun get_post_liked_profile(arg0: &Post) : &0x2::vec_set::VecSet<0x2::object::ID> {
        0x2::dynamic_field::borrow<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.id, liked_set_key())
    }

    public(friend) fun like_post(arg0: &mut Post, arg1: 0x2::object::ID) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, liked_set_key());
        if (!0x2::vec_set::contains<0x2::object::ID>(v0, &arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(v0, arg1);
            arg0.like_count = arg0.like_count + 1;
            let v1 = LikePostEvent{
                post_author : arg0.author,
                post_id     : 0x2::object::id<Post>(arg0),
                profile     : arg1,
                like_count  : arg0.like_count,
            };
            0x2::event::emit<LikePostEvent>(v1);
        };
    }

    fun liked_set_key() : 0x1::string::String {
        0x1::string::utf8(b"liked_set")
    }

    public(friend) fun unlike_post(arg0: &mut Post, arg1: 0x2::object::ID) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.id, liked_set_key());
        if (0x2::vec_set::contains<0x2::object::ID>(v0, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(v0, &arg1);
            arg0.like_count = arg0.like_count - 1;
        };
    }

    // decompiled from Move bytecode v6
}

