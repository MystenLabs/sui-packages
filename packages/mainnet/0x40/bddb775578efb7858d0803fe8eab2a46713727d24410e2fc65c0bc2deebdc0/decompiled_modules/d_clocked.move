module 0x40bddb775578efb7858d0803fe8eab2a46713727d24410e2fc65c0bc2deebdc0::d_clocked {
    struct Post has drop, store {
        text: 0x1::string::String,
        created_at: u64,
        author: address,
    }

    struct Thread has store, key {
        id: 0x2::object::UID,
        post_list: vector<Post>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
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
            text       : 0x1::string::utf8(arg1),
            created_at : 0x2::clock::timestamp_ms(arg2),
            author     : 0x2::tx_context::sender(arg3),
        };
        0x1::vector::push_back<Post>(&mut arg0.post_list, v0);
    }

    // decompiled from Move bytecode v6
}

