module 0xad66e48148c4c14ac877ce15da7df428712416ef4db5e2f290e8b30e6714e831::universal_bonding_curve {
    struct UniversalBondingCurve has store, key {
        id: 0x2::object::UID,
        token_type: 0x1::ascii::String,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_created: bool,
        graduated: bool,
        admin: address,
        fee_bps: u64,
        platform_fee_bps: u64,
        data: 0x2::bag::Bag,
    }

    struct BondingCurveCreated has copy, drop {
        curve_id: address,
        token_type: 0x1::ascii::String,
        creator: address,
    }

    struct BuyEvent has copy, drop {
        curve_id: address,
        amount: u64,
        sui_paid: u64,
        platform_fee: u64,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        sender: address,
        treasury_balance: u64,
        ready_for_graduation: bool,
    }

    struct SellEvent has copy, drop {
        curve_id: address,
        amount: u64,
        sui_returned: u64,
        platform_fee: u64,
        net_refund: u64,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        sender: address,
        treasury_balance: u64,
    }

    struct GraduationEvent has copy, drop {
        curve_id: address,
        pool_id: address,
        platform_fee: u64,
        liquidity_sui: u64,
        liquidity_tokens: u64,
        tokens_sold: u64,
        sui_collected: u64,
        sender: address,
    }

    public entry fun buy_tokens<T0>(arg0: &mut UniversalBondingCurve, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 16);
        assert!(!arg0.graduated, 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 6);
        let v1 = calculate_tokens_for_sui(arg0.tokens_sold_on_curve, arg0.sui_collected, v0);
        assert!(v1 >= arg2, 10);
        let v2 = v0 * arg0.platform_fee_bps / 10000;
        arg0.tokens_sold_on_curve = arg0.tokens_sold_on_curve + v1;
        arg0.sui_collected = arg0.sui_collected + v0 - v2;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, v3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg3), arg0.admin);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.data, b"token_balance"), v1), arg3), 0x2::tx_context::sender(arg3));
        let v4 = BuyEvent{
            curve_id             : 0x2::object::id_address<UniversalBondingCurve>(arg0),
            amount               : v1,
            sui_paid             : v0,
            platform_fee         : v2,
            tokens_sold_on_curve : arg0.tokens_sold_on_curve,
            sui_collected        : arg0.sui_collected,
            sender               : 0x2::tx_context::sender(arg3),
            treasury_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury),
            ready_for_graduation : arg0.sui_collected >= 2000000000000,
        };
        0x2::event::emit<BuyEvent>(v4);
    }

    fun calculate_sui_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg2 > arg0
        };
        if (v0) {
            return 0
        };
        let v1 = (2000000000000000000 as u128) - (arg0 as u128);
        let v2 = (3000000000000 as u128) + (arg1 as u128);
        ((v2 - v1 * v2 / (v1 + (arg2 as u128))) as u64)
    }

    fun calculate_sui_return_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_sui_for_tokens(arg0, arg1, arg2)
    }

    fun calculate_tokens_for_sui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 >= 800000000000000000 || arg2 == 0) {
            return 0
        };
        let v0 = (2000000000000000000 as u128) - (arg0 as u128);
        let v1 = (3000000000000 as u128) + (arg1 as u128);
        let v2 = v0 - v0 * v1 / (v1 + (arg2 as u128));
        let v3 = 800000000000000000 - arg0;
        if (v2 > (v3 as u128)) {
            v3
        } else {
            (v2 as u64)
        }
    }

    public entry fun change_admin(arg0: &mut UniversalBondingCurve, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13);
        arg0.admin = arg1;
    }

    public entry fun create_bonding_curve<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 6);
        assert!(arg2 <= 10000, 6);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::bag::new(arg3);
        0x2::bag::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut v1, b"treasury_cap", arg0);
        0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v1, b"token_balance", 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg0, 800000000000000000, arg3)));
        let v2 = UniversalBondingCurve{
            id                   : 0x2::object::new(arg3),
            token_type           : v0,
            tokens_sold_on_curve : 0,
            sui_collected        : 0,
            sui_treasury         : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_created         : false,
            graduated            : false,
            admin                : 0x2::tx_context::sender(arg3),
            fee_bps              : arg1,
            platform_fee_bps     : arg2,
            data                 : v1,
        };
        let v3 = BondingCurveCreated{
            curve_id   : 0x2::object::id_address<UniversalBondingCurve>(&v2),
            token_type : v0,
            creator    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BondingCurveCreated>(v3);
        0x2::transfer::public_share_object<UniversalBondingCurve>(v2);
    }

    public entry fun emergency_withdraw(arg0: &mut UniversalBondingCurve, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13);
        assert!(arg0.graduated, 14);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg1), arg0.admin);
        };
    }

    public fun get_curve_info(arg0: &UniversalBondingCurve) : (0x1::ascii::String, u64, u64, bool) {
        (arg0.token_type, arg0.tokens_sold_on_curve, arg0.sui_collected, arg0.graduated)
    }

    public fun get_curve_state(arg0: &UniversalBondingCurve) : (u64, u64, bool, bool, u64, 0x1::ascii::String) {
        (arg0.tokens_sold_on_curve, arg0.sui_collected, arg0.pool_created, arg0.graduated, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury), arg0.token_type)
    }

    public fun get_sell_quote(arg0: &UniversalBondingCurve, arg1: u64) : u64 {
        calculate_sui_return_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, arg1)
    }

    public fun get_sui_for_tokens(arg0: &UniversalBondingCurve, arg1: u64) : u64 {
        calculate_sui_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, arg1)
    }

    public fun get_tokens_for_sui(arg0: &UniversalBondingCurve, arg1: u64) : u64 {
        calculate_tokens_for_sui(arg0.tokens_sold_on_curve, arg0.sui_collected, arg1)
    }

    public entry fun graduate_to_dex<T0>(arg0: &mut UniversalBondingCurve, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 16);
        assert!(!arg0.graduated, 8);
        assert!(arg0.sui_collected >= 2000000000000, 12);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= 2000000000000, 3);
        arg0.graduated = true;
        arg0.pool_created = true;
        assert!(0xad66e48148c4c14ac877ce15da7df428712416ef4db5e2f290e8b30e6714e831::create_pool::init_cetus_pool<T0>(arg0.admin, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 1800000000000), arg6), 0x2::coin::mint<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg0.data, b"treasury_cap"), 200000000000000000, arg6), arg1, arg2, arg3, arg4, arg5, arg6), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 200000000000), arg6), arg0.admin);
        let v0 = GraduationEvent{
            curve_id         : 0x2::object::id_address<UniversalBondingCurve>(arg0),
            pool_id          : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools>(arg1),
            platform_fee     : 200000000000,
            liquidity_sui    : 1800000000000,
            liquidity_tokens : 200000000000000000,
            tokens_sold      : arg0.tokens_sold_on_curve,
            sui_collected    : arg0.sui_collected,
            sender           : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<GraduationEvent>(v0);
    }

    public fun is_ready_for_graduation(arg0: &UniversalBondingCurve) : bool {
        arg0.sui_collected >= 2000000000000 && !arg0.graduated
    }

    public entry fun sell_tokens<T0>(arg0: &mut UniversalBondingCurve, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.token_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 16);
        assert!(!arg0.graduated, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        assert!(v0 <= arg0.tokens_sold_on_curve, 7);
        let v1 = calculate_sui_return_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, v0);
        assert!(v1 >= arg2, 10);
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury), 3);
        let v2 = v1 * arg0.platform_fee_bps / 10000;
        0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.data, b"token_balance"), 0x2::coin::into_balance<T0>(arg1));
        arg0.tokens_sold_on_curve = arg0.tokens_sold_on_curve - v0;
        arg0.sui_collected = arg0.sui_collected - v1;
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), 0x2::tx_context::sender(arg3));
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg3), arg0.admin);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        };
        let v4 = SellEvent{
            curve_id             : 0x2::object::id_address<UniversalBondingCurve>(arg0),
            amount               : v0,
            sui_returned         : v1,
            platform_fee         : v2,
            net_refund           : v1 - v2,
            tokens_sold_on_curve : arg0.tokens_sold_on_curve,
            sui_collected        : arg0.sui_collected,
            sender               : 0x2::tx_context::sender(arg3),
            treasury_balance     : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury),
        };
        0x2::event::emit<SellEvent>(v4);
    }

    public entry fun set_fee_bps(arg0: &mut UniversalBondingCurve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    public entry fun set_platform_fee_bps(arg0: &mut UniversalBondingCurve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13);
        assert!(arg1 <= 10000, 6);
        arg0.platform_fee_bps = arg1;
    }

    // decompiled from Move bytecode v6
}

