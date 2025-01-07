module 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::fun_7k {
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
        supported_lock_bps: 0x2::vec_set::VecSet<u64>,
        lock_period: u64,
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
        lock_period: u64,
    }

    struct LockBpsChangedEvent has copy, drop, store {
        lock_bps: vector<u64>,
    }

    struct FeeClaimedEvent has copy, drop, store {
        fee: u64,
    }

    public fun buy_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3, v4) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::buy_<T0>(v1, arg1, arg2, arg3, v0, arg5, arg4, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, v4);
        (v2, v3)
    }

    fun create_<T0>(arg0: &Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        assert!(0x2::vec_set::contains<u64>(&arg0.supported_lock_bps, &arg2), 2);
        0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::create_<T0>(arg1, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_pbs, arg0.token_offset, arg0.sui_offset, arg0.lock_period, arg2, arg0.fee_bps, arg3, arg4)
    }

    public fun get_bonding_curve<T0>(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::get_bonding_curve<T0>(borrow_bonding_curve<T0>(arg0))
    }

    public fun quote_amount_in<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3, v4) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_in<T0>(v1, v0, arg1, arg2);
        let v5 = if (arg2) {
            let (_, v7, _, _, _, v11, v12, _, _) = get_bonding_curve<T0>(arg0);
            let v15 = 0;
            let v16 = v11 - v7;
            if (v16 < v12) {
                let v17 = if (v12 - v16 > arg1) {
                    arg1
                } else {
                    v12 - v16
                };
                v15 = v17;
            };
            v15
        } else {
            0
        };
        (v2, v3, v4, v5)
    }

    public fun quote_amount_out<T0>(arg0: &mut Configuration, arg1: u64, arg2: bool) : (u64, u64, u64, u64) {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3, v4) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_out<T0>(v1, v0, arg1, arg2);
        let v5 = if (arg2) {
            let (_, v7, _, _, _, v11, v12, _, _) = get_bonding_curve<T0>(arg0);
            let v15 = 0;
            let v16 = v11 - v7;
            if (v16 < v12) {
                let v17 = if (v12 - v16 > v2) {
                    v2
                } else {
                    v12 - v16
                };
                v15 = v17;
            };
            v15
        } else {
            0
        };
        (v2, v3, v4, v5)
    }

    public fun sell_<T0>(arg0: &mut Configuration, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.fee_bps;
        let v1 = borrow_bonding_curve_mut<T0>(arg0);
        let (v2, v3) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::sell_<T0>(v1, arg1, arg2, arg3, v0, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, v3);
        v2
    }

    public fun borrow_bonding_curve<T0>(arg0: &Configuration) : &0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun borrow_bonding_curve_mut<T0>(arg0: &mut Configuration) : &mut 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1;
        let (v1, v2) = buy_<T0>(arg0, v0, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg6));
        };
        if (0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::value<T0>(&v3) == 0) {
            0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(v3, 0x2::tx_context::sender(arg6));
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
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee);
        let v1 = FeeClaimedEvent{fee: v0};
        0x2::event::emit<FeeClaimedEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, v0), arg2)
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::BondingCurve<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), create_<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun create_and_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg3;
        let (v1, v2) = create_and_buy_<T0>(arg0, arg1, arg2, v0, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
        };
        if (0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::value<T0>(&v3) == 0) {
            0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(v3, 0x2::tx_context::sender(arg6));
        };
        if (0x2::coin::value<T0>(&v4) == 0) {
            0x2::coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
        };
    }

    public fun create_and_buy_<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>) {
        create<T0>(arg0, arg1, arg2, arg4, arg6);
        buy_<T0>(arg0, arg3, true, 0, arg4, arg5, arg6)
    }

    public fun get_configuration(arg0: &Configuration) : (u64, u64, u64, u64, u64, u64, u64, u64, 0x2::vec_set::VecSet<u64>) {
        (arg0.version, arg0.total_supply, arg0.bonding_curve_amount, arg0.to_dex_liquidity_pbs, arg0.token_offset, arg0.sui_offset, arg0.fee_bps, arg0.lock_period, arg0.supported_lock_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            total_supply         : 0,
            bonding_curve_amount : 0,
            to_dex_liquidity_pbs : 0,
            token_offset         : 0,
            sui_offset           : 0,
            supported_lock_bps   : 0x2::vec_set::singleton<u64>(0),
            lock_period          : 0,
            fee_bps              : 0,
            fee                  : 0x2::balance::zero<0x2::sui::SUI>(),
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
        let (v2, v3) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_in_(arg0.bonding_curve_amount, arg0.sui_offset, v1, arg0.fee_bps, true);
        if (arg3 > 0) {
            let (v4, _) = 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_out_((((v2 as u128) * (arg3 as u128) / (10000 as u128)) as u64), arg0.sui_offset, v1, arg0.fee_bps, true);
            v0 = v4;
        };
        let (v6, v7) = if (arg2) {
            if (arg1 > v2) {
                return (arg0.bonding_curve_amount, v2, v3, v0)
            };
            0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_out_(arg1, arg0.sui_offset, v1, arg0.fee_bps, true)
        } else {
            if (arg1 > arg0.bonding_curve_amount) {
                return (v2, arg0.bonding_curve_amount, v3, v0)
            };
            0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::quote_amount_in_(arg1, arg0.sui_offset, v1, arg0.fee_bps, true)
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

    public entry fun unlock_locked_coin<T0>(arg0: &mut Configuration, arg1: 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_locked_coin_<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unlock_locked_coin_<T0>(arg0: &mut Configuration, arg1: 0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::bonding_curve::is_claimable<T0>(borrow_bonding_curve_mut<T0>(arg0), arg2), 4);
        0x2::coin::from_balance<T0>(0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::into_balance<T0>(arg1), arg3)
    }

    public entry fun unlock_locked_coin_vec<T0>(arg0: &mut Configuration, arg1: vector<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unlock_locked_coin_vec_<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unlock_locked_coin_vec_<T0>(arg0: &mut Configuration, arg1: vector<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(&arg1) > 0, 5);
        let v0 = unlock_locked_coin_<T0>(arg0, 0x1::vector::pop_back<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(&mut arg1), arg2, arg3);
        while (0x1::vector::length<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(&arg1) > 0) {
            0x2::coin::join<T0>(&mut v0, unlock_locked_coin_<T0>(arg0, 0x1::vector::pop_back<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(&mut arg1), arg2, arg3));
        };
        0x1::vector::destroy_empty<0xb1f4ad441f7d799c56bd1512a52d8861697cd9913cb8ccf22acb20f2af78a1ef::locked_coin::LockedCoin<T0>>(arg1);
        v0
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
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
        assert!(arg7 < 10000 && arg4 < 10000, 1);
        arg0.total_supply = arg2;
        arg0.bonding_curve_amount = arg3;
        arg0.to_dex_liquidity_pbs = arg4;
        arg0.token_offset = arg5;
        arg0.sui_offset = arg6;
        arg0.fee_bps = arg7;
        arg0.lock_period = arg8;
        let v1 = ConfigurationChangedEvent{
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            to_dex_liquidity_pbs : arg4,
            token_offset         : arg5,
            sui_offset           : arg6,
            fee_bps              : arg7,
            lock_period          : arg8,
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

