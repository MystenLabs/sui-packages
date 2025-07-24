module 0x88779f558190575d9830243769b447c76d4fe4c0e768a3b8b59883548046cb1a::factory {
    struct ProfitEvent has copy, drop, store {
        direction: u8,
    }

    struct ProfitCalculationEvent has copy, drop, store {
        price_ins: vector<u128>,
        price_outs: vector<u128>,
        fees: vector<u64>,
    }

    public fun best_trade_amount(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u128>(&arg0);
        let v1 = (*0x1::vector::borrow<u128>(&arg1, 0) as u256);
        let v2 = 1;
        while (v2 < v0) {
            let v3 = v1 * (*0x1::vector::borrow<u128>(&arg1, v2) as u256);
            v1 = v3 / 18446744073709551616;
            v2 = v2 + 1;
        };
        let v4 = 0;
        v2 = 0;
        while (v2 < v0) {
            v4 = v4 + (*0x1::vector::borrow<u64>(&arg2, v2) as u256);
            v2 = v2 + 1;
        };
        let v5 = v4 * 9223372036854775808 / 1000000;
        if (v1 < v5 + 18446744073709551616 + 9007199254740992) {
            return 0
        };
        let v6 = (*0x1::vector::borrow<u128>(&arg1, 0) as u256) / (*0x1::vector::borrow<u128>(&arg0, 0) as u256);
        let v7 = (*0x1::vector::borrow<u128>(&arg1, 0) as u256);
        v2 = 1;
        while (v2 < v0) {
            v7 = v7 * (*0x1::vector::borrow<u128>(&arg1, v2 - 1) as u256) / 18446744073709551616 * (*0x1::vector::borrow<u128>(&arg1, v2) as u256) / 18446744073709551616;
            v6 = v6 + v7 / (*0x1::vector::borrow<u128>(&arg0, v2) as u256);
            v2 = v2 + 1;
        };
        (((v1 - v5 - 18446744073709551616) / v6) as u64)
    }

    // decompiled from Move bytecode v6
}

