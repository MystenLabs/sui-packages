module 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::kappadotmeme_partner {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: u64,
        bonding_curve_amount: u64,
        token_offset: u64,
        sui_offset: u64,
        fee_bps: u64,
        treasury: address,
        liquidity_address: address,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        status: bool,
        partner_address: address,
        partner_fee: u64,
    }

    struct ConfigurationChangedEvent has copy, drop, store {
        total_supply: u64,
        bonding_curve_amount: u64,
        token_offset: u64,
        sui_offset: u64,
        treasury: address,
        liquidity_address: address,
        fee_bps: u64,
        partner_address: address,
        partner_fee: u64,
    }

    struct ProtocolStatusChangedEvent has copy, drop, store {
        active_status: bool,
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
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

    public fun buy_<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &mut Configuration, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5.fee_bps;
        let v1 = arg5.sui_offset;
        let v2 = arg5.token_offset;
        let v3 = arg5.liquidity_address;
        let v4 = borrow_bonding_curve_mut<T0>(arg5);
        let (v5, v6) = 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::buy_<T0>(arg0, arg1, arg2, arg3, arg4, v3, v4, arg6, arg7, arg8, v0, v1, v2, arg9, arg10);
        let v7 = v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg10));
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&v7) * arg5.partner_fee / 10000;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v7, v8, arg10), arg5.partner_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, arg5.treasury);
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x1::ascii::String, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == true, 111);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    fun create_<T0>(arg0: &Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: 0x1::ascii::String, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 2);
        0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::create_<T0>(arg1, arg2, arg3, arg4, arg5, arg0.total_supply, arg0.bonding_curve_amount, arg0.token_offset, arg0.sui_offset, arg6, arg0.fee_bps, arg7, arg8)
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

    public fun first_buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_bps;
        let v1 = arg0.sui_offset;
        let v2 = arg0.token_offset;
        let v3 = borrow_bonding_curve_mut<T0>(arg0);
        let (v4, v5) = 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::first_buy_<T0>(v3, arg1, arg2, arg3, v0, v1, v2, arg4, arg5);
        let v6 = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg5));
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v6) * arg0.partner_fee / 10000;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg5), arg0.partner_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, arg0.treasury);
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, bool) {
        0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun get_configuration(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64) {
        (arg0.version, arg0.total_supply, arg0.bonding_curve_amount, arg0.token_offset, arg0.sui_offset, arg0.fee_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            total_supply         : 1000000000000000000,
            bonding_curve_amount : 700000000000000000,
            token_offset         : 1500000000000000000,
            sui_offset           : 10000000000,
            fee_bps              : 100,
            treasury             : @0x3c6f0793bfc3a2dff0d01a43ca75d6f013b2b6b344a0a35624fdfc18379d4778,
            liquidity_address    : @0xa1c62eccd8246062ec1b86f3f7a03b90715092030be69c47629286b3332f3c3a,
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
            status               : true,
            partner_address      : @0xe377e6684827d16d1d808570b5afb9425f31517c834015c1405b0be60e117683,
            partner_fee          : 600,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Configuration>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.fee_bps;
        let v1 = arg0.sui_offset;
        let v2 = arg0.token_offset;
        let v3 = borrow_bonding_curve_mut<T0>(arg0);
        let (v4, v5) = 0x860ca3287542b1eedc5880732b290d49f40f8dc3ad5365a4efb2692e533f3de9::partner_coin_factory::sell_<T0>(v3, arg1, arg2, arg3, v0, v1, v2, arg4, arg5);
        let v6 = v5;
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v6) * arg0.partner_fee / 10000;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v6, v7, arg5), arg0.partner_address);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, arg0.treasury);
        v4
    }

    public entry fun set_protocol_active_status(arg0: &mut Configuration, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = arg2;
        let v0 = ProtocolStatusChangedEvent{active_status: arg2};
        0x2::event::emit<ProtocolStatusChangedEvent>(v0);
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: address, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < arg2 && arg3 < 18446744073709551615 - arg4, 1);
        assert!(arg6 < 10000, 3);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.token_offset = arg4;
        arg0.sui_offset = arg5;
        arg0.fee_bps = arg6;
        arg0.treasury = arg7;
        arg0.liquidity_address = arg8;
        arg0.partner_address = arg9;
        arg0.partner_fee = arg10;
        let v0 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            token_offset         : arg4,
            sui_offset           : arg5,
            treasury             : arg7,
            liquidity_address    : arg8,
            fee_bps              : arg6,
            partner_address      : arg9,
            partner_fee          : arg10,
        };
        0x2::event::emit<ConfigurationChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

