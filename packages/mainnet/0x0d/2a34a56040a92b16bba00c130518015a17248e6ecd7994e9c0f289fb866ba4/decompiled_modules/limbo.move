module 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::limbo {
    struct BetEvent<phantom T0> has copy, drop {
        multiplier: u64,
        stake_amount: u64,
    }

    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        bet_events: vector<BetEvent<T0>>,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        result: u64,
        player: address,
        player_won: bool,
        pnl: u64,
        challenged: bool,
    }

    struct BetOutcome<phantom T0> has copy, drop {
        multiplier: u64,
        stake_amount: u64,
        bet_won: bool,
        pnl: u64,
    }

    struct PlayerBetOutcomes<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        result: u64,
        player: address,
        bet_outcomes: vector<BetOutcome<T0>>,
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
        player: address,
        seed: vector<u8>,
        start_epoch: u64,
        total_bet_size: u64,
        bets: vector<Bet<T0>>,
    }

    struct Bet<phantom T0> has store {
        multiplier: u64,
        stake: 0x2::coin::Coin<T0>,
        payout: 0x2::coin::Coin<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun challenge<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 3);
        let Game {
            id               : v0,
            verifier_pub_key : _,
            player           : v2,
            seed             : _,
            start_epoch      : v4,
            total_bet_size   : _,
            bets             : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v6;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::epoch(arg2) > v4 + 7, 2);
        while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
            let Bet {
                multiplier : _,
                stake      : v9,
                payout     : v10,
            } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
            let v11 = v10;
            0x2::coin::join<T0>(&mut v11, v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v2);
            let v12 = Outcome<T0>{
                game_id    : arg1,
                result     : 0,
                player     : v2,
                player_won : true,
                pnl        : 0x2::coin::value<T0>(&v11),
                challenged : true,
            };
            0x2::event::emit<Outcome<T0>>(v12);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
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
            player           : v2,
            seed             : v3,
            start_epoch      : _,
            total_bet_size   : _,
            bets             : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, arg2);
        let v7 = v6;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x2::object::uid_to_bytes(&v9);
        0x1::vector::append<u8>(&mut v10, v3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v8, &v10), 1);
        0x2::object::delete(v9);
        let v11 = 0x2::hash::blake2b256(&arg3);
        let v12 = 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math::bytes_to_u256(&v11);
        let v13 = 0x1::vector::empty<BetOutcome<T0>>();
        while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
            let Bet {
                multiplier : v14,
                stake      : v15,
                payout     : v16,
            } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
            let v17 = v16;
            let v18 = v15;
            let v19 = 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math::player_won(v14, v12);
            let v20 = if (v19) {
                0x2::coin::join<T0>(&mut v17, v18);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v17, v2);
                0x2::coin::value<T0>(&v17)
            } else {
                0x2::coin::join<T0>(&mut v18, v17);
                let v21 = Limbo{dummy_field: false};
                0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, Limbo>(v21, arg0, v18);
                0x2::coin::value<T0>(&v18)
            };
            let v22 = BetOutcome<T0>{
                multiplier   : v14,
                stake_amount : 0x2::coin::value<T0>(&v18),
                bet_won      : v19,
                pnl          : v20,
            };
            0x1::vector::push_back<BetOutcome<T0>>(&mut v13, v22);
            let v23 = Outcome<T0>{
                game_id    : arg2,
                result     : 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math::get_result(v12),
                player     : v2,
                player_won : v19,
                pnl        : v20,
                challenged : false,
            };
            0x2::event::emit<Outcome<T0>>(v23);
        };
        let v24 = PlayerBetOutcomes<T0>{
            game_id      : arg2,
            result       : 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math::get_result(v12),
            player       : v2,
            bet_outcomes : v13,
            challenged   : false,
        };
        0x2::event::emit<PlayerBetOutcomes<T0>>(v24);
        0x1::vector::destroy_empty<Bet<T0>>(v7);
    }

    public fun start_game<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<0x2::coin::Coin<T0>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg4);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 7);
        assert!(v0 <= arg1.max_bet_count, 5);
        assert!(0x1::vector::length<u8>(&arg2) >= 32, 4);
        let v1 = 0x1::vector::empty<Bet<T0>>();
        let v2 = 0x1::vector::empty<BetEvent<T0>>();
        let v3 = 0;
        let v4 = Limbo{dummy_field: false};
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg4)) {
            let v5 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg4);
            let v6 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v7 = 0x2::coin::value<T0>(&v5);
            assert!(v7 > 0, 0);
            0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, Limbo>(v4, arg0, v7, arg5);
            let v8 = Bet<T0>{
                multiplier : v6,
                stake      : v5,
                payout     : 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::take<T0, Limbo>(v4, arg0, 0x2020d7ebce426aead22a743b8b0f454302be8fb982837e02ef5a75f45466fb9::math::payout_amount(v7, v6), arg5),
            };
            let v9 = BetEvent<T0>{
                multiplier   : v6,
                stake_amount : v7,
            };
            0x1::vector::push_back<Bet<T0>>(&mut v1, v8);
            0x1::vector::push_back<BetEvent<T0>>(&mut v2, v9);
            v3 = v3 + v7;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
        assert!(v3 <= 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::max_risk<T0, Limbo>(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::borrow_house<T0>(arg0)), 6);
        let v10 = 0x2::tx_context::sender(arg5);
        let v11 = 0x2::object::new(arg5);
        let v12 = 0x2::object::uid_to_inner(&v11);
        let v13 = Game<T0>{
            id               : v11,
            verifier_pub_key : pub_key(arg1),
            player           : v10,
            seed             : arg2,
            start_epoch      : 0x2::tx_context::epoch(arg5),
            total_bet_size   : v3,
            bets             : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg1.id, v12, v13);
        let v14 = NewGame<T0>{
            game_id    : v12,
            player     : v10,
            bet_events : v2,
        };
        0x2::event::emit<NewGame<T0>>(v14);
        v12
    }

    public fun update_max_bet_count(arg0: &AdminCap, arg1: &mut Verifier, arg2: u64) {
        arg1.max_bet_count = arg2;
    }

    public fun update_pub_key(arg0: &AdminCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

