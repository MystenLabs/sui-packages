module 0x452b860f183677bc52f1229eac1e5a8366cded78b8abd354efbe84943fed0d1f::flip {
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
        challenged: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct House has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
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
    }

    public entry fun create_house(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id               : 0x2::object::new(arg5),
            pub_key          : arg1,
            min_stake_amount : arg2,
            max_stake_amount : arg3,
            pool             : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
        };
        0x2::transfer::share_object<House>(v0);
    }

    public fun game_exists(arg0: &House, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game>(&arg0.id, arg1)
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

    fun new_game(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game) {
        assert!(arg1 == 1 || arg1 == 0, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.min_stake_amount && v0 <= arg0.max_stake_amount, 0);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(house_pool_balance(arg0) >= v0, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v0));
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::tx_context::sender(arg4);
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
            start_epoch : 0x2::tx_context::epoch(arg4),
            stake       : v1,
            guess       : arg1,
            seed        : arg2,
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
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game>(&mut arg0.id, arg1);
        let v6 = v0;
        let v7 = 0x2::object::uid_to_bytes(&v6);
        0x1::vector::append<u8>(&mut v7, v5);
        let v8 = house_pub_key(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v8, &v7), 2);
        0x2::object::delete(v6);
        let v9 = 0x2::hash::blake2b256(&arg2);
        let v10 = v4 == *0x1::vector::borrow<u8>(&v9, 0) % 2;
        let v11 = Outcome{
            game_id    : arg1,
            player     : v1,
            player_won : v10,
            pnl        : settle_internal(arg0, v1, v10, v3, arg3),
            challenged : false,
        };
        0x2::event::emit<Outcome>(v11);
        v10
    }

    fun settle_internal(arg0: &mut House, arg1: address, arg2: bool, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg1);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, arg3);
        };
        0x2::balance::value<0x2::sui::SUI>(&arg3) / 2
    }

    public entry fun start_game(arg0: &mut House, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = new_game(arg0, arg1, arg2, arg3, arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Game>(&mut arg0.id, v0, v1);
        v0
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

