module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::e_likes {
    struct Post has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        created_at: u64,
        author: address,
        count_likes: u64,
    }

    struct Thread has store, key {
        id: 0x2::object::UID,
        post_list: vector<Post>,
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

    public entry fun new_thread(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Thread{
            id        : 0x2::object::new(arg0),
            post_list : 0x1::vector::empty<Post>(),
        };
        0x2::transfer::public_share_object<Thread>(v0);
    }

    public entry fun write_thread(arg0: &mut Thread, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Post{
            id          : 0x2::object::new(arg3),
            text        : 0x1::string::utf8(arg1),
            created_at  : 0x2::clock::timestamp_ms(arg2),
            author      : 0x2::tx_context::sender(arg3),
            count_likes : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<address>>(&mut v0.id, liked_key(), 0x2::vec_set::empty<address>());
        0x1::vector::push_back<Post>(&mut arg0.post_list, v0);
    }

    // decompiled from Move bytecode v6
}

