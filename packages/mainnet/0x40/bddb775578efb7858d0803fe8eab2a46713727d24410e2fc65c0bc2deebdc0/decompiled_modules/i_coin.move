module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::i_coin {
    struct I_COIN has drop {
        dummy_field: bool,
    }

    struct Post has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        created_at: u64,
        author: address,
        count_likes: u64,
        count_replies: u64,
    }

    struct ReplyPool has store, key {
        id: 0x2::object::UID,
    }

    struct RecentPosts has store, key {
        id: 0x2::object::UID,
        posts: vector<0x2::object::ID>,
    }

    public entry fun create_post(arg0: vector<u8>, arg1: &mut RecentPosts, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new_post(arg0, arg2, arg3);
        update_recent_posts(arg1, 0x2::object::id<Post>(&v0));
        0x2::transfer::public_share_object<Post>(v0);
    }

    fun create_recent_posts(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecentPosts{
            id    : 0x2::object::new(arg0),
            posts : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<RecentPosts>(v0);
    }

    fun init(arg0: I_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I_COIN>(arg0, 2, b"LIKE", b"Like Coin", b"Like Coin for Suitter", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun like_post<T0>(arg0: &mut Post, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.count_likes = arg0.count_likes + 1;
        0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, liked_key()), 0x2::tx_context::sender(arg2));
        mint_like_and_transfer<T0>(arg1, 1, arg0.author, arg2);
    }

    fun liked_key() : 0x1::string::String {
        0x1::string::utf8(b"liked")
    }

    fun mint_like_and_transfer<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    fun new_post(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Post {
        let v0 = Post{
            id            : 0x2::object::new(arg2),
            text          : 0x1::string::utf8(arg0),
            created_at    : 0x2::clock::timestamp_ms(arg1),
            author        : 0x2::tx_context::sender(arg2),
            count_likes   : 0,
            count_replies : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut v0.id, liked_key(), 0x2::vec_set::empty<address>());
        let v1 = ReplyPool{id: 0x2::object::new(arg2)};
        0x2::dynamic_object_field::add<0x1::string::String, ReplyPool>(&mut v0.id, repled_key(), v1);
        v0
    }

    fun repled_key() : 0x1::string::String {
        0x1::string::utf8(b"replyed")
    }

    public entry fun reply_post(arg0: &mut Post, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.count_replies = arg0.count_replies + 1;
        let v0 = new_post(arg1, arg2, arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, Post>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, ReplyPool>(&mut arg0.id, repled_key()).id, 0x2::object::id<Post>(&v0), v0);
    }

    fun update_recent_posts(arg0: &mut RecentPosts, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.posts, arg1);
        if (0x1::vector::length<0x2::object::ID>(&arg0.posts) > 20) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.posts, 0);
        };
    }

    // decompiled from Move bytecode v6
}

