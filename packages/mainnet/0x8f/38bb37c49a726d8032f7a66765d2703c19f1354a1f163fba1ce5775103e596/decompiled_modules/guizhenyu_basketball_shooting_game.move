module 0x8f38bb37c49a726d8032f7a66765d2703c19f1354a1f163fba1ce5775103e596::guizhenyu_basketball_shooting_game {
    struct BasketBallShootingGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        target_point: u64,
        current_point: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PlayResultEvent has copy, drop {
        message: 0x1::string::String,
        current_point: u64,
        is_win: bool,
    }

    entry fun create_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BasketBallShootingGame<T0>{
            id            : 0x2::object::new(arg0),
            target_point  : 10,
            current_point : 0,
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<BasketBallShootingGame<T0>>(v0);
    }

    fun int(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: &0x2::clock::Clock, arg1: &mut BasketBallShootingGame<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ((0x2::clock::timestamp_ms(arg0) % (3 as u64)) as u64);
        arg1.current_point = arg1.current_point + v0;
        let (v1, v2) = if (arg1.current_point >= arg1.target_point) {
            (b"Congratulations, you've reached the point!", true)
        } else {
            (b"Keep going, you are on your way!", false)
        };
        let v3 = PlayResultEvent{
            message       : 0x1::string::utf8(v1),
            current_point : arg1.current_point,
            is_win        : v2,
        };
        0x2::event::emit<PlayResultEvent>(v3);
        let v4 = 0;
        if (v0 == 1) {
            v4 = 1000000;
        };
        if (v0 == 2) {
            v4 = 2000000;
        };
        if (v0 == 3) {
            v4 = 3000000;
        };
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg2, (v4 as u64), arg3)));
        };
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

