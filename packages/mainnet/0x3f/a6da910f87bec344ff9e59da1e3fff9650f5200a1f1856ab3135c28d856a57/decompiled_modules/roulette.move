module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::roulette {
    struct RouletteSpun has copy, drop {
        player: address,
        pocket: u8,
        kinds: vector<u8>,
        numbers: vector<u8>,
        amounts: vector<u64>,
        wager: u64,
        payout: u64,
    }

    fun assert_valid(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u64>, arg3: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 12, 0);
        assert!(0x1::vector::length<u8>(arg1) == v0 && 0x1::vector::length<u64>(arg2) == v0, 0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            assert!(v3 <= 8 && *0x1::vector::borrow<u64>(arg2, v2) >= 10000, 1);
            if (v3 == 0) {
                assert!(v4 < 37, 1);
            };
            if (v3 == 7 || v3 == 8) {
                assert!(v4 >= 1 && v4 <= 3, 1);
            };
            v1 = v1 + *0x1::vector::borrow<u64>(arg2, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == arg3, 2);
    }

    public fun bet_return(arg0: u8, arg1: u8, arg2: u8) : u64 {
        if (arg0 == 0) {
            return if (arg1 == arg2) {
                36
            } else {
                0
            }
        };
        if (arg2 == 0) {
            return 0
        };
        let v1 = arg0 == 1 && is_red(arg2) || arg0 == 2 && !is_red(arg2) || arg0 == 3 && arg2 % 2 == 1 || arg0 == 4 && arg2 % 2 == 0 || arg0 == 5 && arg2 <= 18 || arg0 == 6 && arg2 >= 19 || arg0 == 7 && (arg2 - 1) / 12 + 1 == arg1 || (arg2 - 1) % 3 + 1 == arg1;
        if (!v1) {
            0
        } else if (arg0 == 7 || arg0 == 8) {
            3
        } else {
            2
        }
    }

    public fun is_red(arg0: u8) : bool {
        91447186090 >> arg0 & 1 == 1
    }

    public fun layout_return(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u64>, arg3: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg2, v1) * bet_return(*0x1::vector::borrow<u8>(arg0, v1), *0x1::vector::borrow<u8>(arg1, v1), arg3);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun play<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg5, arg7);
        resolve<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::random::generate_u8_in_range(&mut v0, 0, 37 - 1), arg6, arg7);
    }

    fun resolve<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_valid(&arg2, &arg3, &arg4, v0);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 2, arg1, v1, arg6);
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v5 < 37) {
            let v6 = layout_return(&arg2, &arg3, &arg4, v5);
            v4 = 0x1::u64::max(v4, v6);
            0x1::vector::push_back<u64>(&mut v3, v6);
            v5 = v5 + 1;
        };
        let v7 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::mul_div(v4, v2, v0);
        let v8 = if (v7 > v2) {
            v7 - v2
        } else {
            0
        };
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_max_profit<T0>(arg0, v2, v8);
        let v9 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::mul_div(*0x1::vector::borrow<u64>(&v3, (arg5 as u64)), v2, v0);
        let v10 = RouletteSpun{
            player  : v1,
            pocket  : arg5,
            kinds   : arg2,
            numbers : arg3,
            amounts : arg4,
            wager   : v0,
            payout  : v9,
        };
        0x2::event::emit<RouletteSpun>(v10);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 2, v1, v0, v2, v9, arg7);
    }

    // decompiled from Move bytecode v7
}

