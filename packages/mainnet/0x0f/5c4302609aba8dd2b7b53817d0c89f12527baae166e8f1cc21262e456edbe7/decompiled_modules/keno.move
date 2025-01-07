module 0xf5c4302609aba8dd2b7b53817d0c89f12527baae166e8f1cc21262e456edbe7::keno {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier: vector<u8>,
        range_min: u8,
        range_max: u8,
        multipliers: vector<vector<u64>>,
        stake_amount_options: 0x2::table::Table<u64, bool>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        stake: 0x2::balance::Balance<T0>,
        guesses: vector<u8>,
        seed: vector<u8>,
        timestamp: u64,
    }

    struct GameStarted<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guesses: vector<u8>,
        seed: vector<u8>,
        stake_amount: u64,
    }

    struct OutCome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        result: vector<u8>,
        reward: u64,
    }

    struct KENO has drop {
        dummy_field: bool,
    }

    public fun assert_game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) {
        assert!(game_exists<T0>(arg0, arg1), 2);
    }

    fun assert_guesses<T0>(arg0: &House<T0>, arg1: &vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(arg1);
        assert!(v0 > 0 && v0 <= 10, 5);
        let v1 = 0;
        let v2 = 0x2::table::new<u8, u8>(arg2);
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u8>(arg1, v1);
            assert!(!0x2::table::contains<u8, u8>(&v2, v3) && v3 >= arg0.range_min && v3 <= arg0.range_max, 5);
            0x2::table::add<u8, u8>(&mut v2, v3, 0);
            v1 = v1 + 1;
        };
        0x2::table::drop<u8, u8>(v2);
    }

    public fun borrow_game<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : &Game<T0> {
        0x2::dynamic_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    fun compute_reward_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000 as u128)) as u64)
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: vector<vector<u64>>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<House<T0>>(new_house<T0>(arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun finish_game<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : vector<u8> {
        assert_game_exists<T0>(arg0, arg1);
        let Game {
            id        : v0,
            player    : v1,
            stake     : v2,
            guesses   : v3,
            seed      : v4,
            timestamp : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v6 = v3;
        let v7 = v2;
        let v8 = v0;
        let v9 = 0x2::object::uid_to_bytes(&v8);
        0x1::vector::append<u8>(&mut v9, v4);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.verifier, &v9), 3);
        0x2::object::delete(v8);
        let v10 = 0xf5c4302609aba8dd2b7b53817d0c89f12527baae166e8f1cc21262e456edbe7::randomness::new(arg2);
        let v11 = 0x1::vector::empty<u8>();
        let v12 = 0x2::table::new<u8, u8>(arg3);
        let v13 = 0;
        while (v13 < 10) {
            let v14 = (0xf5c4302609aba8dd2b7b53817d0c89f12527baae166e8f1cc21262e456edbe7::randomness::next_u256_in_range(&mut v10, (arg0.range_min as u256), (arg0.range_max as u256)) as u8);
            if (!0x2::table::contains<u8, u8>(&v12, v14)) {
                0x1::vector::push_back<u8>(&mut v11, v14);
                0x2::table::add<u8, u8>(&mut v12, v14, 1);
                v13 = v13 + 1;
            };
        };
        let v15 = 0;
        let v16 = 0x1::vector::length<u8>(&v6);
        let v17 = 0;
        while (v17 < v16) {
            if (0x2::table::contains<u8, u8>(&v12, *0x1::vector::borrow<u8>(&v6, v17))) {
                v15 = v15 + 1;
            };
            v17 = v17 + 1;
        };
        0x2::table::drop<u8, u8>(v12);
        let v18 = 0x2::balance::value<T0>(&v7);
        let v19 = compute_reward_amount(v18, *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.multipliers, v16 - 1), v15));
        if (v19 > v18) {
            let v20 = v19 - v18;
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v20, 0);
            0x2::balance::join<T0>(&mut v7, 0x2::balance::split<T0>(&mut arg0.balance, v20));
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(&mut v7, v18 - v19));
        };
        if (0x2::balance::value<T0>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        let v21 = OutCome<T0>{
            game_id : arg1,
            player  : v1,
            result  : v11,
            reward  : v19,
        };
        0x2::event::emit<OutCome<T0>>(v21);
        v11
    }

    public fun game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun game_guesses<T0>(arg0: &Game<T0>) : &vector<u8> {
        &arg0.guesses
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_stake_amount<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: KENO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KENO>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun new_game<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Game<T0> {
        Game<T0>{
            id        : 0x2::object::new(arg5),
            player    : arg0,
            stake     : arg1,
            guesses   : arg2,
            seed      : arg3,
            timestamp : arg4,
        }
    }

    fun new_house<T0>(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: vector<vector<u64>>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) : House<T0> {
        assert!(arg2 > arg1, 7);
        assert!(0x1::vector::length<vector<u64>>(&arg3) == 10, 6);
        let v0 = House<T0>{
            id                   : 0x2::object::new(arg5),
            verifier             : arg0,
            range_min            : arg1,
            range_max            : arg2,
            multipliers          : 0x1::vector::empty<vector<u64>>(),
            stake_amount_options : 0x2::table::new<u64, bool>(arg5),
            balance              : 0x2::balance::zero<T0>(),
        };
        let v1 = 0;
        while (v1 < 10) {
            assert!(0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg3, v1)) == v1 + 2, 6);
            0x1::vector::push_back<vector<u64>>(&mut v0.multipliers, *0x1::vector::borrow<vector<u64>>(&arg3, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg4)) {
            0x2::table::add<u64, bool>(&mut v0.stake_amount_options, *0x1::vector::borrow<u64>(&arg4, v2), true);
            v2 = v2 + 1;
        };
        v0
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public entry fun remove_stake_amount_option<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        0x2::table::remove<u64, bool>(&mut arg1.stake_amount_options, arg2);
    }

    public entry fun set_multipliers<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<vector<u64>>) {
        assert!(0x1::vector::length<vector<u64>>(&arg2) == 10, 6);
        let v0 = 0;
        while (v0 < 10) {
            assert!(0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg2, v0)) == v0 + 2, 6);
            *0x1::vector::borrow_mut<vector<u64>>(&mut arg1.multipliers, v0) = *0x1::vector::borrow_mut<vector<u64>>(&mut arg2, v0);
            v0 = v0 + 1;
        };
    }

    public entry fun set_range_number<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u8, arg3: u8) {
        assert!(arg3 > arg2, 7);
        arg1.range_min = arg2;
        arg1.range_max = arg3;
    }

    public entry fun set_stake_amount_option<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        0x2::table::add<u64, bool>(&mut arg1.stake_amount_options, arg2, true);
    }

    public entry fun set_verifier<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<u8>) {
        arg1.verifier = arg2;
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 1024, 1);
        assert_guesses<T0>(arg0, &arg3, arg5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::table::contains<u64, bool>(&arg0.stake_amount_options, v0), 4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = new_game<T0>(v1, 0x2::coin::into_balance<T0>(arg1), arg3, arg2, 0x2::clock::timestamp_ms(arg4), arg5);
        let v3 = 0x2::object::id<Game<T0>>(&v2);
        let v4 = GameStarted<T0>{
            game_id      : v3,
            player       : v1,
            guesses      : arg3,
            seed         : arg2,
            stake_amount : v0,
        };
        0x2::event::emit<GameStarted<T0>>(v4);
        0x2::dynamic_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v3, v2);
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

