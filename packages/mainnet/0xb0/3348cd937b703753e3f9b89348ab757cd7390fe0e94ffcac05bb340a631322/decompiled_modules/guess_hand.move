module 0xb03348cd937b703753e3f9b89348ab757cd7390fe0e94ffcac05bb340a631322::guess_hand {
    struct Game has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<GUESS_HAND>,
    }

    struct GameCap has key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct Game_Finished has copy, drop {
        winner: 0x1::ascii::String,
        address: address,
    }

    struct GUESS_HAND has drop {
        dummy_field: bool,
    }

    fun check(arg0: vector<u8>) : bool {
        arg0 == b"rock" || arg0 == b"scissor" || arg0 == b"paper"
    }

    public entry fun choose_hand(arg0: &GameCap, arg1: &mut Game, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(check(arg2), 1);
        assert!(0x2::balance::value<GUESS_HAND>(&arg1.balance) > 0, 3);
        let v0 = hand_to_number(arg2);
        let v1 = roll_clock(arg3, arg4);
        let v2 = if (user_win(v0, v1)) {
            0x2::tx_context::sender(arg4)
        } else {
            arg0.creator
        };
        let v3 = if (user_win(v0, v1)) {
            0x1::ascii::string(b"user")
        } else {
            0x1::ascii::string(b"robot")
        };
        let v4 = Game_Finished{
            winner  : v3,
            address : v2,
        };
        0x2::event::emit<Game_Finished>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUESS_HAND>>(0x2::coin::from_balance<GUESS_HAND>(0x2::balance::split<GUESS_HAND>(&mut arg1.balance, 1000000000), arg4), v2);
    }

    fun choose_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"left") {
            0
        } else {
            1
        }
    }

    fun hand_to_number(arg0: vector<u8>) : u64 {
        if (arg0 == b"rock") {
            0
        } else if (arg0 == b"scissor") {
            1
        } else {
            2
        }
    }

    fun init(arg0: GUESS_HAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameCap{
            id      : 0x2::object::new(arg1),
            creator : 0x2::tx_context::sender(arg1),
        };
        let (v1, v2) = 0x2::coin::create_currency<GUESS_HAND>(arg0, 9, b"Eymeria-cyper", b"One Piece!", b"Eymeria game coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/90686202"))), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUESS_HAND>>(v2);
        let v4 = Game{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<GUESS_HAND>(0x2::coin::mint<GUESS_HAND>(&mut v3, 100 * 1000000000, arg1)),
        };
        0x2::transfer::freeze_object<GameCap>(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUESS_HAND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Game>(v4);
    }

    fun number_to_hand(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            b"rock"
        } else if (arg0 == 1) {
            b"scissor"
        } else {
            b"paper"
        }
    }

    fun roll(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 2)
    }

    fun roll_clock(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::clock::timestamp_ms(arg0) % 3
    }

    fun user_win(arg0: u64, arg1: u64) : bool {
        arg0 == 0 && arg1 == 1 || arg0 == 1 && arg1 == 2 || arg0 == 2 && arg1 == 0
    }

    // decompiled from Move bytecode v6
}

