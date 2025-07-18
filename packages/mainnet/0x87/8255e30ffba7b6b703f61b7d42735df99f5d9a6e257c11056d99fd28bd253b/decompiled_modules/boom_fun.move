module 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::boom_fun {
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
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ConfigurationChangedEvent has copy, drop, store {
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_liquidity_pbs: u64,
        token_offset: u64,
        sui_offset: u64,
        fee_bps: u64,
    }

    public fun buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::buy_<T0>(v1, arg1, arg2, arg3, v0, arg4, arg5));
    }

    fun create_<T0>(arg0: &Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 2);
        0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::create_<T0>(arg1, arg2, arg3, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_pbs, arg0.token_offset, arg0.sui_offset, arg4, arg0.fee_bps, arg5, arg6)
    }

    public fun distribute_all_users<T0>(arg0: &mut Configuration, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::distribute_all_users<T0>(borrow_bonding_curve_mut<T0>(arg0), arg2);
    }

    public fun distribute_user<T0>(arg0: &mut Configuration, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::distribute_user<T0>(borrow_bonding_curve_mut<T0>(arg0), arg2, arg3), arg2);
    }

    public fun first_buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::first_buy_<T0>(v1, arg1, arg2, arg3, v0, arg4, arg5));
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, bool) {
        0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun migrate_start<T0>(arg0: &mut Configuration, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::migrate_start<T0>(borrow_bonding_curve_mut<T0>(arg0), arg3)
    }

    public fun migrate_to_dex<T0>(arg0: &mut Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::migrate_to_dex<T0>(borrow_bonding_curve_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::sell_<T0>(v1, arg1, arg2, arg3, v0, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, v3);
        v2
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        buy_<T0>(arg0, v0, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x878255e30ffba7b6b703f61b7d42735df99f5d9a6e257c11056d99fd28bd253b::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
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
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Configuration>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg3 > 0 && arg3 < arg2 && arg3 < 18446744073709551615 - arg5, 1);
        assert!(arg7 < 10000 && arg4 < 10000, 3);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.to_dex_liquidity_pbs = arg4;
        arg0.token_offset = arg5;
        arg0.sui_offset = arg6;
        arg0.fee_bps = arg7;
        let v0 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            to_dex_liquidity_pbs : arg4,
            token_offset         : arg5,
            sui_offset           : arg6,
            fee_bps              : arg7,
        };
        0x2::event::emit<ConfigurationChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

