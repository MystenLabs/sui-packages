module 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils {
    public fun extract_balance<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            if (arg1 > 0) {
                let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
                if (0x2::coin::value<T0>(&v1) >= arg1) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v1), arg1));
                    0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut arg0, v1);
                    arg1 = 0;
                    break
                };
                arg1 = arg1 - 0x2::coin::value<T0>(&v1);
                0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v1));
            } else {
                break
            };
        };
        assert!(arg1 == 0, 0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public fun get_date_from_ts(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 86400 + 719468;
        let v1 = v0 / 146097;
        let v2 = v0 - v1 * 146097;
        let v3 = (v2 - v2 / 1460 + v2 / 36524 - v2 / 146096) / 365;
        let v4 = v2 - 365 * v3 + v3 / 4 - v3 / 100;
        let v5 = (5 * v4 + 2) / 153;
        let v6 = if (v5 < 10) {
            v5 + 3
        } else {
            v5 - 9
        };
        let v7 = if (v6 <= 2) {
            v3 + v1 * 400 + 1
        } else {
            v3 + v1 * 400
        };
        (v7, v6, v4 - (153 * v5 + 2) / 5 + 1)
    }

    public fun match_types<T0, T1>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()
    }

    public fun multiplier(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < arg0) {
            v1 = v1 * 10;
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

