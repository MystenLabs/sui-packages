module 0x49de8319397ec8f512be7ff8295a4bf85d9c61c0981b7fcb60d38937220375f2::flip {
    struct NewGame has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u8,
        seed: vector<u8>,
        stake_amount: u64,
    }

    struct Outcome has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_won: bool,
        pnl: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct House has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        fee_rate: u128,
        min_stake_amount: u64,
        max_stake_amount: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        player: address,
        start_epoch: u64,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        guess: u8,
        seed: vector<u8>,
        fee_rate: u128,
    }

    fun compute_fee_amount(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 100) as u64)
    }

    public entry fun create_house(arg0: &AdminCap, arg1: vector<u8>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id               : 0x2::object::new(arg6),
            pub_key          : arg1,
            fee_rate         : arg2,
            min_stake_amount : arg3,
            max_stake_amount : arg4,
            pool             : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
        };
        0x2::transfer::share_object<House>(v0);
    }

    public fun game_exists(arg0: &House, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game>(&arg0.id, arg1)
    }

    public fun game_fee_rate(arg0: &Game) : u128 {
        arg0.fee_rate
    }

    public fun house_fee_rate(arg0: &House) : u128 {
        arg0.fee_rate
    }

    public fun house_pool_balance(arg0: &House) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun house_pub_key(arg0: &House) : vector<u8> {
        arg0.pub_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun new_game(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        assert!(arg1 == 1 || arg1 == 0, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.min_stake_amount && v0 <= arg0.max_stake_amount, 0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(house_pool_balance(arg0) >= v0, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v0));
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = NewGame{
            game_id      : v3,
            player       : v4,
            guess        : arg1,
            seed         : arg2,
            stake_amount : v0,
        };
        0x2::event::emit<NewGame>(v5);
        let v6 = Game{
            id          : v2,
            player      : v4,
            start_epoch : 0x2::tx_context::epoch(arg5),
            stake       : v1,
            guess       : arg1,
            seed        : arg2,
            fee_rate    : arg4,
        };
        (v3, v6)
    }

    fun new_game_boost(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        assert!(arg1 == 1 || arg1 == 0, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.min_stake_amount && v0 <= arg0.max_stake_amount, 0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(house_pool_balance(arg0) >= v0, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v0 * 2));
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = NewGame{
            game_id      : v3,
            player       : v4,
            guess        : arg1,
            seed         : arg2,
            stake_amount : v0,
        };
        0x2::event::emit<NewGame>(v5);
        let v6 = Game{
            id          : v2,
            player      : v4,
            start_epoch : 0x2::tx_context::epoch(arg5),
            stake       : v1,
            guess       : arg1,
            seed        : arg2,
            fee_rate    : arg4,
        };
        (v3, v6)
    }

    public entry fun settle(arg0: &mut House, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(game_exists(arg0, arg1), 7);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : _,
            stake       : v3,
            guess       : v4,
            seed        : v5,
            fee_rate    : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(&mut arg0.id, arg1);
        let v7 = v0;
        let v8 = 0x2::object::uid_to_bytes(&v7);
        0x1::vector::append<u8>(&mut v8, v5);
        let v9 = house_pub_key(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v9, &v8), 2);
        0x2::object::delete(v7);
        let v10 = 0x2::hash::blake2b256(&arg2);
        let v11 = v4 == *0x1::vector::borrow<u8>(&v10, 0) % 2;
        let v12 = Outcome{
            game_id    : arg1,
            player     : v1,
            player_won : v11,
            pnl        : settle_internal(arg0, v1, v11, v3, v6, arg3),
        };
        0x2::event::emit<Outcome>(v12);
        v11
    }

    public entry fun settle_boost(arg0: &mut House, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(game_exists(arg0, arg1), 7);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : _,
            stake       : v3,
            guess       : _,
            seed        : v5,
            fee_rate    : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(&mut arg0.id, arg1);
        let v7 = v0;
        let v8 = 0x2::object::uid_to_bytes(&v7);
        0x1::vector::append<u8>(&mut v8, v5);
        let v9 = house_pub_key(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v9, &v8), 2);
        0x2::object::delete(v7);
        let v10 = 0x2::hash::blake2b256(&arg2);
        let v11 = *0x1::vector::borrow<u8>(&v10, 0) % 100 > 70;
        let v12 = Outcome{
            game_id    : arg1,
            player     : v1,
            player_won : v11,
            pnl        : settle_internal(arg0, v1, v11, v3, v6, arg3),
        };
        0x2::event::emit<Outcome>(v12);
        v11
    }

    fun settle_internal(arg0: &mut House, arg1: address, arg2: bool, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, compute_fee_amount(v0, arg4)));
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5), arg1);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, arg3);
        };
        v0 / 2
    }

    fun settle_internal_boost(arg0: &mut House, arg1: address, arg2: bool, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, compute_fee_amount(v0, arg4)));
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg5), arg1);
            v0 / 3 * 2
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, arg3);
            v0 / 3 * 2
        }
    }

    public entry fun start_game(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = house_fee_rate(arg0);
        let (v1, v2) = new_game(arg0, arg1, arg2, arg3, v0, arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(&mut arg0.id, v1, v2);
        v1
    }

    public entry fun start_game_boost(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = house_fee_rate(arg0);
        let (v1, v2) = new_game(arg0, arg1, arg2, arg3, v0, arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(&mut arg0.id, v1, v2);
        v1
    }

    public entry fun top_up(arg0: &AdminCap, arg1: &mut House, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut House, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.pool), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pool, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

