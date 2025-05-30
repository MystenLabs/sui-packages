module 0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        aixcom_reserve: 0x2::balance::Balance<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>,
        lp_supply: u64,
    }

    struct LPToken has drop {
        dummy_field: bool,
    }

    struct SwapEvent has copy, drop {
        sui_amount: u64,
        aixcom_amount: u64,
        sui_to_aixcom: bool,
    }

    public entry fun add_aixcom_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg1) > 0, 4);
        0x2::balance::join<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&mut arg0.aixcom_reserve, 0x2::coin::into_balance<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(arg1));
    }

    public entry fun add_sui_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun calculate_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * 997;
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 1000 + v0)) as u64)
    }

    public fun get_lp_supply(arg0: &Pool) : u64 {
        arg0.lp_supply
    }

    public fun get_reserves(arg0: &Pool) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg0.aixcom_reserve))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            sui_reserve    : 0x2::balance::zero<0x2::sui::SUI>(),
            aixcom_reserve : 0x2::balance::zero<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(),
            lp_supply      : 0,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun remove_aixcom_liquidity(arg0: &mut Pool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg0.aixcom_reserve), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>>(0x2::coin::take<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&mut arg0.aixcom_reserve, arg1, arg3), arg2);
    }

    public entry fun remove_sui_liquidity(arg0: &mut Pool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1, arg3), arg2);
    }

    public entry fun swap_aixcom_for_sui(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = calculate_amount_out(v0, 0x2::balance::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg0.aixcom_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve));
        assert!(v1 >= arg2, 2);
        0x2::balance::join<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&mut arg0.aixcom_reserve, 0x2::coin::into_balance<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v1, arg4), arg3);
        let v2 = SwapEvent{
            sui_amount    : v1,
            aixcom_amount : v0,
            sui_to_aixcom : false,
        };
        0x2::event::emit<SwapEvent>(v2);
    }

    public entry fun swap_sui_fixed_rate(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 10000000, 5);
        assert!(0x2::balance::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg0.aixcom_reserve) >= 10000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>>(0x2::coin::take<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&mut arg0.aixcom_reserve, 10000000000, arg3), arg2);
        let v1 = SwapEvent{
            sui_amount    : v0,
            aixcom_amount : 10000000000,
            sui_to_aixcom : true,
        };
        0x2::event::emit<SwapEvent>(v1);
    }

    public entry fun swap_sui_for_aixcom(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = calculate_amount_out(v0, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 0x2::balance::value<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&arg0.aixcom_reserve));
        assert!(v1 >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>>(0x2::coin::take<0xb49690ea0f806cf087145ec3edec3aaacf7d6086e87a41656f86d5375516a4b::aixcom::AIXCOM>(&mut arg0.aixcom_reserve, v1, arg4), arg3);
        let v2 = SwapEvent{
            sui_amount    : v0,
            aixcom_amount : v1,
            sui_to_aixcom : true,
        };
        0x2::event::emit<SwapEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

