module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::dice {
    struct DiceRolled has copy, drop {
        player: address,
        target: u64,
        roll_over: bool,
        roll: u64,
        wager: u64,
        payout: u64,
    }

    entry fun play<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg4, arg6);
        resolve<T0>(arg0, arg1, arg2, arg3, 0x2::random::generate_u64_in_range(&mut v0, 0, 10000 - 1), arg5, arg6);
    }

    fun resolve<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 0, arg1, v0, arg5);
        let v3 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::mul_div(v2, 9900, win_chance(arg2, arg3));
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_max_profit<T0>(arg0, v2, v3 - v2);
        let v4 = if (arg3 && arg4 > arg2 || arg4 < arg2) {
            v3
        } else {
            0
        };
        let v5 = DiceRolled{
            player    : v0,
            target    : arg2,
            roll_over : arg3,
            roll      : arg4,
            wager     : v1,
            payout    : v4,
        };
        0x2::event::emit<DiceRolled>(v5);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 0, v0, v1, v2, v4, arg6);
    }

    public fun win_chance(arg0: u64, arg1: bool) : u64 {
        assert!(arg0 < 10000, 0);
        let v0 = if (arg1) {
            10000 - 1 - arg0
        } else {
            arg0
        };
        assert!(v0 >= 100 && v0 <= 9800, 0);
        v0
    }

    // decompiled from Move bytecode v7
}

