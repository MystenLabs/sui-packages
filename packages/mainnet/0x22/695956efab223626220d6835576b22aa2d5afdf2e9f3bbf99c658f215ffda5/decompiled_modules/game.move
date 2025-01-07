module 0x22695956efab223626220d6835576b22aa2d5afdf2e9f3bbf99c658f215ffda5::game {
    struct Profile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct GAME has drop {
        dummy_field: bool,
    }

    struct StartGame has copy, drop {
        id: 0x2::object::ID,
        result: u32,
        win: u64,
    }

    struct ObtainCard has copy, drop {
        result: u32,
    }

    struct GameNFT has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimCard has store, key {
        id: 0x2::object::UID,
        img_url: 0x1::string::String,
        type: 0x1::string::String,
        model: u64,
    }

    struct GamePoolHouse has store, key {
        id: 0x2::object::UID,
        balance: u64,
        coin: 0x2::balance::Balance<0x2::sui::SUI>,
        account_map: 0x2::vec_map::VecMap<address, u64>,
        game_account_map: 0x2::vec_map::VecMap<address, u64>,
        game_account_time_map: 0x2::vec_map::VecMap<address, u64>,
    }

    public entry fun coining(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut GamePoolHouse, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.coin, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3)));
        arg2.balance = arg2.balance + arg1;
    }

    public entry fun daily_claim(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut GamePoolHouse, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_map::contains<address, u64>(&mut arg1.account_map, &v1)) {
            assert!(v0 - *0x2::vec_map::get<address, u64>(&mut arg1.account_map, &v1) > 10000, 1);
            update_game_vec(arg1, arg3);
            0x2::vec_map::insert<address, u64>(&mut arg1.account_map, v1, v0);
            daily_lottery(arg0, arg3);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg1.account_map, v1, v0);
            daily_lottery(arg0, arg3);
        };
    }

    fun daily_lottery(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = get_random(arg0);
        if (v0 < 3865470566) {
            send_claim_nft(b"copper", b"https://ipfs.io/ipfs/bafkreiel7xfens3mgrvgycgj3qiv6qao44me76eu4f3ugwthhmnffjiafi", 101, arg1);
            let v1 = ObtainCard{result: 101};
            0x2::event::emit<ObtainCard>(v1);
        } else if (v0 < 4252017623) {
            send_claim_nft(b"silver", b"https://ipfs.io/ipfs/bafkreiarcgkfez4xn4kvcuntvd3h54rp34tif6phhg66aenykg7ha7x4wy", 102, arg1);
            let v2 = ObtainCard{result: 102};
            0x2::event::emit<ObtainCard>(v2);
        } else {
            send_claim_nft(b"gold", b"https://ipfs.io/ipfs/bafkreihkanwafumvbi7kcr7i5mawdofpscagnw7tzvg5j4hbqhutb7fmza", 103, arg1);
            let v3 = ObtainCard{result: 103};
            0x2::event::emit<ObtainCard>(v3);
        };
    }

    fun destory_card(arg0: ClaimCard) {
        let ClaimCard {
            id      : v0,
            img_url : _,
            type    : _,
            model   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle) : u32 {
        0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_temp(arg0, 2988507)
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://github.com/{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Game Card!"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://github.com"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v8 = 0x2::package::claim<GAME>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<Profile>(&v8, v0, v2, arg1);
        let v10 = 0x2::display::new_with_fields<ClaimCard>(&v8, v4, v6, arg1);
        0x2::display::update_version<Profile>(&mut v9);
        0x2::display::update_version<ClaimCard>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Profile>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ClaimCard>>(v10, 0x2::tx_context::sender(arg1));
        let v11 = GamePoolHouse{
            id                    : 0x2::object::new(arg1),
            balance               : 0,
            coin                  : 0x2::balance::zero<0x2::sui::SUI>(),
            account_map           : 0x2::vec_map::empty<address, u64>(),
            game_account_map      : 0x2::vec_map::empty<address, u64>(),
            game_account_time_map : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<GamePoolHouse>(v11);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Profile{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            img_url     : arg1,
            description : arg2,
        };
        0x2::transfer::public_transfer<Profile>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun send_claim_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimCard{
            id      : 0x2::object::new(arg3),
            img_url : 0x1::string::utf8(arg1),
            type    : 0x1::string::utf8(arg0),
            model   : arg2,
        };
        0x2::transfer::public_transfer<ClaimCard>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun start_game(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut GamePoolHouse, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = get_random(arg0);
        0x2::coin::value<0x2::sui::SUI>(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) == 100000000, 0);
        let v3 = 0x2::tx_context::sender(arg6);
        if (0x2::vec_map::contains<address, u64>(&mut arg1.game_account_map, &v3)) {
            let v4 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.game_account_map, &v3);
            let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg1.game_account_time_map, &v3);
            if (*v4 == 3) {
                assert!(*v5 + 60000 < v1, 10);
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.game_account_time_map, &v3);
                let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.game_account_map, &v3);
                0x2::vec_map::insert<address, u64>(&mut arg1.game_account_map, v3, 1);
                0x2::vec_map::insert<address, u64>(&mut arg1.game_account_time_map, 0x2::tx_context::sender(arg6), v1);
            } else {
                update_user_game_status(v1, arg1, *v4, arg6);
            };
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg1.game_account_map, v3, 1);
            0x2::vec_map::insert<address, u64>(&mut arg1.game_account_time_map, v3, v1);
        };
        let v10 = 0;
        if (arg2 == 0) {
            if (v2 == 0) {
                v10 = 0;
            };
            if (v2 == 1) {
                v10 = 1;
            };
            if (v2 == 2) {
                v10 = 2;
            };
        };
        if (arg2 == 1) {
            if (v2 == 0) {
                v10 = 2;
            };
            if (v2 == 1) {
                v10 = 0;
            };
            if (v2 == 2) {
                v10 = 1;
            };
        };
        if (arg2 == 2) {
            if (v2 == 0) {
                v10 = 1;
            };
            if (v2 == 1) {
                v10 = 2;
            };
            if (v2 == 2) {
                v10 = 0;
            };
        };
        if (v10 == 1) {
            let v11 = StartGame{
                id     : 0x2::object::uid_to_inner(&v0),
                result : v2,
                win    : v10,
            };
            0x2::event::emit<StartGame>(v11);
            let v12 = GameNFT{id: v0};
            0x2::transfer::public_transfer<GameNFT>(v12, 0x2::tx_context::sender(arg6));
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.coin, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg4, arg5, arg6)));
            arg1.balance = arg1.balance + arg5;
            daily_lottery(arg0, arg6);
        } else if (v10 == 2) {
            let v13 = StartGame{
                id     : 0x2::object::uid_to_inner(&v0),
                result : v2,
                win    : v10,
            };
            0x2::event::emit<StartGame>(v13);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.coin, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg4, arg5, arg6)));
            arg1.balance = arg1.balance + arg5;
            let v14 = GameNFT{id: v0};
            0x2::transfer::public_transfer<GameNFT>(v14, 0x2::tx_context::sender(arg6));
        } else {
            let v15 = StartGame{
                id     : 0x2::object::uid_to_inner(&v0),
                result : v2,
                win    : v10,
            };
            0x2::event::emit<StartGame>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, arg5, arg6), 0x2::tx_context::sender(arg6));
            let v16 = GameNFT{id: v0};
            0x2::transfer::public_transfer<GameNFT>(v16, 0x2::tx_context::sender(arg6));
        };
    }

    fun update_game_vec(arg0: &mut GamePoolHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.account_map, &v0);
    }

    fun update_user_game_status(arg0: u64, arg1: &mut GamePoolHouse, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.game_account_map, &v0);
        0x2::vec_map::insert<address, u64>(&mut arg1.game_account_map, 0x2::tx_context::sender(arg3), arg2 + 1);
    }

    public entry fun withdrawal(arg0: ClaimCard, arg1: ClaimCard, arg2: ClaimCard, arg3: &mut GamePoolHouse, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.model == 101, 2);
        assert!(arg1.model == 102, 2);
        assert!(arg2.model == 103, 2);
        destory_card(arg0);
        destory_card(arg1);
        destory_card(arg2);
        arg3.balance = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3.coin, arg3.balance), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

