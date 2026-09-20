module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::crash {
    struct CrashPlayed has copy, drop {
        player: address,
        target: u64,
        crash_point: u64,
        wager: u64,
        payout: u64,
    }

    public fun crash_point(arg0: u64) : u64 {
        0x1::u64::min(0x1::u64::max(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::mul_div(99, 1000000000, 1000000000 - arg0), 100), 1000000)
    }

    entry fun play<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg5);
        resolve<T0>(arg0, arg1, arg2, 0x2::random::generate_u64_in_range(&mut v0, 0, 1000000000 - 1), arg4, arg5);
    }

    fun resolve<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 101 && arg2 <= 100000, 0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 1, arg1, v0, arg4);
        let v3 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::mul_div(v2, arg2, 100);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_max_profit<T0>(arg0, v2, v3 - v2);
        let v4 = crash_point(arg3);
        let v5 = if (v4 >= arg2) {
            v3
        } else {
            0
        };
        let v6 = CrashPlayed{
            player      : v0,
            target      : arg2,
            crash_point : v4,
            wager       : v1,
            payout      : v5,
        };
        0x2::event::emit<CrashPlayed>(v6);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 1, v0, v1, v2, v5, arg5);
    }

    // decompiled from Move bytecode v7
}

