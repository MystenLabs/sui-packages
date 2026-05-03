module 0x8e2274ea45f2237ece8d75154ae8e816a688d75a5594b16a1191785b55da1c5e::game_store {
    struct Registry has key {
        id: 0x2::object::UID,
        all_games: vector<0x2::object::ID>,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        download_url: 0x1::string::String,
        image_url: 0x1::string::String,
        unzip_password: 0x1::string::String,
    }

    entry fun delete_game(arg0: &mut Registry, arg1: Game, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::object::id<Game>(&arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.all_games, &v0);
        assert!(v1, 1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.all_games, v2);
        let Game {
            id             : v3,
            creator        : _,
            name           : _,
            description    : _,
            download_url   : _,
            image_url      : _,
            unzip_password : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg0),
            all_games : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    entry fun publish_game(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = Game{
            id             : v0,
            creator        : 0x2::tx_context::sender(arg6),
            name           : arg1,
            description    : arg2,
            download_url   : arg3,
            image_url      : arg4,
            unzip_password : arg5,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.all_games, 0x2::object::uid_to_inner(&v0));
        0x2::transfer::share_object<Game>(v1);
    }

    // decompiled from Move bytecode v7
}

