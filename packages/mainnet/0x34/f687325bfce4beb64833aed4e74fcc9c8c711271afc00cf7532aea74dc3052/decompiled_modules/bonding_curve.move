module 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::bonding_curve {
    struct BuyTokensEvent has copy, drop {
        amount: u64,
        required_payment: u64,
        total_minted: u64,
        sender: address,
    }

    struct SellTokensEvent has copy, drop {
        amount: u64,
        refund_amount: u64,
        total_minted: u64,
        sender: address,
        treasury_balance: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        base_token_amount: u64,
        quote_token_amount: u64,
        sender: address,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_minted: u256,
        treasury: 0x2::coin::TreasuryCap<T0>,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
        pool_created: bool,
        pool_id: 0x1::option::Option<address>,
        admin: address,
        fee_bps: u64,
    }

    struct Cal_event has copy, drop {
        amount: u64,
    }

    public entry fun buy_tokens(arg0: &mut BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u256, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 as u64);
        assert!(arg2 <= (18446744073709551615 as u256), 4);
        let v1 = calculate_buy_price(arg0.total_minted, arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math::checked_mul(v1, arg0.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        let v5 = v1 + v4;
        assert!(v2 >= v5, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg8), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>>(0x2::coin::mint<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>(&mut arg0.treasury, v0, arg8), 0x2::tx_context::sender(arg8));
        arg0.total_minted = arg0.total_minted + arg2;
        let v6 = BuyTokensEvent{
            amount           : v0,
            required_payment : v1,
            total_minted     : (arg0.total_minted as u64),
            sender           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<BuyTokensEvent>(v6);
        if (v2 > v1) {
            let v7 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math::checked_sub(v2, v5);
            if (!0x1::option::is_some<u64>(&v7)) {
                abort 1
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x1::option::extract<u64>(&mut v7), arg8), 0x2::tx_context::sender(arg8));
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
        try_create_pool(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun calculate_buy_price(arg0: u256, arg1: u256) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg1 <= (18446744073709551615 as u256), 4);
        assert!(arg0 <= (18446744073709551615 as u256), 4);
        let v0 = arg0 / 1000000000;
        assert!(v0 <= 100000000, 4);
        let v1 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_mul(v0, (100 as u256));
        if (!0x1::option::is_some<u256>(&v1)) {
            abort 1
        };
        let v2 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v1), (10000 as u256));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_mul(arg1, 0x1::option::extract<u256>(&mut v2));
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_div(0x1::option::extract<u256>(&mut v3), 1000000000);
        if (!0x1::option::is_some<u256>(&v4)) {
            abort 1
        };
        let v5 = 0x1::option::extract<u256>(&mut v4);
        if (v5 > (18446744073709551615 as u256)) {
            abort 5
        };
        let v6 = Cal_event{amount: (v5 as u64)};
        0x2::event::emit<Cal_event>(v6);
        (v5 as u64)
    }

    public fun calculate_sell_price(arg0: u256, arg1: u256) : u64 {
        assert!(arg1 <= (18446744073709551615 as u256), 4);
        assert!(arg0 <= (18446744073709551615 as u256), 4);
        let v0 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_mul((arg0 - arg1) / 1000000000, (100 as u256));
        if (!0x1::option::is_some<u256>(&v0)) {
            abort 1
        };
        let v1 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_add(0x1::option::extract<u256>(&mut v0), (10000 as u256));
        if (!0x1::option::is_some<u256>(&v1)) {
            abort 1
        };
        let v2 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_mul(arg1, 0x1::option::extract<u256>(&mut v1));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math_u256::checked_div(0x1::option::extract<u256>(&mut v2), 1000000000);
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u256>(&mut v3);
        if (v4 > (18446744073709551615 as u256)) {
            abort 5
        };
        (v4 as u64)
    }

    public entry fun change_admin(arg0: &mut BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg1 != @0x0, 6);
        arg0.admin = arg1;
    }

    public entry fun create_bonding_curve(arg0: 0x2::coin::TreasuryCap<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>{
            id           : 0x2::object::new(arg2),
            total_minted : 0,
            treasury     : arg0,
            sui_treasury : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg2),
            pool_created : false,
            pool_id      : 0x1::option::none<address>(),
            admin        : @0x37ab3b95caed2955a21c5a7a336e478c1b8588370d78b6c9021bd5df8f107d52,
            fee_bps      : arg1,
        };
        0x2::transfer::public_share_object<BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>>(v0);
    }

    public entry fun sell_tokens(arg0: &mut BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: &mut 0x2::coin::Coin<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg2: u256, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 as u64);
        assert!(0x2::coin::value<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>(arg1) >= v0, 7);
        assert!(arg2 % 1000000000 == 0, 6);
        let v1 = calculate_sell_price(arg0.total_minted, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v1, 3);
        0x2::coin::burn<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>(&mut arg0.treasury, 0x2::coin::split<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>(arg1, v0, arg8));
        arg0.total_minted = arg0.total_minted - arg2;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v1, arg8);
        let v3 = 0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::safe_math::checked_mul(v1, arg0.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= v4, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg8), arg0.admin);
        let v5 = SellTokensEvent{
            amount           : v0,
            refund_amount    : v1,
            total_minted     : (arg0.total_minted as u64),
            sender           : 0x2::tx_context::sender(arg8),
            treasury_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury),
        };
        0x2::event::emit<SellTokensEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
    }

    public entry fun set_fee_bps(arg0: &mut BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    fun try_create_pool(arg0: &mut BondingCurve<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.pool_created) {
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) < 1200000000) {
            return
        };
        if (0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::create_pool::init_cetus_pool(arg0.admin, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 1000000000, arg6), 0x2::coin::mint<0x34f687325bfce4beb64833aed4e74fcc9c8c711271afc00cf7532aea74dc3052::meme_token::MEME_TOKEN>(&mut arg0.treasury, 40000000000000, arg6), arg2, arg1, arg4, arg5, arg3, arg6) == true) {
            arg0.pool_created = true;
        };
    }

    // decompiled from Move bytecode v6
}

