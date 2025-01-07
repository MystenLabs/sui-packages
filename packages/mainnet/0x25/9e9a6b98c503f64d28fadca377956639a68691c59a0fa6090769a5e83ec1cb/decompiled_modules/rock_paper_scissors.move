module 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::rock_paper_scissors {
    struct PlayEvent has copy, drop {
        place: 0x2::object::ID,
        player_gesture: u8,
        machine_gesture: u8,
        result: u8,
        odds: u64,
        fee: u64,
        pay: u64,
        award: u64,
    }

    fun is_win(arg0: u8, arg1: u8) : u8 {
        if (arg0 == arg1) {
            return 1
        };
        let v0 = if (arg0 == 0 && arg1 == 2) {
            true
        } else if (arg0 == 1 && arg1 == 0) {
            true
        } else {
            arg0 == 2 && arg1 == 1
        };
        if (v0) {
            return 0
        };
        2
    }

    entry fun play<T0>(arg0: &mut 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::Place<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 0);
        let v1 = random_gesture(arg3, arg4);
        let v2 = is_win(arg2, v1);
        let v3 = 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::odds<T0>(arg0);
        let v4 = 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::fee<T0>(arg0);
        let v5 = 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::prize_pool_mut<T0>(arg0);
        let v6 = 0x2::coin::value<T0>(&arg1);
        if (v2 == 0) {
            let v7 = v6 * v3 / 10000;
            let v8 = 0x2::balance::value<T0>(v5);
            let (v9, v10) = if (v8 >= v7) {
                let v11 = v7 * v4 / 10000;
                (v7 - v11, v11)
            } else {
                let v12 = v8 * v4 / 10000;
                (v8 - v12, v12)
            };
            if (v9 > v6) {
                0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, v9 - v6), arg4));
            };
            if (v9 < v6) {
                0x2::balance::join<T0>(v5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v6 - v9, arg4)));
            };
            if (v10 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, v10), arg4), 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::receiver<T0>(arg0));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
            let v13 = PlayEvent{
                place           : 0x2::object::id<0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::Place<T0>>(arg0),
                player_gesture  : arg2,
                machine_gesture : v1,
                result          : v2,
                odds            : v3,
                fee             : v10,
                pay             : v6,
                award           : v9,
            };
            0x2::event::emit<PlayEvent>(v13);
        } else {
            let v14 = v6 * v4 / 10000;
            if (v4 != 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v14, arg4), 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::receiver<T0>(arg0));
            };
            0x2::balance::join<T0>(v5, 0x2::coin::into_balance<T0>(arg1));
            let v15 = PlayEvent{
                place           : 0x2::object::id<0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place::Place<T0>>(arg0),
                player_gesture  : arg2,
                machine_gesture : v1,
                result          : v2,
                odds            : v3,
                fee             : v14,
                pay             : v6,
                award           : 0,
            };
            0x2::event::emit<PlayEvent>(v15);
        };
    }

    fun random_gesture(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u8_in_range(&mut v0, 0, 2)
    }

    // decompiled from Move bytecode v6
}

