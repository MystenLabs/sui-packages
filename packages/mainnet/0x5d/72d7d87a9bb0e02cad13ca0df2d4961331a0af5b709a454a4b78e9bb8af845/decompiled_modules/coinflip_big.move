module 0x5d72d7d87a9bb0e02cad13ca0df2d4961331a0af5b709a454a4b78e9bb8af845::coinflip_big {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        user_randomness: vector<u8>,
        guess: u8,
        stake: u64,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        player_won: bool,
        player: address,
        turn: u64,
    }

    struct OutWin has copy, drop {
        player_win: bool,
        player: address,
        amount_win: u64,
        turn: u64,
    }

    struct Info has copy, store {
        turn: u64,
        check_turn: bool,
        turn_game: 0x2::object::ID,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        fund_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        rewards_balance: u64,
        number: u64,
        house: address,
        public_key: vector<u8>,
        sui_stake: u64,
    }

    struct Game has key {
        id: 0x2::object::UID,
        guess_placed_epoch: u64,
        stake: u64,
        guess: u8,
        player: address,
        user_randomness: vector<u8>,
        challenged: bool,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HouseCap>(v0, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922);
    }

    public entry fun initialize_house_data(arg0: HouseCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 7);
        let v0 = HouseData{
            id              : 0x2::object::new(arg3),
            fund_balance    : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            rewards_balance : 1000000000,
            number          : 2,
            house           : 0x2::tx_context::sender(arg3),
            public_key      : arg2,
            sui_stake       : 1000000000,
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    fun internal_start_game(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut HouseData, arg4: &mut 0x2::tx_context::TxContext) : Game {
        assert!(arg0 == 1 || arg0 == 0, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = Game{
            id                 : 0x2::object::new(arg4),
            guess_placed_epoch : 0x2::tx_context::epoch(arg4),
            stake              : v0,
            guess              : arg0,
            player             : 0x2::tx_context::sender(arg4),
            user_randomness    : arg1,
            challenged         : false,
        };
        let v2 = 0;
        if (!0x2::dynamic_field::exists_<address>(&arg3.id, 0x2::tx_context::sender(arg4))) {
            let v3 = Info{
                turn       : 0,
                check_turn : false,
                turn_game  : 0x2::object::uid_to_inner(&v1.id),
            };
            0x2::dynamic_field::add<address, Info>(&mut arg3.id, 0x2::tx_context::sender(arg4), v3);
        } else {
            let v4 = 0x2::dynamic_field::borrow_mut<address, Info>(&mut arg3.id, 0x2::tx_context::sender(arg4));
            let v5 = &mut v4.turn;
            let v6 = &mut v4.check_turn;
            let v7 = &mut v4.turn_game;
            assert!(*v6, 11);
            v2 = *v5;
            *v6 = false;
            *v7 = 0x2::object::uid_to_inner(&v1.id);
        };
        if (v2 == 0) {
            assert!(v0 == arg3.sui_stake, 1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.fund_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v8 = NewGame{
            game_id         : 0x2::object::uid_to_inner(&v1.id),
            player          : 0x2::tx_context::sender(arg4),
            user_randomness : arg1,
            guess           : arg0,
            stake           : v0,
        };
        0x2::event::emit<NewGame>(v8);
        v1
    }

    public entry fun play(arg0: &mut Game, arg1: vector<u8>, arg2: &mut HouseData, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.challenged, 8);
        let v0 = 0x2::object::id_bytes<Game>(arg0);
        let v1 = v0;
        0x1::vector::append<u8>(&mut v1, arg0.user_randomness);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg2.public_key, &v1), 3);
        let v2 = 0x2::hash::blake2b256(&arg1);
        let v3 = arg0.guess == *0x1::vector::borrow<u8>(&v2, 0) % 2;
        let v4 = 0x2::dynamic_field::borrow_mut<address, Info>(&mut arg2.id, 0x2::tx_context::sender(arg3));
        let v5 = &mut v4.turn;
        let v6 = &mut v4.check_turn;
        let v7 = 0x2::object::id<Game>(arg0);
        assert!(&mut v4.turn_game == &v7, 12);
        if (v3) {
            *v5 = *v5 + 1;
            if (*v5 == arg2.number) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.fund_balance, arg2.rewards_balance, arg3), arg0.player);
                let v8 = OutWin{
                    player_win : true,
                    player     : arg0.player,
                    amount_win : arg2.rewards_balance,
                    turn       : *v5,
                };
                0x2::event::emit<OutWin>(v8);
                *v5 = 0;
            };
        } else {
            *v5 = 0;
        };
        *v6 = true;
        arg0.challenged = true;
        let v9 = Outcome{
            game_id    : 0x2::object::uid_to_inner(&arg0.id),
            player_won : v3,
            player     : arg0.player,
            turn       : *v5,
        };
        0x2::event::emit<Outcome>(v9);
    }

    public entry fun start_game(arg0: u8, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut HouseData, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Game>(internal_start_game(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun top_turn(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 4);
        arg0.number = arg1;
    }

    public entry fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fund_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun top_w(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 4);
        arg0.rewards_balance = arg1;
    }

    public entry fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fund_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.fund_balance), arg1), arg0.house);
    }

    // decompiled from Move bytecode v6
}

