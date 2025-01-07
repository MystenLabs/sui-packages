module 0x98f9d0ec99f7033560cf2d1891aa2f1ee3bd675c5294e317df6235f4c70a22f8::suichan {
    struct BoardOwnerCapability has key {
        id: 0x2::object::UID,
    }

    struct Board has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        maxThreads: u64,
        maxThreadPosts: u64,
        threads: vector<vector<0x1::string::String>>,
    }

    struct PostEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public entry fun create_board(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BoardOwnerCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BoardOwnerCapability>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Board{
            id             : 0x2::object::new(arg0),
            name           : 0x1::string::utf8(0x1::vector::empty<u8>()),
            maxThreads     : 100,
            maxThreadPosts : 300,
            threads        : 0x1::vector::empty<vector<0x1::string::String>>(),
        };
        0x2::transfer::share_object<Board>(v1);
    }

    public entry fun post(arg0: &mut Board, arg1: 0x1::string::String) {
        if (0x1::vector::length<vector<0x1::string::String>>(&arg0.threads) >= arg0.maxThreads) {
            let v0 = 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg0.threads);
            while (!0x1::vector::is_empty<0x1::string::String>(&v0)) {
                0x1::vector::pop_back<0x1::string::String>(&mut v0);
            };
            0x1::vector::destroy_empty<0x1::string::String>(v0);
        };
        0x1::vector::insert<vector<0x1::string::String>>(&mut arg0.threads, 0x1::vector::singleton<0x1::string::String>(arg1), 0);
    }

    public entry fun rename_board(arg0: &BoardOwnerCapability, arg1: &mut Board, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun reply(arg0: &mut Board, arg1: u64, arg2: 0x1::string::String) {
        let v0 = 0x1::vector::borrow_mut<vector<0x1::string::String>>(&mut arg0.threads, arg1);
        assert!(0x1::vector::length<0x1::string::String>(v0) < arg0.maxThreadPosts, 1);
        0x1::vector::push_back<0x1::string::String>(v0, arg2);
        let v1 = PostEvent{id: 0x2::object::id<Board>(arg0)};
        0x2::event::emit<PostEvent>(v1);
    }

    public entry fun set_max_thread_posts(arg0: &BoardOwnerCapability, arg1: &mut Board, arg2: u64) {
        arg1.maxThreadPosts = arg2;
    }

    public entry fun set_max_threads(arg0: &BoardOwnerCapability, arg1: &mut Board, arg2: u64) {
        arg1.maxThreads = arg2;
    }

    // decompiled from Move bytecode v6
}

