module 0x32a7bd6043703cf459f0270433be4f4df4b03e0dc98e38fad9aa12af2205c3e3::limbo {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        multiplier: u64,
        stake_amount: u64,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_won: bool,
        pnl: u64,
        result: u64,
        challenged: bool,
    }

    struct Limbo has copy, drop {
        dummy_field: bool,
    }

    struct Verifier has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        verifier_pub_key: vector<u8>,
        multiplier: u64,
        seed: vector<u8>,
        start_epoch: u64,
        stake: 0x2::coin::Coin<T0>,
        payout: 0x2::coin::Coin<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun batch_settle<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: vector<0x2::object::ID>, arg3: vector<vector<u8>>) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<vector<u8>>(&arg3), 4);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg2);
            if (game_exists<T0>(arg1, v0)) {
                settle<T0>(arg0, arg1, v0, 0x1::vector::pop_back<vector<u8>>(&mut arg3));
            };
        };
    }

    public fun borrow_game<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : &Game<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun challenge<T0>(arg0: &mut Verifier, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 3);
        let Game {
            id               : v0,
            player           : v1,
            verifier_pub_key : _,
            multiplier       : _,
            seed             : _,
            start_epoch      : v5,
            stake            : v6,
            payout           : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v8 = v7;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::epoch(arg2) > v5 + 7, 2);
        0x2::coin::join<T0>(&mut v8, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v1);
        let v9 = Outcome<T0>{
            game_id    : arg1,
            player     : v1,
            player_won : true,
            pnl        : 0x2::coin::value<T0>(&v8),
            result     : 0,
            challenged : true,
        };
        0x2::event::emit<Outcome<T0>>(v9);
    }

    public entry fun create_verifier(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Verifier{
            id      : 0x2::object::new(arg2),
            pub_key : arg1,
        };
        0x2::transfer::share_object<Verifier>(v0);
    }

    public fun game_exists<T0>(arg0: &Verifier, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun game_multiplier<T0>(arg0: &Game<T0>) : u64 {
        arg0.multiplier
    }

    public fun game_payout_amount<T0>(arg0: &Game<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.payout)
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_stake_amount<T0>(arg0: &Game<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.stake)
    }

    public fun game_start_epoch<T0>(arg0: &Game<T0>) : u64 {
        arg0.start_epoch
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun pub_key(arg0: &Verifier) : vector<u8> {
        arg0.pub_key
    }

    public entry fun settle<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: 0x2::object::ID, arg3: vector<u8>) : bool {
        if (!game_exists<T0>(arg1, arg2)) {
            return false
        };
        let Game {
            id               : v0,
            player           : v1,
            verifier_pub_key : v2,
            multiplier       : v3,
            seed             : v4,
            start_epoch      : _,
            stake            : v6,
            payout           : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg1.id, arg2);
        let v8 = v7;
        let v9 = v6;
        let v10 = v2;
        let v11 = v0;
        let v12 = 0x2::object::uid_to_bytes(&v11);
        0x1::vector::append<u8>(&mut v12, v4);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &v10, &v12), 1);
        0x2::object::delete(v11);
        let v13 = 0x2::hash::blake2b256(&arg3);
        let v14 = bytes_to_u256(&v13);
        let v15 = 0x32a7bd6043703cf459f0270433be4f4df4b03e0dc98e38fad9aa12af2205c3e3::math::player_won(v3, v14);
        let v16 = if (v15) {
            0x2::coin::join<T0>(&mut v8, v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v1);
            0x2::coin::value<T0>(&v8)
        } else {
            let v17 = Limbo{dummy_field: false};
            0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, Limbo>(v17, arg0, v9);
            0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::put<T0, Limbo>(v17, arg0, v8);
            0x2::coin::value<T0>(&v9)
        };
        let v18 = Outcome<T0>{
            game_id    : arg2,
            player     : v1,
            player_won : v15,
            pnl        : v16,
            result     : 0x32a7bd6043703cf459f0270433be4f4df4b03e0dc98e38fad9aa12af2205c3e3::math::get_result(v14),
            challenged : false,
        };
        0x2::event::emit<Outcome<T0>>(v18);
        v15
    }

    public entry fun start_game<T0>(arg0: &mut 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg1: &mut Verifier, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg3) >= 32, 5);
        let v1 = Limbo{dummy_field: false};
        0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::add_volume<T0, Limbo>(v1, arg0, v0, arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = Game<T0>{
            id               : v2,
            player           : v4,
            verifier_pub_key : pub_key(arg1),
            multiplier       : arg2,
            seed             : arg3,
            start_epoch      : 0x2::tx_context::epoch(arg5),
            stake            : arg4,
            payout           : 0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::take<T0, Limbo>(v1, arg0, 0x32a7bd6043703cf459f0270433be4f4df4b03e0dc98e38fad9aa12af2205c3e3::math::payout_amount(v0, arg2), arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg1.id, v3, v5);
        let v6 = NewGame<T0>{
            game_id      : v3,
            player       : v4,
            multiplier   : arg2,
            stake_amount : v0,
        };
        0x2::event::emit<NewGame<T0>>(v6);
        v3
    }

    public entry fun update_pub_key(arg0: &AdminCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

