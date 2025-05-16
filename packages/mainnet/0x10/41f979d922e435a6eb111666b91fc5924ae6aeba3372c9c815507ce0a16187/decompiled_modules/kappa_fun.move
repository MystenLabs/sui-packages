module 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::kappa_fun {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_liquidity_pbs: u64,
        token_offset: u64,
        sui_offset: u64,
        fee_bps: u64,
        treasury: address,
        liquidity_address: address,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ConfigurationChangedEvent has copy, drop, store {
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_liquidity_pbs: u64,
        token_offset: u64,
        sui_offset: u64,
        treasury: address,
        liquidity_address: address,
        fee_bps: u64,
    }

    public fun buy_<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5.fee_bps;
        let v1 = arg5.liquidity_address;
        let v2 = borrow_bonding_curve_mut<T0>(arg5);
        let (v3, v4) = 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::buy_<T0>(arg0, arg1, arg2, arg3, arg4, v1, v2, arg6, arg7, arg8, v0, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg5.treasury);
    }

    fun create_<T0>(arg0: &Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 2);
        0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::create_<T0>(arg1, arg2, arg3, arg4, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_pbs, arg0.token_offset, arg0.sui_offset, arg5, arg0.fee_bps, arg6, arg7)
    }

    public fun first_buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::first_buy_<T0>(v1, arg1, arg2, arg3, v0, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg0.treasury);
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, bool) {
        0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::sell_<T0>(v1, arg1, arg2, arg3, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg0.treasury);
        v2
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun buy<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg6;
        buy_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8, arg9, arg10);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, 0x2::tx_context::sender(arg10));
        };
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x1041f979d922e435a6eb111666b91fc5924ae6aeba3372c9c815507ce0a16187::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun first_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        first_buy_<T0>(arg0, v0, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public fun get_configuration(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.version, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_pbs, arg0.token_offset, arg0.sui_offset, arg0.fee_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            total_supply         : 1000000000000000000,
            bonding_curve_amount : 700000000000000000,
            to_dex_liquidity_pbs : 9500,
            token_offset         : 176800000000000000,
            sui_offset           : 1900000000000,
            fee_bps              : 100,
            treasury             : @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b,
            liquidity_address    : @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b,
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Configuration>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < arg2 && arg3 < 18446744073709551615 - arg5, 1);
        assert!(arg7 < 10000 && arg4 < 10000, 3);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.to_dex_liquidity_pbs = arg4;
        arg0.token_offset = arg5;
        arg0.sui_offset = arg6;
        arg0.fee_bps = arg7;
        arg0.treasury = arg8;
        let v0 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            to_dex_liquidity_pbs : arg4,
            token_offset         : arg5,
            sui_offset           : arg6,
            treasury             : arg8,
            liquidity_address    : arg9,
            fee_bps              : arg7,
        };
        0x2::event::emit<ConfigurationChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

