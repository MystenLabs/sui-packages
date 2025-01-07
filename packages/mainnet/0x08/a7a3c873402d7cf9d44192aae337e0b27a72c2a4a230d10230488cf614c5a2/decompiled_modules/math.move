module 0x8a7a3c873402d7cf9d44192aae337e0b27a72c2a4a230d10230488cf614c5a2::math {
    public fun calc_coin_to_scoin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        let v4 = if (v3 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v3, v0 + v1 - v2)
        } else {
            arg4
        };
        assert!(v4 > 0, 1);
        v4
    }

    public fun calc_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    // decompiled from Move bytecode v6
}

