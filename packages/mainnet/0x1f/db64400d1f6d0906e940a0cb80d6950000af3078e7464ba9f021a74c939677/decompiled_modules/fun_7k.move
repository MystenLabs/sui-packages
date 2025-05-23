module 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::fun_7k {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_liquidity_bps: u64,
        token_offset: u64,
        sui_offset: u64,
        end_sqrt_price: u128,
        tick_spacing: u32,
        dex_fee_rate: u64,
        supported_lock_bps: 0x2::vec_set::VecSet<u64>,
        lock_period: u64,
        fee_bps: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        sui_metadata: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::CoinMetadata,
    }

    struct ConfigurationChangedEvent has copy, drop, store {
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_liquidity_bps: u64,
        token_offset: u64,
        sui_offset: u64,
        end_sqrt_price: u128,
        tick_spacing: u32,
        dex_fee_rate: u64,
        fee_bps: u64,
        lock_period: u64,
    }

    struct LockBpsChangedEvent has copy, drop, store {
        lock_bps: vector<u64>,
    }

    public fun buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>) {
        let v0 = arg0.fee_bps;
        let v1 = arg0.sui_metadata;
        let v2 = borrow_bonding_curve_mut<T0>(arg0);
        let (v3, v4, v5) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::buy_<T0>(v2, arg1, arg2, arg3, v0, arg4, arg5, v1, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, v5);
        (v3, v4)
    }

    fun create_<T0>(arg0: &Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        assert!(0x2::vec_set::contains<u64>(&arg0.supported_lock_bps, &arg3), 2);
        0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::create_<T0>(arg1, arg2, arg0.total_supply, arg0.bonding_curve_amount, arg0.tick_spacing, arg0.dex_fee_rate, arg0.end_sqrt_price, arg0.to_dex_liquidity_bps, arg0.token_offset, arg0.sui_offset, arg0.lock_period, arg3, arg0.fee_bps, arg4)
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun quote_amount_in<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3, v4) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_in<T0>(v1, v0, arg1, arg2);
        let v5 = if (arg2) {
            let (_, v7, _, _, _, v11, v12, _, _, _) = get_bonding_curve<T0>(arg0);
            let v16 = 0;
            let v17 = v11 - v7;
            if (v17 < v12) {
                let v18 = if (v12 - v17 > arg1) {
                    arg1
                } else {
                    v12 - v17
                };
                v16 = v18;
            };
            v16
        } else {
            0
        };
        (v2, v3, v4, v5)
    }

    public fun quote_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3, v4) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_out<T0>(v1, v0, arg1, arg2);
        let v5 = if (arg2) {
            let (_, v7, _, _, _, v11, v12, _, _, _) = get_bonding_curve<T0>(arg0);
            let v16 = 0;
            let v17 = v11 - v7;
            if (v17 < v12) {
                let v18 = if (v12 - v17 > v2) {
                    v2
                } else {
                    v12 - v17
                };
                v16 = v18;
            };
            v16
        } else {
            0
        };
        (v2, v3, v4, v5)
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::sell_<T0>(v1, arg1, arg2, arg3, v0, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, v3);
        v2
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        let (v1, v2) = buy_<T0>(arg0, v0, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg6));
        };
        if (0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::value<T0>(&v3) == 0) {
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(v3, 0x2::tx_context::sender(arg6));
        };
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
        };
    }

    public entry fun claim_fee(arg0: &mut Configuration, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(claim_fee_(arg0, arg1, arg3), arg2);
    }

    public fun claim_fee_(arg0: &mut Configuration, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee)), arg2)
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun create_and_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg4;
        let (v1, v2) = create_and_buy_<T0>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg7));
        };
        if (0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::value<T0>(&v3) == 0) {
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(v3, 0x2::tx_context::sender(arg7));
        };
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg7));
        };
    }

    public fun create_and_buy_<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>) {
        create<T0>(arg0, arg1, arg2, arg3, arg7);
        buy_<T0>(arg0, arg4, true, 0, arg5, arg6, arg7)
    }

    public fun get_configuration(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, u128, u32, u64, u64, u64, 0x2::vec_set::VecSet<u64>) {
        (arg0.version, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_bps, arg0.token_offset, arg0.sui_offset, arg0.end_sqrt_price, arg0.tick_spacing, arg0.dex_fee_rate, arg0.fee_bps, arg0.lock_period, arg0.supported_lock_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            total_supply         : 0,
            bonding_curve_amount : 0,
            to_dex_liquidity_bps : 0,
            token_offset         : 0,
            sui_offset           : 0,
            end_sqrt_price       : 0,
            tick_spacing         : 0,
            dex_fee_rate         : 0,
            supported_lock_bps   : 0x2::vec_set::singleton<u64>(0),
            lock_period          : 0,
            fee_bps              : 0,
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
            sui_metadata         : 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata(b"https://cryptologos.cc/logos/sui-sui-logo.png", b"SUI", 9),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Configuration>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun quote_buy<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        if (arg2) {
            quote_amount_out<T0>(arg0, arg1, true)
        } else {
            quote_amount_in<T0>(arg0, arg1, true)
        }
    }

    public fun quote_first_buy(arg0: &mut Configuration, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = arg0.token_offset + arg0.bonding_curve_amount;
        let (v2, v3) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_in_(arg0.bonding_curve_amount, arg0.sui_offset, v1, arg0.fee_bps, true);
        if (arg3 > 0) {
            let (v4, _) = 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_out_((((v2 as u128) * (arg3 as u128) / (10000 as u128)) as u64), arg0.sui_offset, v1, arg0.fee_bps, true);
            v0 = v4;
        };
        let (v6, v7) = if (arg2) {
            if (arg1 > v2) {
                return (arg0.bonding_curve_amount, v2, v3, v0)
            };
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_out_(arg1, arg0.sui_offset, v1, arg0.fee_bps, true)
        } else {
            if (arg1 > arg0.bonding_curve_amount) {
                return (v2, arg0.bonding_curve_amount, v3, v0)
            };
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::quote_amount_in_(arg1, arg0.sui_offset, v1, arg0.fee_bps, true)
        };
        (v6, arg1, v7, v0)
    }

    public fun quote_sell<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        if (arg2) {
            quote_amount_out<T0>(arg0, arg1, false)
        } else {
            quote_amount_in<T0>(arg0, arg1, false)
        }
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        let v1 = sell_<T0>(arg0, v0, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg4));
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun unlock_locked_coin<T0>(arg0: &mut Configuration, arg1: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_locked_coin_<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unlock_locked_coin_<T0>(arg0: &mut Configuration, arg1: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve::is_claimable<T0>(borrow_bonding_curve_mut<T0>(arg0), arg2), 4);
        0x2::coin::from_balance<T0>(0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::into_balance<T0>(arg1), arg3)
    }

    public entry fun unlock_locked_coin_vec<T0>(arg0: &mut Configuration, arg1: vector<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_locked_coin_vec_<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unlock_locked_coin_vec_<T0>(arg0: &mut Configuration, arg1: vector<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(&arg1) > 0, 5);
        let v0 = unlock_locked_coin_<T0>(arg0, 0x1::vector::pop_back<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(&mut arg1), arg2, arg3);
        while (0x1::vector::length<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(&arg1) > 0) {
            0x2::coin::join<T0>(&mut v0, unlock_locked_coin_<T0>(arg0, 0x1::vector::pop_back<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(&mut arg1), arg2, arg3));
        };
        0x1::vector::destroy_empty<0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>>(arg1);
        v0
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u32, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = if (arg3 > 0) {
            if (arg3 < arg2) {
                arg3 < 18446744073709551615 - arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        assert!(arg10 < 10000 && arg4 < 10000, 1);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.to_dex_liquidity_bps = arg4;
        arg0.token_offset = arg5;
        arg0.sui_offset = arg6;
        arg0.fee_bps = arg10;
        arg0.lock_period = arg11;
        arg0.end_sqrt_price = arg7;
        arg0.tick_spacing = arg8;
        arg0.dex_fee_rate = arg9;
        let v1 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            to_dex_liquidity_bps : arg4,
            token_offset         : arg5,
            sui_offset           : arg6,
            end_sqrt_price       : arg7,
            tick_spacing         : arg8,
            dex_fee_rate         : arg9,
            fee_bps              : arg10,
            lock_period          : arg11,
        };
        0x2::event::emit<ConfigurationChangedEvent>(v1);
    }

    public entry fun update_supported_lock_bps(arg0: &mut Configuration, arg1: &AdminCap, arg2: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        if (v0 == 0) {
            arg0.supported_lock_bps = 0x2::vec_set::empty<u64>();
        };
        let v1 = 0;
        arg0.supported_lock_bps = 0x2::vec_set::empty<u64>();
        while (v1 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v1) < 10000, 2);
            0x2::vec_set::insert<u64>(&mut arg0.supported_lock_bps, *0x1::vector::borrow<u64>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v2 = LockBpsChangedEvent{lock_bps: arg2};
        0x2::event::emit<LockBpsChangedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

