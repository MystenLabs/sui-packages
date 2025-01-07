module 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::roulette {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        verifier: vector<u8>,
        min_stake_amount: u64,
        max_stake_amount: u64,
        multipliers: vector<u64>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Bet<phantom T0> has store {
        type: u8,
        guess: u8,
        total_stake: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        bets: vector<Bet<T0>>,
        seed: vector<u8>,
        timestamp: u64,
    }

    struct GameStarted<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        bet_types: vector<u8>,
        bet_guesses: vector<u8>,
        stake_amounts: vector<u64>,
        seed: vector<u8>,
    }

    struct OutCome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        result: u8,
        reward: u64,
    }

    struct ROULETTE has drop {
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

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<House<T0>>(new_house<T0>(arg1, arg2, arg3, arg4, arg5));
    }

    fun determine_wining<T0>(arg0: &mut House<T0>, arg1: Bet<T0>, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = false;
        let Bet {
            type        : v1,
            guess       : v2,
            total_stake : v3,
        } = arg1;
        let v4 = v3;
        if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::number()) {
            v0 = v2 == arg2;
        } else if (arg2 > 0) {
            if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::color()) {
                if (arg2 >= 1 && arg2 <= 10 || arg2 >= 19 && arg2 <= 28) {
                    v0 = arg2 % 2 == v2;
                } else {
                    v0 = arg2 % 2 == (0x2::math::diff((v2 as u64), 1) as u8);
                };
            } else if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::column()) {
                v0 = v2 == arg2 % 3;
            } else if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::dozen()) {
                let v5 = arg2 >= v2 * 12 + 1 && arg2 <= (v2 + 1) * 12;
                v0 = v5;
            } else if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::eighteen()) {
                v0 = v2 == arg2 / 19;
            } else if (v1 == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::modulus()) {
                v0 = v2 == arg2 % 2;
            };
        };
        if (v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), arg3);
            0x2::balance::value<T0>(&v4)
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, v4);
            0
        }
    }

    public entry fun finish_game<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : u8 {
        assert_game_exists<T0>(arg0, arg1);
        let Game {
            id        : v0,
            player    : v1,
            bets      : v2,
            seed      : v3,
            timestamp : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v5 = v2;
        let v6 = v0;
        let v7 = 0x2::object::uid_to_bytes(&v6);
        0x1::vector::append<u8>(&mut v7, v3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.verifier, &v7), 3);
        0x2::object::delete(v6);
        let v8 = 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::randomness::new(arg2);
        let v9 = ((0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::randomness::next_u256(&mut v8) % 37) as u8);
        let v10 = 0;
        while (0x1::vector::length<Bet<T0>>(&v5) > 0) {
            v10 = v10 + determine_wining<T0>(arg0, 0x1::vector::pop_back<Bet<T0>>(&mut v5), v9, v1, arg3);
        };
        0x1::vector::destroy_empty<Bet<T0>>(v5);
        let v11 = OutCome<T0>{
            game_id : arg1,
            player  : v1,
            result  : v9,
            reward  : v10,
        };
        0x2::event::emit<OutCome<T0>>(v11);
        v9
    }

    public fun game_bets<T0>(arg0: &Game<T0>) : &vector<Bet<T0>> {
        &arg0.bets
    }

    public fun game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_stake_amount<T0>(arg0: &Game<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Bet<T0>>(&arg0.bets)) {
            v1 = v1 + 0x2::balance::value<T0>(&0x1::vector::borrow<Bet<T0>>(&arg0.bets, v0).total_stake);
            v0 = v0 + 1;
        };
        v1
    }

    public fun house_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun init(arg0: ROULETTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ROULETTE>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun new_game<T0>(arg0: address, arg1: vector<Bet<T0>>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Game<T0> {
        Game<T0>{
            id        : 0x2::object::new(arg4),
            player    : arg0,
            bets      : arg1,
            seed      : arg2,
            timestamp : arg3,
        }
    }

    fun new_house<T0>(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : House<T0> {
        assert!(0x1::vector::length<u64>(&arg3) == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::number_of_bet_types(), 5);
        House<T0>{
            id               : 0x2::object::new(arg4),
            verifier         : arg0,
            min_stake_amount : arg1,
            max_stake_amount : arg2,
            multipliers      : arg3,
            balance          : 0x2::balance::zero<T0>(),
        }
    }

    public fun player<T0>(arg0: &Game<T0>) : address {
        arg0.player
    }

    public entry fun set_max_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.max_stake_amount = arg2;
    }

    public entry fun set_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.min_stake_amount = arg2;
    }

    public entry fun set_multipliers<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::number_of_bet_types(), 5);
        arg1.multipliers = arg2;
    }

    public entry fun set_verifier<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: vector<u8>) {
        arg1.verifier = arg2;
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 1024, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 0x1::vector::length<u8>(&arg4) && 0x1::vector::length<u8>(&arg3) == 0x1::vector::length<u64>(&arg5), 6);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let v2 = 0x1::vector::empty<Bet<T0>>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&arg3)) {
            let v5 = *0x1::vector::borrow<u8>(&arg3, v4);
            let v6 = *0x1::vector::borrow<u8>(&arg4, v4);
            let v7 = *0x1::vector::borrow<u64>(&arg5, v4);
            assert!(0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types::is_valid(v5, v6) && v7 > 0 && 0x2::balance::value<T0>(&v1) >= v7, 4);
            let v8 = 0x2::balance::split<T0>(&mut v1, v7);
            let v9 = compute_house_stake_amount(v7, *0x1::vector::borrow<u64>(&arg0.multipliers, (v5 as u64)));
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v9, 0);
            0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut arg0.balance, v9));
            let v10 = Bet<T0>{
                type        : v5,
                guess       : v6,
                total_stake : v8,
            };
            0x1::vector::push_back<Bet<T0>>(&mut v2, v10);
            v3 = v3 + v7;
            v4 = v4 + 1;
        };
        assert!(v3 >= arg0.min_stake_amount && v3 <= arg0.max_stake_amount, 4);
        if (0x2::balance::value<T0>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
        let v11 = new_game<T0>(v0, v2, arg2, 0x2::clock::timestamp_ms(arg6), arg7);
        let v12 = 0x2::object::id<Game<T0>>(&v11);
        let v13 = GameStarted<T0>{
            game_id       : v12,
            player        : v0,
            bet_types     : arg3,
            bet_guesses   : arg4,
            stake_amounts : arg5,
            seed          : arg2,
        };
        0x2::event::emit<GameStarted<T0>>(v13);
        0x2::dynamic_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v12, v11);
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

