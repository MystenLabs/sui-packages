module 0xf10e5d7a10058be3f2e84130cfa81e0c7b9b276923a3a190ce6082c3790f622::systemx10_coin_pusher_game {
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
            target_value  : 20,
            current_value : 0,
            balance       : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<AccumulateGame<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    entry fun play<T0>(arg0: &0x2::clock::Clock, arg1: &mut AccumulateGame<T0>, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        arg1.current_value = arg1.current_value + ((v0 % ((10 as u64) + 1)) as u64);
        let (v1, v2) = if (arg1.current_value >= arg1.target_value) {
            (b"Whoa, whoa, whoa. You've got a random number of faucet coins! ", true)
        } else {
            (b"Keep going,  the faucet are about to drop!", false)
        };
        let v3 = PlayResultEvent{
            message       : 0x1::string::utf8(v1),
            current_value : arg1.current_value,
            is_win        : v2,
        };
        0x2::event::emit<PlayResultEvent>(v3);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, ((v0 % ((0x2::balance::value<T0>(&mut arg1.balance) as u64) + 1)) as u64)), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg2, 1, arg3)));
        };
    }

    // decompiled from Move bytecode v6
}

