module 0xf4c2d0b4238b910525086e0934b38673c4d5f6aecc578b4ed27a3b7e82d9dd36::mygame {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        house: address,
        funds: 0x2::balance::Balance<T0>,
    }

    public fun create_pool_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        Pool<T0>{
            id    : 0x2::object::new(arg1),
            house : 0x2::tx_context::sender(arg1),
            funds : 0x2::coin::into_balance<T0>(arg0),
        }
    }

    entry fun play_dice<T0>(arg0: &mut Pool<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) == 1, 2);
        assert!(0x2::balance::value<T0>(&arg0.funds) >= 1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.house);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_u8_in_range(&mut v0, 1, 6)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, 0x2::coin::value<T0>(&arg2)), arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, 0), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun top_up<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.house, 1);
        0x2::balance::join<T0>(&mut arg1.funds, 0x2::coin::into_balance<T0>(arg0));
    }

    public entry fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.house, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, 0x2::balance::value<T0>(&arg0.funds)), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

