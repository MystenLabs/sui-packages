module 0x413e80e5c694ee898cdb34ba412365702f2d7b5d5f2d0f3c6ccc40f89bdbb066::klren0312_game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GameServer has key {
        id: 0x2::object::UID,
        coin_pool: 0x2::balance::Balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>,
        need_coin_amount: u64,
        reward_coin: u64,
    }

    struct GameResult has copy, drop {
        game_server_number: u8,
        player_guess_number: u8,
        play_status: bool,
        play_status_chinese: 0x1::string::String,
        reward_coin_amount: u64,
    }

    entry fun admin_withdraw(arg0: &AdminCap, arg1: &mut GameServer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&arg1.coin_pool), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>>(0x2::coin::from_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(0x2::balance::split<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg1.coin_pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun deposit(arg0: &mut GameServer, arg1: 0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&arg1);
        assert!(v0 >= arg2, 0);
        let v1 = 0x2::coin::into_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg0.coin_pool, 0x2::balance::split<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>>(0x2::coin::from_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg0.coin_pool, v1);
        };
    }

    entry fun do_play(arg0: &0x2::random::Random, arg1: &mut GameServer, arg2: 0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.need_coin_amount;
        deposit(arg1, arg2, v0, arg4);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        let v2 = 0x2::random::generate_u8_in_range(&mut v1, 1, 10);
        let v3 = false;
        if (arg3 == v2) {
            assert!(arg1.reward_coin <= 0x2::balance::value<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&arg1.coin_pool), 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>>(0x2::coin::from_balance<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(0x2::balance::split<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(&mut arg1.coin_pool, arg1.reward_coin), arg4), 0x2::tx_context::sender(arg4));
            v3 = true;
        };
        let v4 = 0;
        let v5 = 0x1::string::utf8(x"e8be93e4ba86");
        if (v3 == true) {
            v4 = arg1.reward_coin;
            v5 = 0x1::string::utf8(x"e8b5a2e4ba86");
        };
        let v6 = GameResult{
            game_server_number  : v2,
            player_guess_number : arg3,
            play_status         : v3,
            play_status_chinese : v5,
            reward_coin_amount  : v4,
        };
        0x2::event::emit<GameResult>(v6);
    }

    entry fun gen_game(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameServer{
            id               : 0x2::object::new(arg1),
            coin_pool        : 0x2::balance::zero<0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN::TRUMP_COIN>(),
            need_coin_amount : arg0,
            reward_coin      : arg0 * 2,
        };
        0x2::transfer::share_object<GameServer>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

