module 0xf41a33e09f396b860e82f46ed47485c6694f416a409975428f4e0d4f8ea2d892::coin_flip {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier: vector<u8>,
        multiplier: u64,
        stake_amount_options: 0x2::table::Table<u64, bool>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        total_stake: 0x2::balance::Balance<T0>,
        guess: u8,
        seed: vector<u8>,
        timestamp: u64,
    }

    struct GameStarted<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u8,
        seed: vector<u8>,
        stake_amount: u64,
    }

    struct OutCome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        result: u8,
        player_won: bool,
        reward: u64,
    }

    struct COIN_FLIP has drop {
        dummy_field: bool,
    }

    public fun assert_game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) {
        assert!(game_exists<T0>(arg0, arg1), 2);
    }

    public fun borrow_game<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : &Game<T0> {
        0x2::dynamic_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun compute_house_stake_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * ((arg1 - 1000000) as u128) / (1000000 as u128)) as u64)
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<House<T0>>(new_house<T0>(arg1, arg2, arg3, arg4));
    }

    public entry fun finish_game<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert_game_exists<T0>(arg0, arg1);
        let Game {
            id          : v0,
            player      : v1,
            total_stake : v2,
            guess       : v3,
            seed        : v4,
            timestamp   : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v6 = v2;
        let v7 = v0;
        let v8 = 0x2::object::uid_to_bytes(&v7);
        0x1::vector::append<u8>(&mut v8, v4);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.verifier, &v8), 3);
        0x2::object::delete(v7);
        let v9 = 0x2::hash::blake2b256(&arg2);
        let v10 = *0x1::vector::borrow<u8>(&v9, 0) % 2;
        let v11 = v3 == v10;
        let v12 = if (v11) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg3), v1);
            0x2::balance::value<T0>(&v6)
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, v6);
            0
        };
        let v13 = OutCome<T0>{
            game_id    : arg1,
            player     : v1,
            result     : v10,
            player_won : v11,
            reward     : v12,
        };
        0x2::event::emit<OutCome<T0>>(v13);
        v11
    }

    public fun game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun game_guess<T0>(arg0: &Game<T0>) : u8 {
        arg0.guess
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_stake_amount<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_stake)
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: COIN_FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<COIN_FLIP>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun new_game<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Game<T0> {
        Game<T0>{
            id          : 0x2::object::new(arg5),
            player      : arg0,
            total_stake : arg1,
            guess       : arg2,
            seed        : arg3,
            timestamp   : arg4,
        }
    }

    fun new_house<T0>(arg0: vector<u8>, arg1: u64, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : House<T0> {
        assert!(arg1 >= 1000000, 6);
        let v0 = House<T0>{
            id                   : 0x2::object::new(arg3),
            verifier             : arg0,
            multiplier           : arg1,
            stake_amount_options : 0x2::table::new<u64, bool>(arg3),
            balance              : 0x2::balance::zero<T0>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            0x2::table::add<u64, bool>(&mut v0.stake_amount_options, *0x1::vector::borrow<u64>(&arg2, v1), true);
            v1 = v1 + 1;
        };
        v0
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public entry fun remove_stake_amount_option<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        0x2::table::remove<u64, bool>(&mut arg1.stake_amount_options, arg2);
    }

    public entry fun set_multiplier<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        assert!(arg2 >= 1000000, 6);
        arg1.multiplier = arg2;
    }

    public entry fun set_stake_amount_option<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        0x2::table::add<u64, bool>(&mut arg1.stake_amount_options, arg2, true);
    }

    public entry fun set_verifier<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<u8>) {
        arg1.verifier = arg2;
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0 || arg3 == 1, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 1024, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::table::contains<u64, bool>(&arg0.stake_amount_options, v0), 4);
        let v1 = compute_house_stake_amount(v0, arg0.multiplier);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut arg0.balance, v1));
        let v4 = new_game<T0>(v2, v3, arg3, arg2, 0x2::clock::timestamp_ms(arg4), arg5);
        let v5 = 0x2::object::id<Game<T0>>(&v4);
        let v6 = GameStarted<T0>{
            game_id      : v5,
            player       : v2,
            guess        : arg3,
            seed         : arg2,
            stake_amount : v0,
        };
        0x2::event::emit<GameStarted<T0>>(v6);
        0x2::dynamic_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v5, v4);
    }

    public entry fun top_up<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

