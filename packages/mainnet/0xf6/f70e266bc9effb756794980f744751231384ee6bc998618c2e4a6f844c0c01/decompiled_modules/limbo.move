module 0xf6f70e266bc9effb756794980f744751231384ee6bc998618c2e4a6f844c0c01::limbo {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
    }

    struct PlayerBet<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        multiplier: u64,
        stake_amount: u64,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        result: u64,
        player: address,
        player_won: bool,
        pnl: u64,
        challenged: bool,
    }

    struct Limbo has copy, drop {
        dummy_field: bool,
    }

    struct Verifier has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        max_bet_count: u64,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier_pub_key: vector<u8>,
        seed: vector<u8>,
        start_epoch: u64,
        max_bet_count: u64,
        total_bet_size: u64,
        bets: vector<Bet<T0>>,
    }

    struct Bet<phantom T0> has store {
        player: address,
        multiplier: u64,
        stake: 0x2::coin::Coin<T0>,
        payout: 0x2::coin::Coin<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun borrow_game<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : &Game<T0> {
        assert!(game_exists<T0>(arg0, arg1), 3);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun borrow_game_mut<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID) : &mut Game<T0> {
        assert!(game_exists<T0>(arg0, arg1), 3);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1)
    }

    public fun challenge<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 3);
        let Game {
            id               : v0,
            verifier_pub_key : _,
            seed             : _,
            start_epoch      : v3,
            max_bet_count    : _,
            total_bet_size   : _,
            bets             : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v6;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::epoch(arg2) > v3 + 7, 2);
        while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
            let Bet {
                player     : v8,
                multiplier : _,
                stake      : v10,
                payout     : v11,
            } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
            let v12 = v11;
            0x2::coin::join<T0>(&mut v12, v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v8);
            let v13 = Outcome<T0>{
                game_id    : arg1,
                result     : 0,
                player     : v8,
                player_won : true,
                pnl        : 0x2::coin::value<T0>(&v12),
                challenged : true,
            };
            0x2::event::emit<Outcome<T0>>(v13);
        };
        0x1::vector::destroy_empty<Bet<T0>>(v7);
    }

    public fun create_verifier(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Verifier{
            id            : 0x2::object::new(arg3),
            pub_key       : arg1,
            max_bet_count : arg2,
        };
        0x2::transfer::share_object<Verifier>(v0);
    }

    public fun game_exists<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun game_max_bet_count<T0>(arg0: &Game<T0>) : u64 {
        arg0.max_bet_count
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_start_epoch<T0>(arg0: &Game<T0>) : u64 {
        arg0.start_epoch
    }

    public fun game_total_bet_size<T0>(arg0: &Game<T0>) : u64 {
        arg0.total_bet_size
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun place_bet<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 0);
        let v1 = Limbo{dummy_field: false};
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, Limbo>(v1, arg0, v0, arg5);
        let v2 = borrow_game_mut<T0>(arg1, arg2);
        assert!(0x1::vector::length<Bet<T0>>(&v2.bets) < game_max_bet_count<T0>(v2), 5);
        v2.total_bet_size = v2.total_bet_size + v0;
        assert!(game_total_bet_size<T0>(v2) <= 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::max_risk<T0, Limbo>(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::borrow_house<T0>(arg0)) / 200, 6);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Bet<T0>{
            player     : v3,
            multiplier : arg3,
            stake      : arg4,
            payout     : 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::take<T0, Limbo>(v1, arg0, 0xf6f70e266bc9effb756794980f744751231384ee6bc998618c2e4a6f844c0c01::math::payout_amount(v0, arg3), arg5),
        };
        0x1::vector::push_back<Bet<T0>>(&mut v2.bets, v4);
        let v5 = PlayerBet<T0>{
            game_id      : arg2,
            player       : v3,
            multiplier   : arg3,
            stake_amount : v0,
        };
        0x2::event::emit<PlayerBet<T0>>(v5);
    }

    public fun pub_key(arg0: &Verifier) : vector<u8> {
        arg0.pub_key
    }

    public fun settle<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: 0x2::object::ID, arg3: vector<u8>) {
        if (!game_exists<T0>(arg1, arg2)) {
            return
        };
        let Game {
            id               : v0,
            verifier_pub_key : v1,
            seed             : v2,
            start_epoch      : _,
            max_bet_count    : _,
            total_bet_size   : _,
            bets             : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, arg2);
        let v7 = v6;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x2::object::uid_to_bytes(&v9);
        0x1::vector::append<u8>(&mut v10, v2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v8, &v10), 1);
        0x2::object::delete(v9);
        let v11 = 0x2::hash::blake2b256(&arg3);
        let v12 = 0xf6f70e266bc9effb756794980f744751231384ee6bc998618c2e4a6f844c0c01::math::bytes_to_u256(&v11);
        while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
            let Bet {
                player     : v13,
                multiplier : v14,
                stake      : v15,
                payout     : v16,
            } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
            let v17 = v16;
            let v18 = v15;
            let v19 = 0xf6f70e266bc9effb756794980f744751231384ee6bc998618c2e4a6f844c0c01::math::player_won(v14, v12);
            let v20 = if (v19) {
                0x2::coin::join<T0>(&mut v17, v18);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v17, v13);
                0x2::coin::value<T0>(&v17)
            } else {
                let v21 = Limbo{dummy_field: false};
                0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, Limbo>(v21, arg0, v18);
                0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, Limbo>(v21, arg0, v17);
                0x2::coin::value<T0>(&v18)
            };
            let v22 = Outcome<T0>{
                game_id    : arg2,
                result     : 0xf6f70e266bc9effb756794980f744751231384ee6bc998618c2e4a6f844c0c01::math::get_result(v12),
                player     : v13,
                player_won : v19,
                pnl        : v20,
                challenged : false,
            };
            0x2::event::emit<Outcome<T0>>(v22);
        };
        0x1::vector::destroy_empty<Bet<T0>>(v7);
    }

    public fun start_game<T0>(arg0: &mut Verifier, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg1) >= 32, 4);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Game<T0>{
            id               : v0,
            verifier_pub_key : pub_key(arg0),
            seed             : arg1,
            start_epoch      : 0x2::tx_context::epoch(arg2),
            max_bet_count    : arg0.max_bet_count,
            total_bet_size   : 0,
            bets             : 0x1::vector::empty<Bet<T0>>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v1, v2);
        let v3 = NewGame<T0>{game_id: v1};
        0x2::event::emit<NewGame<T0>>(v3);
        v1
    }

    public fun update_max_bet_count(arg0: &AdminCap, arg1: &mut Verifier, arg2: u64) {
        arg1.max_bet_count = arg2;
    }

    public fun update_pub_key(arg0: &AdminCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

