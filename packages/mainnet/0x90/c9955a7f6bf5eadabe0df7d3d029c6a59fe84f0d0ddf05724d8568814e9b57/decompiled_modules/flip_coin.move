module 0x90c9955a7f6bf5eadabe0df7d3d029c6a59fe84f0d0ddf05724d8568814e9b57::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>,
        desc: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_balance(arg0: &mut Game, arg1: 0x2::coin::Coin<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&mut arg0.balance, 0x2::coin::into_balance<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(),
            desc    : 0x1::string::utf8(b"sahab328's flip coin game"),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: 0x2::coin::Coin<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&arg3);
        assert!(0x2::balance::value<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&arg0.balance) >= v0 * 10, 0);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>>(0x2::coin::from_balance<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(0x2::balance::split<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&mut arg0.balance, 0x2::coin::into_balance<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(arg3));
        };
    }

    public entry fun remove_balance(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&arg1.balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>>(0x2::coin::from_balance<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(0x2::balance::split<0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::meme::MEME>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

