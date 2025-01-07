module 0x2dd1218c0448e149ec2432d7225d1aae824f83124c14fff21bf995c67851a98::coin_flip_v2 {
    struct NewGame<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        guess: u8,
        seed: vector<u8>,
        stake_amount: u64,
        partnership_type: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct Outcome<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        player_won: bool,
        pnl: u64,
        challenged: bool,
    }

    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        fee_rate: u128,
        min_stake_amount: u64,
        max_stake_amount: u64,
        pool: 0x2::balance::Balance<T0>,
        treasury: 0x2::balance::Balance<T0>,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        player: address,
        start_epoch: u64,
        stake: 0x2::balance::Balance<T0>,
        guess: u8,
        seed: vector<u8>,
        fee_rate: u128,
    }

    struct Partnership<phantom T0> has key {
        id: 0x2::object::UID,
        fee_rate: u128,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun borrow_game<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : &Game<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public entry fun challenge<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(game_exists<T0>(arg0, arg1), 7);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : v2,
            stake       : v3,
            guess       : _,
            seed        : _,
            fee_rate    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::epoch(arg2) > v2 + 1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v1);
        0x2::object::delete(v0);
        let v7 = Outcome<T0>{
            game_id    : arg1,
            player     : v1,
            player_won : true,
            pnl        : 0,
            challenged : true,
        };
        0x2::event::emit<Outcome<T0>>(v7);
    }

    public entry fun claim<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.treasury, house_treasury_balance<T0>(arg1), arg3), arg2);
    }

    public fun compute_fee_amount(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000) as u64)
    }

    public entry fun create_house<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: u128, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 1000000, 5);
        let v0 = House<T0>{
            id               : 0x2::object::new(arg6),
            pub_key          : arg1,
            fee_rate         : arg2,
            min_stake_amount : arg3,
            max_stake_amount : arg4,
            pool             : 0x2::coin::into_balance<T0>(arg5),
            treasury         : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<House<T0>>(v0);
    }

    public entry fun create_partnership<T0>(arg0: &AdminCap, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Partnership<T0>{
            id       : 0x2::object::new(arg2),
            fee_rate : arg1,
        };
        0x2::transfer::share_object<Partnership<T0>>(v0);
    }

    fun distribute_reward<T0>(arg0: &mut House<T0>, arg1: address, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (arg2) {
            let v2 = 0x2::balance::split<T0>(&mut arg0.pool, v0);
            0x2::balance::join<T0>(&mut v2, arg3);
            let v3 = compute_fee_amount(0x2::balance::value<T0>(&v2), arg4);
            0x2::balance::join<T0>(&mut arg0.treasury, 0x2::balance::split<T0>(&mut v2, v3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), arg1);
            v0 - v3
        } else {
            0x2::balance::join<T0>(&mut arg0.pool, arg3);
            v0
        }
    }

    public fun game_exists<T0>(arg0: &House<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun game_fee_rate<T0>(arg0: &Game<T0>) : u128 {
        arg0.fee_rate
    }

    public fun game_guess<T0>(arg0: &Game<T0>) : u8 {
        arg0.guess
    }

    public fun game_seed<T0>(arg0: &Game<T0>) : vector<u8> {
        arg0.seed
    }

    public fun game_stake_amount<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    public fun game_start_epoch<T0>(arg0: &Game<T0>) : u64 {
        arg0.start_epoch
    }

    public fun house_fee_rate<T0>(arg0: &House<T0>) : u128 {
        arg0.fee_rate
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

    public fun house_treasury_balance<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun new_game<T0>(arg0: &House<T0>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: 0x1::option::Option<0x1::type_name::TypeName>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, Game<T0>) {
        assert!(arg1 == 1 || arg1 == 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 >= arg0.min_stake_amount && v0 <= arg0.max_stake_amount, 0);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = NewGame<T0>{
            game_id          : v2,
            player           : v3,
            guess            : arg1,
            seed             : arg2,
            stake_amount     : v0,
            partnership_type : arg5,
        };
        0x2::event::emit<NewGame<T0>>(v4);
        let v5 = Game<T0>{
            id          : v1,
            player      : v3,
            start_epoch : 0x2::tx_context::epoch(arg6),
            stake       : 0x2::coin::into_balance<T0>(arg3),
            guess       : arg1,
            seed        : arg2,
            fee_rate    : arg4,
        };
        (v2, v5)
    }

    public fun partnership_fee_rate<T0>(arg0: &Partnership<T0>) : u128 {
        arg0.fee_rate
    }

    public entry fun settle<T0>(arg0: &mut House<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(game_exists<T0>(arg0, arg1), 7);
        let Game {
            id          : v0,
            player      : v1,
            start_epoch : _,
            stake       : v3,
            guess       : v4,
            seed        : v5,
            fee_rate    : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut arg0.id, arg1);
        let v7 = v0;
        let v8 = 0x2::object::uid_to_bytes(&v7);
        0x1::vector::append<u8>(&mut v8, v5);
        let v9 = house_pub_key<T0>(arg0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &v9, &v8), 2);
        0x2::object::delete(v7);
        let v10 = 0x2::hash::blake2b256(&arg2);
        let v11 = v4 == *0x1::vector::borrow<u8>(&v10, 0) % 2;
        let v12 = Outcome<T0>{
            game_id    : arg1,
            player     : v1,
            player_won : v11,
            pnl        : distribute_reward<T0>(arg0, v1, v11, v3, v6, arg3),
            challenged : false,
        };
        0x2::event::emit<Outcome<T0>>(v12);
        v11
    }

    public entry fun start_game<T0>(arg0: &mut House<T0>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = new_game<T0>(arg0, arg1, arg2, arg3, house_fee_rate<T0>(arg0), 0x1::option::none<0x1::type_name::TypeName>(), arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v0, v1);
        v0
    }

    public entry fun start_game_with_kiosk<T0, T1: store + key>(arg0: &mut House<T0>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &Partnership<T1>, arg5: &0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item_with_type<T1>(arg5, arg6), 3);
        let (v0, v1) = new_game<T0>(arg0, arg1, arg2, arg3, min_u128(house_fee_rate<T0>(arg0), partnership_fee_rate<T1>(arg4)), 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg7);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v0, v1);
        v0
    }

    public entry fun start_game_with_parternship<T0, T1: key>(arg0: &mut House<T0>, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &Partnership<T1>, arg5: &T1, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = new_game<T0>(arg0, arg1, arg2, arg3, min_u128(house_fee_rate<T0>(arg0), partnership_fee_rate<T1>(arg4)), 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()), arg6);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut arg0.id, v0, v1);
        v0
    }

    public entry fun top_up<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.pool, 0x2::coin::into_balance<T0>(arg2));
    }

    public entry fun update_fee_rate<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u128) {
        assert!(arg2 < 1000000, 5);
        arg1.fee_rate = arg2;
    }

    public entry fun update_max_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.max_stake_amount = arg2;
    }

    public entry fun update_min_stake_amount<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64) {
        arg1.min_stake_amount = arg2;
    }

    public entry fun update_partnership_fee_rate<T0>(arg0: &AdminCap, arg1: &mut Partnership<T0>, arg2: u128) {
        assert!(arg2 < 1000000, 0);
        arg1.fee_rate = arg2;
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut House<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.pool), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.pool, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

