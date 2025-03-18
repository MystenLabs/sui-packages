module 0x59f6577c24b0bada7b4eb635fd3d10e1e50424527c81583dc0c9b753dc17f3af::rps_game {
    struct Game has store, key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&mut arg0.pool, 0x2::coin::into_balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun judge(arg0: 0x1::string::String, arg1: 0x1::string::String) : u8 {
        if (arg0 == arg1) {
            0
        } else {
            let v1 = if (arg0 == 0x1::string::utf8(b"Rock") && arg1 == 0x1::string::utf8(b"Scissors")) {
                true
            } else if (arg0 == 0x1::string::utf8(b"Scissors") && arg1 == 0x1::string::utf8(b"Paper")) {
                true
            } else {
                arg0 == 0x1::string::utf8(b"Paper") && arg1 == 0x1::string::utf8(b"Rock")
            };
            if (v1) {
                1
            } else {
                2
            }
        }
    }

    entry fun play(arg0: &0x2::random::Random, arg1: &mut Game, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0x1::string::utf8(b"Rock")) {
            true
        } else if (arg2 == 0x1::string::utf8(b"Paper")) {
            true
        } else {
            arg2 == 0x1::string::utf8(b"Scissors")
        };
        assert!(v0, 901);
        assert!(0x2::balance::value<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&arg1.pool) >= 0x2::coin::value<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&arg3) * 10, 900);
        let v1 = random_choice(arg0, arg4);
        let v2 = judge(arg2, v1);
        if (v2 == 1) {
            0x2::balance::join<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&mut arg1.pool, 0x2::coin::into_balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>>(0x2::coin::from_balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(0x2::balance::split<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&mut arg1.pool, 0x2::coin::value<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&arg3) * 2), arg4), 0x2::tx_context::sender(arg4));
        } else if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>>(arg3, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&mut arg1.pool, 0x2::coin::into_balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(arg3));
        };
    }

    fun random_choice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8(&mut v0) % 3;
        if (v1 == 0) {
            0x1::string::utf8(b"Rock")
        } else if (v1 == 1) {
            0x1::string::utf8(b"Paper")
        } else {
            0x1::string::utf8(b"Scissors")
        }
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>>(0x2::coin::from_balance<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(0x2::balance::split<0xc49669ad5956fba19cc5b0f204e6dd80bcf0cd91992ef98a52033eb44775c3a6::tyasriochaofaucet::TYASRIOCHAOFAUCET>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

