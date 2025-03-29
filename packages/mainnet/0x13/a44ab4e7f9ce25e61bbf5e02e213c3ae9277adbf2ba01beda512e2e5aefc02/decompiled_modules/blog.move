module 0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::blog {
    struct Post has store, key {
        id: 0x2::object::UID,
        author: address,
        title: 0x1::string::String,
        created_at: u64,
    }

    public fun create_post(arg0: 0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::user::UserActivity, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::user::UserActivity {
        let v0 = Post{
            id         : 0x2::object::new(arg3),
            author     : 0x2::tx_context::sender(arg3),
            title      : 0x1::string::utf8(arg1),
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x13a44ab4e7f9ce25e61bbf5e02e213c3ae9277adbf2ba01beda512e2e5aefc02::user::record_post_creation(&mut arg0, 0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<Post>(v0);
        arg0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

