module 0x224e19edb1588ea175e4caf353c6d09466adaf5ecd278caf682f996bb7fa5dd8::a_sky_person_game_accumulate_to_target {
    struct AccumulateGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        target_value: u64,
        current_value: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PlayResultEvent has copy, drop {
        message: 0x1::string::String,
        current_value: u64,
        is_win: bool,
    }

    entry fun creat_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccumulateGame<T0>{
            id            : 0x2::object::new(arg0),
            target_value  : 100,
            current_value : 0,
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<AccumulateGame<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: &0x2::clock::Clock, arg1: &mut AccumulateGame<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.current_value = arg1.current_value + ((0x2::clock::timestamp_ms(arg0) % ((10 as u64) + 1)) as u64);
        let (v0, v1) = if (arg1.current_value >= arg1.target_value) {
            (b"Congratulations, you've reached the target!", true)
        } else {
            (b"Keep going, you are on your way!", false)
        };
        let v2 = PlayResultEvent{
            message       : 0x1::string::utf8(v0),
            current_value : arg1.current_value,
            is_win        : v1,
        };
        0x2::event::emit<PlayResultEvent>(v2);
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg2, 1, arg3)));
        };
    }

    // decompiled from Move bytecode v6
}

