module 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::kappa_fun {
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
    }

    struct ConfigurationChangedEvent has copy, drop, store {
        total_supply: u64,
        bonding_curve_amount: u64,
        token_offset: u64,
        sui_offset: u64,
        treasury: address,
        liquidity_address: address,
        fee_bps: u64,
    }

    struct ProtocolStatusChangedEvent has copy, drop, store {
        active_status: bool,
    }

    public fun buy_<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut Configuration, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4.fee_bps;
        let v1 = arg4.liquidity_address;
        let v2 = borrow_bonding_curve_mut<T0>(arg4);
        let (v3, v4) = 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::buy_<T0>(arg0, arg1, arg2, arg3, v1, v2, arg5, arg6, arg7, v0, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg4.treasury);
    }

    fun create_<T0>(arg0: &Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 2);
        0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::create_<T0>(arg1, arg2, arg3, arg4, arg0.total_supply, arg0.bonding_curve_amount, arg0.token_offset, arg0.sui_offset, arg5, arg0.fee_bps, arg6, arg7)
    }

    public fun first_buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::first_buy_<T0>(v1, arg1, arg2, arg3, v0, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg0.treasury);
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, bool) {
        0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.status == true, 111);
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::sell_<T0>(v1, arg1, arg2, arg3, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg0.treasury);
        v2
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun buy<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut Configuration, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.status == true, 111);
        let v0 = &mut arg5;
        buy_<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7, arg8, arg9);
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, 0x2::tx_context::sender(arg9));
        };
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == true, 111);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xce2e9bffd9b15997536194fca0675b167da3d114721c2b015050246ea0d4ec4d::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun first_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == true, 111);
        let v0 = &mut arg1;
        first_buy_<T0>(arg0, v0, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        };
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
            token_offset         : 176800000000000000,
            sui_offset           : 1900000000000,
            fee_bps              : 100,
            treasury             : @0x3c6f0793bfc3a2dff0d01a43ca75d6f013b2b6b344a0a35624fdfc18379d4778,
            liquidity_address    : @0xa1c62eccd8246062ec1b86f3f7a03b90715092030be69c47629286b3332f3c3a,
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
            status               : true,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Configuration>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_protocol_active_status(arg0: &mut Configuration, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = arg2;
        let v0 = ProtocolStatusChangedEvent{active_status: arg2};
        0x2::event::emit<ProtocolStatusChangedEvent>(v0);
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 < arg2 && arg3 < 18446744073709551615 - arg4, 1);
        assert!(arg6 < 10000, 3);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.token_offset = arg4;
        arg0.sui_offset = arg5;
        arg0.fee_bps = arg6;
        arg0.treasury = arg7;
        arg0.liquidity_address = arg8;
        let v0 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            token_offset         : arg4,
            sui_offset           : arg5,
            treasury             : arg7,
            liquidity_address    : arg8,
            fee_bps              : arg6,
        };
        0x2::event::emit<ConfigurationChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

