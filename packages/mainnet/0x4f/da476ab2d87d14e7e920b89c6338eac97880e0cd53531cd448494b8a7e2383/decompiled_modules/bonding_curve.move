module 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::bonding_curve {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        total_minted: u64,
        treasury: 0x2::coin::TreasuryCap<T0>,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun buy_tokens(arg0: &mut BondingCurve<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_buy_price(arg0.total_minted, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= (v0 as u64), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>>(0x2::coin::mint<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>(&mut arg0.treasury, arg2, arg3), 0x2::tx_context::sender(arg3));
        arg0.total_minted = arg0.total_minted + arg2;
        if (v1 > (v0 as u64)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 - (v0 as u64), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
    }

    public fun calculate_buy_price(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 2;
        if (v0 == 1) {
            let v1 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(1000000000, arg1);
            if (!0x1::option::is_some<u64>(&v1)) {
                abort 1
            };
            return 0x1::option::extract<u64>(&mut v1) / 1000000
        };
        let v2 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(1000000000, pow(v0, arg0));
        if (!0x1::option::is_some<u64>(&v2)) {
            abort 1
        };
        let v3 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_sub(pow(v0, arg1), 1);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(0x1::option::extract<u64>(&mut v2), 0x1::option::extract<u64>(&mut v3));
        if (!0x1::option::is_some<u64>(&v4)) {
            abort 1
        };
        let v5 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_sub(v0, 1);
        if (!0x1::option::is_some<u64>(&v5)) {
            abort 1
        };
        let v6 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(1000000, 0x1::option::extract<u64>(&mut v5));
        if (!0x1::option::is_some<u64>(&v6)) {
            abort 1
        };
        0x1::option::extract<u64>(&mut v4) / 0x1::option::extract<u64>(&mut v6)
    }

    public fun calculate_sell_price(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            return 0
        };
        calculate_buy_price(arg0 - arg1, arg1)
    }

    public fun create_bonding_curve(arg0: 0x2::coin::TreasuryCap<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) : BondingCurve<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN> {
        BondingCurve<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            treasury     : arg0,
            sui_treasury : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
        }
    }

    fun pow(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1
        };
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 & 1 == 1) {
                let v1 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(v0, arg0);
                if (!0x1::option::is_some<u64>(&v1)) {
                    abort 1
                };
                v0 = 0x1::option::extract<u64>(&mut v1);
            };
            let v2 = 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math::checked_mul(arg0, arg0);
            if (!0x1::option::is_some<u64>(&v2)) {
                abort 1
            };
            arg0 = 0x1::option::extract<u64>(&mut v2);
            arg1 = arg1 >> 1;
        };
        v0
    }

    public entry fun sell_tokens(arg0: &mut BondingCurve<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>, arg1: &mut 0x2::coin::Coin<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>(arg1) >= (arg2 as u64), 0);
        let v0 = calculate_sell_price(arg0.total_minted, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v0, 3);
        0x2::coin::burn<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>(&mut arg0.treasury, 0x2::coin::split<0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::meme_token::MEME_TOKEN>(arg1, arg2, arg3));
        arg0.total_minted = arg0.total_minted - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

