module 0x7f6ce7ade63857c4fd16ef7783fed2dfc4d7fb7e40615abdb653030b76aef0c6::calculations {
    public(friend) fun afsui_to_sui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * afsui_to_sui_exchange_rate(arg1, arg2) / 1000000000000000000) as u64)
    }

    public(friend) fun afsui_to_sui_exchange_rate(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        (arg1 as u128) * 1000000000000000000 / (arg0 as u128)
    }

    public(friend) fun percentage_of(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= (1000000000000000000 as u64), 0);
        0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::mul_by_fraction(arg0, arg1)
    }

    public(friend) fun sui_to_afsui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * sui_to_afsui_exchange_rate(arg1, arg2) / 1000000000000000000) as u64)
    }

    public(friend) fun sui_to_afsui_exchange_rate(arg0: u64, arg1: u64) : u128 {
        if (arg1 == 0 || arg0 == 0) {
            return 1000000000000000000
        };
        (arg0 as u128) * 1000000000000000000 / (arg1 as u128)
    }

    // decompiled from Move bytecode v6
}

