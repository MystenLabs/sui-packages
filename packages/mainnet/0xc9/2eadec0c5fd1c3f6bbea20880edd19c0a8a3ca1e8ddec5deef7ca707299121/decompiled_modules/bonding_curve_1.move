module 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::bonding_curve_1 {
    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_minted: u64,
        treasury: 0x2::coin::TreasuryCap<T0>,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun buy_tokens(arg0: &mut BondingCurve<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_buy_price(arg0.total_minted, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>>(0x2::coin::mint<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>(&mut arg0.treasury, arg2, arg3), 0x2::tx_context::sender(arg3));
        arg0.total_minted = arg0.total_minted + arg2;
        if (v1 > v0) {
            let v2 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math::checked_sub(v1, v0);
            if (!0x1::option::is_some<u64>(&v2)) {
                abort 1
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x1::option::extract<u64>(&mut v2), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
    }

    public fun calculate_buy_price(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg1 <= 100000000000000000, 4);
        assert!(arg0 <= 100000000000000000, 4);
        let v0 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_mul((arg0 as u256) / 1000000000, (100 as u256));
        if (!0x1::option::is_some<u256>(&v0)) {
            abort 1
        };
        let v1 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v0), (100000 as u256));
        if (!0x1::option::is_some<u256>(&v1)) {
            abort 1
        };
        let v2 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_mul((arg1 as u256), 0x1::option::extract<u256>(&mut v1));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_div(0x1::option::extract<u256>(&mut v2), (1000000000 as u256));
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u256>(&mut v3);
        if (v4 > (18446744073709551615 as u256)) {
            abort 5
        };
        (v4 as u64)
    }

    public fun calculate_sell_price(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            return 0
        };
        assert!(arg1 <= 100000000000000000, 4);
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_mul((v0 - v1) / 1000000000, (100 as u256));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v2), (100000 as u256));
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_mul(v0 / 1000000000, (100 as u256));
        if (!0x1::option::is_some<u256>(&v4)) {
            abort 1
        };
        let v5 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v4), (100000 as u256));
        if (!0x1::option::is_some<u256>(&v5)) {
            abort 1
        };
        let v6 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v3), 0x1::option::extract<u256>(&mut v5));
        if (!0x1::option::is_some<u256>(&v6)) {
            abort 1
        };
        let v7 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_div(0x1::option::extract<u256>(&mut v6), 2);
        if (!0x1::option::is_some<u256>(&v7)) {
            abort 1
        };
        let v8 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_mul(v1, 0x1::option::extract<u256>(&mut v7));
        if (!0x1::option::is_some<u256>(&v8)) {
            abort 1
        };
        let v9 = 0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::safe_math_u256::checked_div(0x1::option::extract<u256>(&mut v8), (1000000000 as u256));
        if (!0x1::option::is_some<u256>(&v9)) {
            abort 1
        };
        let v10 = 0x1::option::extract<u256>(&mut v9);
        if (v10 > (18446744073709551615 as u256)) {
            abort 5
        };
        (v10 as u64)
    }

    public entry fun create_bonding_curve(arg0: 0x2::coin::TreasuryCap<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_bonding_curve_internal(arg0, arg1);
        0x2::transfer::public_transfer<BondingCurve<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun create_bonding_curve_internal(arg0: 0x2::coin::TreasuryCap<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>, arg1: &mut 0x2::tx_context::TxContext) : BondingCurve<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2> {
        BondingCurve<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
            treasury     : arg0,
            sui_treasury : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg1),
        }
    }

    public entry fun sell_tokens(arg0: &mut BondingCurve<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>, arg1: &mut 0x2::coin::Coin<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>(arg1) >= arg2, 3);
        let v0 = calculate_sell_price(arg0.total_minted, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v0, 3);
        0x2::coin::burn<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>(&mut arg0.treasury, 0x2::coin::split<0xc92eadec0c5fd1c3f6bbea20880edd19c0a8a3ca1e8ddec5deef7ca707299121::meme_token2::MEME_TOKEN2>(arg1, arg2, arg3));
        arg0.total_minted = arg0.total_minted - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

