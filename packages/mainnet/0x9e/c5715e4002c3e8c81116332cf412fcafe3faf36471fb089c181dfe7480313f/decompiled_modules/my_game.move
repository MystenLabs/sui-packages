module 0x9ec5715e4002c3e8c81116332cf412fcafe3faf36471fb089c181dfe7480313f::my_game {
    struct MY_GAME has drop {
        dummy_field: bool,
    }

    struct MyGameCap has key {
        id: 0x2::object::UID,
    }

    struct Dealer has key {
        id: 0x2::object::UID,
        commission_fee_point: u16,
        min_time_span: u64,
        min_bet: u64,
        game_on: bool,
        game_start_time: u64,
        coins_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        bettor_big: 0x2::vec_map::VecMap<address, u64>,
        bettor_small: 0x2::vec_map::VecMap<address, u64>,
    }

    public entry fun bet(arg0: &mut Dealer, arg1: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: bool, arg3: 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_on, 4);
        let v0 = 0x2::balance::value<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(0x2::coin::balance<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(&arg3));
        assert!(v0 >= arg0.min_bet, 6);
        let v1 = 0x2::tx_context::sender(arg4);
        if (arg2) {
            let v2 = 0x2::vec_map::try_get<address, u64>(&arg0.bettor_big, &v1);
            if (0x1::option::is_some<u64>(&v2)) {
                let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.bettor_big, &v1);
                *v3 = *v3 + v0;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.bettor_big, v1, v0);
            };
        } else {
            let v4 = 0x2::vec_map::try_get<address, u64>(&arg0.bettor_small, &v1);
            if (0x1::option::is_some<u64>(&v4)) {
                let v5 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.bettor_small, &v1);
                *v5 = *v5 + v0;
            } else {
                0x2::vec_map::insert<address, u64>(&mut arg0.bettor_small, v1, v0);
            };
        };
        0x2::coin::join<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(arg1, arg3);
    }

    public entry fun coin_in(arg0: &mut Dealer, arg1: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg2));
        assert!(v0 > 0, 2);
        assert!(0x2::coin::value<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>>(0x2::coin::take<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(0x2::coin::balance_mut<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(arg1), v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.coins_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun coin_out(arg0: &mut Dealer, arg1: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(0x2::coin::balance<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(&arg2));
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.coins_pool) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.coins_pool, v0), arg3), 0x2::tx_context::sender(arg3));
        0x2::coin::join<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(arg1, arg2);
    }

    public entry fun end_game(arg0: &mut Dealer, arg1: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: &0x2::clock::Clock, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_on, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!((v0 - arg0.game_start_time) / 1000 >= arg0.min_time_span, 5);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        game_clearance(arg0, arg1, v0, 0x2::random::generate_u64(&mut v1), arg4);
        arg0.game_on = false;
        arg0.bettor_big = 0x2::vec_map::empty<address, u64>();
        arg0.bettor_small = 0x2::vec_map::empty<address, u64>();
    }

    fun game_clearance(arg0: &mut Dealer, arg1: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = get_bet_amounts(arg0, arg4);
        if (v0 == 0 || v2 == 0) {
            if (v0 == 0) {
                reward(arg1, &arg0.bettor_small, v3, 0, arg0.commission_fee_point, arg4);
            } else {
                reward(arg1, &arg0.bettor_big, v1, 0, arg0.commission_fee_point, arg4);
            };
        } else if (get_game_verdict(arg0, arg2, arg3, arg4)) {
            reward(arg1, &arg0.bettor_big, v1, v3, arg0.commission_fee_point, arg4);
        } else {
            reward(arg1, &arg0.bettor_small, v3, v1, arg0.commission_fee_point, arg4);
        };
    }

    public entry fun get_bet_amounts(arg0: &mut Dealer, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        (0x2::vec_map::size<address, u64>(&arg0.bettor_big), get_total_bets(&arg0.bettor_big), 0x2::vec_map::size<address, u64>(&arg0.bettor_small), get_total_bets(&arg0.bettor_small))
    }

    fun get_game_verdict(arg0: &mut Dealer, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = get_seed_array(arg0, arg1, v0, arg2, arg3);
        let v2 = 0x2::hash::blake2b256(&v1);
        *0x1::vector::borrow<u8>(&v2, 0) % 2 == 1
    }

    fun get_seed_array(arg0: &mut Dealer, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::object::id_bytes<Dealer>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        let (v1, v2, v3, v4) = get_bet_amounts(arg0, arg4);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v5));
        v0
    }

    public fun get_total_bets(arg0: &0x2::vec_map::VecMap<address, u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<address, u64>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(arg0, v1);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: MY_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MY_GAME>(arg0, arg1);
        let v0 = MyGameCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MyGameCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_dealer(arg0: MyGameCap, arg1: &mut 0x2::coin::TreasuryCap<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg2: u64, arg3: u16, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < 10000, 7);
        let MyGameCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::mint(arg1, arg2, 0x2::tx_context::sender(arg6), arg6);
        let v1 = Dealer{
            id                   : 0x2::object::new(arg6),
            commission_fee_point : arg3,
            min_time_span        : arg4,
            min_bet              : arg5,
            game_on              : false,
            game_start_time      : 0,
            coins_pool           : 0x2::balance::zero<0x2::sui::SUI>(),
            bettor_big           : 0x2::vec_map::empty<address, u64>(),
            bettor_small         : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<Dealer>(v1);
    }

    public entry fun is_game_on(arg0: &mut Dealer, arg1: &mut 0x2::tx_context::TxContext) : bool {
        arg0.game_on
    }

    fun reward(arg0: &mut 0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>, arg1: &0x2::vec_map::VecMap<address, u64>, arg2: u64, arg3: u64, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<address, u64>(arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<address, u64>(arg1, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>>(0x2::coin::take<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(0x2::coin::balance_mut<0x5a1db9509ce6c5a325bbc7dd00d88ab9073abfe4f661179750e49667452e6db4::siphonelee_coin::SIPHONELEE_COIN>(arg0), ((((*v2 as u128) + (arg3 as u128) * (*v2 as u128) / (arg2 as u128)) * (10000 - (arg4 as u128)) / 10000) as u64), arg5), *v1);
            v0 = v0 + 1;
        };
    }

    public entry fun start_game(arg0: &mut Dealer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.game_on, 3);
        arg0.game_on = true;
        arg0.game_start_time = 0x2::clock::timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

