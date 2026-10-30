module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::share_math {
    public(friend) fun assets_for_redemption(arg0: u64, arg1: u64, arg2: u128) : u64 {
        narrow(redemption_value((arg0 as u128), arg1, arg2))
    }

    fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x1::u128::checked_mul(arg0, arg1);
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0) / arg2
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 13835339800842010628
        };
    }

    fun narrow(arg0: u128) : u64 {
        let v0 = 0x1::u128::try_as_u64(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13835621292998721542
        };
    }

    fun redemption_value(arg0: u128, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 > 0 || arg1 == 0, 13835058295800397826);
        if (arg1 == 0) {
            return arg0
        };
        mul_div(arg0, arg2, (arg1 as u128))
    }

    public(friend) fun share_price(arg0: u128, arg1: u64, arg2: u8) : u128 {
        assert!(arg2 <= 18, 13835339745007435780);
        redemption_value(0x1::u128::pow(10, arg2), arg1, arg0)
    }

    public(friend) fun shares_for_deposit(arg0: u64, arg1: u64, arg2: u128) : u64 {
        assert!(arg2 > 0 || arg1 == 0, 13835058201311117314);
        if (arg1 == 0) {
            return arg0
        };
        narrow(mul_div((arg0 as u128), (arg1 as u128), arg2))
    }

    public(friend) fun total_assets(arg0: u64, arg1: u64, arg2: u64) : u128 {
        0x1::u128::saturating_sub((arg0 as u128) + (arg1 as u128), (arg2 as u128))
    }

    // decompiled from Move bytecode v7
}

