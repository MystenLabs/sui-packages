module 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::post {
    struct Post has key {
        id: 0x2::object::UID,
        author: address,
        content_blob_id: 0x1::string::String,
        image_blob_id: 0x1::option::Option<0x1::string::String>,
        reply_to: 0x1::option::Option<0x2::object::ID>,
        like_count: u64,
        tip_total: u64,
        comment_count: u64,
        created_at: u64,
    }

    struct Like has key {
        id: 0x2::object::UID,
        post_id: 0x2::object::ID,
        liker: address,
    }

    struct PostCreated has copy, drop {
        post_id: 0x2::object::ID,
        author: address,
        content_blob_id: 0x1::string::String,
        has_image: bool,
        reply_to: 0x1::option::Option<0x2::object::ID>,
        created_at: u64,
    }

    struct PostLiked has copy, drop {
        post_id: 0x2::object::ID,
        liker: address,
        author: address,
    }

    struct PostUnliked has copy, drop {
        post_id: 0x2::object::ID,
        liker: address,
    }

    struct PostTipped has copy, drop {
        post_id: 0x2::object::ID,
        tipper: address,
        author: address,
        amount: u64,
    }

    public fun author(arg0: &Post) : address {
        arg0.author
    }

    public fun comment_count(arg0: &Post) : u64 {
        arg0.comment_count
    }

    public fun content_blob_id(arg0: &Post) : &0x1::string::String {
        &arg0.content_blob_id
    }

    public fun create_post(arg0: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg1: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::Treasury, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg0) == v0, 1);
        let v1 = 0x1::vector::length<u8>(&arg3) > 0;
        let v2 = if (v1) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg3))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v3 = Post{
            id              : 0x2::object::new(arg5),
            author          : v0,
            content_blob_id : 0x1::string::utf8(arg2),
            image_blob_id   : v2,
            reply_to        : 0x1::option::none<0x2::object::ID>(),
            like_count      : 0,
            tip_total       : 0,
            comment_count   : 0,
            created_at      : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::increment_post_count(arg0);
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::distribute_post_reward(arg1, v0, 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg4), arg5);
        let v4 = PostCreated{
            post_id         : 0x2::object::id<Post>(&v3),
            author          : v0,
            content_blob_id : v3.content_blob_id,
            has_image       : v1,
            reply_to        : 0x1::option::none<0x2::object::ID>(),
            created_at      : v3.created_at,
        };
        0x2::event::emit<PostCreated>(v4);
        0x2::transfer::share_object<Post>(v3);
    }

    public fun create_reply(arg0: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg1: &mut Post, arg2: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::Treasury, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg0) == v0, 1);
        let v1 = 0x1::vector::length<u8>(&arg4) > 0;
        let v2 = 0x2::object::id<Post>(arg1);
        let v3 = arg1.author;
        let v4 = if (v1) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg4))
        } else {
            0x1::option::none<0x1::string::String>()
        };
        let v5 = Post{
            id              : 0x2::object::new(arg7),
            author          : v0,
            content_blob_id : 0x1::string::utf8(arg3),
            image_blob_id   : v4,
            reply_to        : 0x1::option::some<0x2::object::ID>(v2),
            like_count      : 0,
            tip_total       : 0,
            comment_count   : 0,
            created_at      : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::increment_post_count(arg0);
        arg1.comment_count = arg1.comment_count + 1;
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::distribute_post_reward(arg2, v0, 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(arg5), arg7);
        if (v3 != v0) {
            0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::distribute_comment_reward(arg2, v3, arg6, arg7);
        };
        let v6 = PostCreated{
            post_id         : 0x2::object::id<Post>(&v5),
            author          : v0,
            content_blob_id : v5.content_blob_id,
            has_image       : v1,
            reply_to        : 0x1::option::some<0x2::object::ID>(v2),
            created_at      : v5.created_at,
        };
        0x2::event::emit<PostCreated>(v6);
        0x2::transfer::share_object<Post>(v5);
    }

    public fun created_at(arg0: &Post) : u64 {
        arg0.created_at
    }

    public fun image_blob_id(arg0: &Post) : &0x1::option::Option<0x1::string::String> {
        &arg0.image_blob_id
    }

    public fun is_reply(arg0: &Post) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.reply_to)
    }

    public fun like_count(arg0: &Post) : u64 {
        arg0.like_count
    }

    public fun like_post(arg0: &mut Post, arg1: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Like {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.author;
        arg0.like_count = arg0.like_count + 1;
        if (v1 != v0) {
            0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::treasury::distribute_like_reward(arg1, v1, arg2, arg3);
        };
        let v2 = PostLiked{
            post_id : 0x2::object::id<Post>(arg0),
            liker   : v0,
            author  : v1,
        };
        0x2::event::emit<PostLiked>(v2);
        Like{
            id      : 0x2::object::new(arg3),
            post_id : 0x2::object::id<Post>(arg0),
            liker   : v0,
        }
    }

    public fun like_post_id(arg0: &Like) : 0x2::object::ID {
        arg0.post_id
    }

    public fun liker(arg0: &Like) : address {
        arg0.liker
    }

    public fun reply_to(arg0: &Post) : &0x1::option::Option<0x2::object::ID> {
        &arg0.reply_to
    }

    public fun tip_post(arg0: &mut Post, arg1: &mut 0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::Profile, arg2: 0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.author;
        let v2 = 0x2::coin::value<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>(&arg2);
        assert!(v2 >= 1000000, 2);
        assert!(v0 != v1, 3);
        assert!(0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::owner(arg1) == v1, 1);
        arg0.tip_total = arg0.tip_total + v2;
        0xadc4ef7d1b97d71fdfe01f7324f168d89acd1014dfa517db4ca68422e32884d::profile::add_capy_earned(arg1, v2);
        let v3 = PostTipped{
            post_id : 0x2::object::id<Post>(arg0),
            tipper  : v0,
            author  : v1,
            amount  : v2,
        };
        0x2::event::emit<PostTipped>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab0cf2644867272bc89a77d9cff0633e3d50e3f738b963d9c8e6899b529803a8::capy::CAPY>>(arg2, v1);
    }

    public fun tip_total(arg0: &Post) : u64 {
        arg0.tip_total
    }

    public fun unlike_post(arg0: &mut Post, arg1: Like, arg2: &0x2::tx_context::TxContext) {
        let Like {
            id      : v0,
            post_id : _,
            liker   : v2,
        } = arg1;
        0x2::object::delete(v0);
        if (arg0.like_count > 0) {
            arg0.like_count = arg0.like_count - 1;
        };
        let v3 = PostUnliked{
            post_id : 0x2::object::id<Post>(arg0),
            liker   : v2,
        };
        0x2::event::emit<PostUnliked>(v3);
    }

    // decompiled from Move bytecode v6
}

