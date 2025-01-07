module 0x339466726b3f81fbfcc2385d3c5da9fcebf6f5e48ca1d33fed00f5057d9edab3::dice {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier: vector<u8>,
        min_stake: u64,
        max_stake: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        total_stake: 0x2::balance::Balance<T0>,
        target_number: u8,
        guess: u8,
        seed: vector<u8>,
        timestamp: u64,
    }

    struct GameStarted<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        target_number: u8,
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

    struct DICE has drop {
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

    fun compute_multiplier(arg0: u8, arg1: u8) : u64 {
        if (arg1 == 0) {
            ((99 * (1000000 as u128) / (arg0 as u128)) as u64)
        } else {
            ((99 * (1000000 as u128) / (99 - (arg0 as u128))) as u64)
        }
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<House<T0>>(new_house<T0>(arg1, arg2, arg3, arg4));
    }

    public entry fun finish_game<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert_game_exists<T0>(arg0, arg1);
        let Game {
            id            : v0,
            player        : v1,
            total_stake   : v2,
            target_number : v3,
            guess         : v4,
            seed          : v5,
            timestamp     : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v2;
        let v8 = v0;
        let v9 = 0x2::object::uid_to_bytes(&v8);
        0x1::vector::append<u8>(&mut v9, v5);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.verifier, &v9), 3);
        0x2::object::delete(v8);
        let v10 = 0x2::hash::blake2b256(&arg2);
        let v11 = *0x1::vector::borrow<u8>(&v10, 0) % 100;
        let v12 = v4 == 0 && v11 < v3 || v11 > v3;
        let v13 = if (v12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), v1);
            0x2::balance::value<T0>(&v7)
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, v7);
            0
        };
        let v14 = OutCome<T0>{
            game_id    : arg1,
            player     : v1,
            result     : v11,
            player_won : v12,
            reward     : v13,
        };
        0x2::event::emit<OutCome<T0>>(v14);
        v12
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

    public fun game_target_number<T0>(arg0: &Game<T0>) : u8 {
        arg0.target_number
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: DICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DICE>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun new_game<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Game<T0> {
        Game<T0>{
            id            : 0x2::object::new(arg6),
            player        : arg0,
            total_stake   : arg1,
            target_number : arg2,
            guess         : arg3,
            seed          : arg4,
            timestamp     : arg5,
        }
    }

    fun new_house<T0>(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : House<T0> {
        House<T0>{
            id        : 0x2::object::new(arg3),
            verifier  : arg0,
            min_stake : arg1,
            max_stake : arg2,
            balance   : 0x2::balance::zero<T0>(),
        }
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public entry fun set_max_stake<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.max_stake = arg2;
    }

    public entry fun set_min_stake<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.min_stake = arg2;
    }

    public entry fun set_verifier<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<u8>) {
        arg1.verifier = arg2;
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 0 && arg3 >= 1 && arg3 <= 95 || arg4 == 1 && arg3 >= 4 && arg3 <= 98, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 1024, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.min_stake && v0 <= arg0.max_stake, 4);
        let v1 = compute_house_stake_amount(v0, compute_multiplier(arg3, arg4));
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 0);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut arg0.balance, v1));
        let v4 = new_game<T0>(v2, v3, arg3, arg4, arg2, 0x2::clock::timestamp_ms(arg5), arg6);
        let v5 = 0x2::object::id<Game<T0>>(&v4);
        let v6 = GameStarted<T0>{
            game_id       : v5,
            player        : v2,
            target_number : arg3,
            guess         : arg4,
            seed          : arg2,
            stake_amount  : v0,
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

