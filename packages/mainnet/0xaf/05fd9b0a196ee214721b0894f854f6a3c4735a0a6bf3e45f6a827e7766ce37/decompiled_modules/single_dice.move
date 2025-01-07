module 0xaf05fd9b0a196ee214721b0894f854f6a3c4735a0a6bf3e45f6a827e7766ce37::single_dice {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u8,
        stake_amount: u64,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_won: bool,
        pnl: u64,
        roll_result: u8,
        challenged: bool,
    }

    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct Withdraw<phantom T0> has copy, drop {
        amount: u64,
    }

    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        min_stake_amount: u64,
        max_stake_amount: u64,
        payout_rate: u64,
        pool: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        start_epoch: u64,
        stake: 0x2::coin::Coin<T0>,
        payout: 0x2::coin::Coin<T0>,
        guess: u8,
        seed: vector<u8>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun batch_settle<T0>(arg0: &mut House<T0>, arg1: vector<0x2::object::ID>, arg2: vector<vector<u8>>) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 5);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            if (game_exists<T0>(arg0, v0)) {
                settle<T0>(arg0, v0, 0x1::vector::pop_back<vector<u8>>(&mut arg2));
            };
        };
    }

    public fun borrow_game<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : &Game<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public entry fun challenge<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 4);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : v2,
            stake       : v3,
            payout      : v4,
            guess       : _,
            seed        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v4;
        0x2::object::delete(v0);
        assert!(0x2::tx_context::epoch(arg2) > v2 + 7, 2);
        0x2::coin::join<T0>(&mut v7, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v1);
        let v8 = Outcome<T0>{
            game_id     : arg1,
            player      : v1,
            player_won  : true,
            pnl         : 0x2::coin::value<T0>(&v7),
            roll_result : 0,
            challenged  : true,
        };
        0x2::event::emit<Outcome<T0>>(v8);
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = House<T0>{
            id               : 0x2::object::new(arg6),
            pub_key          : arg1,
            min_stake_amount : arg2,
            max_stake_amount : arg3,
            payout_rate      : arg4,
            pool             : 0x2::coin::into_balance<T0>(arg5),
        };
        0x2::transfer::share_object<House<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.pool, v0);
        let v1 = Deposit<T0>{amount: 0x2::balance::value<T0>(&v0)};
        0x2::event::emit<Deposit<T0>>(v1);
    }

    public fun game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun game_guess<T0>(arg0: &Game<T0>) : u8 {
        arg0.guess
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

    public fun house_payout_rate<T0>(arg0: &House<T0>) : u64 {
        arg0.payout_rate
    }

    public fun house_pool_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun house_pub_key<T0>(arg0: &House<T0>) : vector<u8> {
        arg0.pub_key
    }

    public fun house_stake_range<T0>(arg0: &House<T0>) : (u64, u64) {
        (arg0.min_stake_amount, arg0.max_stake_amount)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun roll(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            v1 = v1 + (*0x1::vector::borrow<u8>(arg0, v0) as u64);
            v0 = v0 + 1;
        };
        ((v1 % 6) as u8) + 1
    }

    public entry fun settle<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>) : bool {
        assert!(game_exists<T0>(arg0, arg1), 4);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : _,
            stake       : v3,
            payout      : v4,
            guess       : v5,
            seed        : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v4;
        let v8 = v3;
        let v9 = v0;
        let v10 = 0x2::object::uid_to_bytes(&v9);
        0x1::vector::append<u8>(&mut v10, v6);
        let v11 = house_pub_key<T0>(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v11, &v10), 1);
        0x2::object::delete(v9);
        let v12 = 0x2::hash::blake2b256(&arg2);
        let v13 = roll(&v12);
        let v14 = 0xaf05fd9b0a196ee214721b0894f854f6a3c4735a0a6bf3e45f6a827e7766ce37::bet_manager::player_won(v5, v13);
        let v15 = if (v14) {
            0x2::coin::join<T0>(&mut v7, v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v1);
            0x2::coin::value<T0>(&v7)
        } else {
            0x2::coin::put<T0>(&mut arg0.pool, v8);
            0x2::coin::put<T0>(&mut arg0.pool, v7);
            0x2::coin::value<T0>(&v8)
        };
        let v16 = Outcome<T0>{
            game_id     : arg1,
            player      : v1,
            player_won  : v14,
            pnl         : v15,
            roll_result : v13,
            challenged  : false,
        };
        0x2::event::emit<Outcome<T0>>(v16);
        v14
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 >= arg0.min_stake_amount && v0 <= arg0.max_stake_amount, 0);
        assert!(0x1::vector::length<u8>(&arg2) >= 32, 6);
        assert!(house_pool_balance<T0>(arg0) >= v0, 3);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = Game<T0>{
            id          : v1,
            player      : v3,
            start_epoch : 0x2::tx_context::epoch(arg4),
            stake       : arg3,
            payout      : 0x2::coin::take<T0>(&mut arg0.pool, 0xaf05fd9b0a196ee214721b0894f854f6a3c4735a0a6bf3e45f6a827e7766ce37::bet_manager::payout_amount(v0, arg1, house_payout_rate<T0>(arg0)), arg4),
            guess       : arg1,
            seed        : arg2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v2, v4);
        let v5 = NewGame<T0>{
            game_id      : v2,
            player       : v3,
            guess        : arg1,
            stake_amount : v0,
        };
        0x2::event::emit<NewGame<T0>>(v5);
        v2
    }

    public entry fun update_max_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.max_stake_amount = arg2;
    }

    public entry fun update_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.min_stake_amount = arg2;
    }

    public entry fun update_payout_rate<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.payout_rate = arg2;
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.pool), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool, arg2, arg4), arg3);
        let v0 = Withdraw<T0>{amount: arg2};
        0x2::event::emit<Withdraw<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

