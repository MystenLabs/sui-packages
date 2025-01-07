module 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::utils {
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

    public fun get_month_short_string(arg0: u64) : vector<u8> {
        let v0 = vector[b"JAN", b"FEB", b"MAR", b"APR", b"MAY", b"JUN", b"JUL", b"AUG", b"SEP", b"OCT", b"NOV", b"DEC"];
        *0x1::vector::borrow<vector<u8>>(&v0, arg0 - 1)
    }

    public fun get_pad_2_number_string(arg0: u64) : vector<u8> {
        let v0 = vector[b"00", b"01", b"02", b"03", b"04", b"05", b"06", b"07", b"08", b"09", b"10", b"11", b"12", b"13", b"14", b"15", b"16", b"17", b"18", b"19", b"20", b"21", b"22", b"23", b"24", b"25", b"26", b"27", b"28", b"29", b"30", b"31", b"32", b"33", b"34", b"35", b"36", b"37", b"38", b"39", b"40", b"41", b"42", b"43", b"44", b"45", b"46", b"47", b"48", b"49", b"50", b"51", b"52", b"53", b"54", b"55", b"56", b"57", b"58", b"59", b"60", b"61", b"62", b"63", b"64", b"65", b"66", b"67", b"68", b"69", b"70", b"71", b"72", b"73", b"74", b"75", b"76", b"77", b"78", b"79", b"80", b"81", b"82", b"83", b"84", b"85", b"86", b"87", b"88", b"89", b"90", b"91", b"92", b"93", b"94", b"95", b"96", b"97", b"98", b"99"];
        *0x1::vector::borrow<vector<u8>>(&v0, arg0 % 100)
    }

    public fun match_types<T0, T1>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()
    }

    public fun u64_to_bytes(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 > 0) {
            let v1 = arg0 % 10;
            if (!0x1::vector::is_empty<u8>(&v0) || v1 != 0) {
                0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        if (!0x1::vector::is_empty<u8>(&v0)) {
            0x1::vector::push_back<u8>(&mut v0, 46);
        };
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

