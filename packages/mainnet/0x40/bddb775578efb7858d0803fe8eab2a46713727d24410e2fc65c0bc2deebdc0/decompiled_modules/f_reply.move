module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::f_reply {
    struct Post has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        created_at: u64,
        author: address,
        count_likes: u64,
        count_replies: u64,
    }

    public entry fun create_post(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Post>(new_post(arg0, arg1, arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun like_post(arg0: &mut Post, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.count_likes = arg0.count_likes + 1;
        0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut arg0.id, liked_key()), 0x2::tx_context::sender(arg1));
    }

    fun liked_key() : 0x1::string::String {
        0x1::string::utf8(b"liked")
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
        0x2::dynamic_field::add<0x1::string::String, vector<0x2::object::ID>>(&mut v0.id, repled_key(), 0x1::vector::empty<0x2::object::ID>());
        v0
    }

    fun repled_key() : 0x1::string::String {
        0x1::string::utf8(b"replyed")
    }

    public entry fun reply_post(arg0: &mut Post, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.count_replies = arg0.count_replies + 1;
        let v0 = new_post(arg1, arg2, arg3);
        0x2::transfer::public_share_object<Post>(v0);
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.id, repled_key()), 0x2::object::id<Post>(&v0));
    }

    // decompiled from Move bytecode v6
}

