module 0x25d4339ad8be1213fc035fc827e0cf5d200d523f2867572ebddcb6a7786cefaf::bonding_curve {
    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        coin_vault: 0x2::balance::Balance<T0>,
        to_dex_vault: 0x2::balance::Balance<T0>,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        bonding_curve_amount: u64,
        lock_amount: u64,
        unlock_timestamp: u64,
        ended: bool,
        to_dex_liquidity_pbs: u64,
    }

    struct BondingCurveCreatedEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        creator: address,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_amount: u64,
        lock_amount: u64,
        unlock_timestamp: u64,
    }

    struct SwapEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        user: address,
        amount_in: u64,
        amount_out: u64,
        locked_amount: u64,
        fee: u64,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        is_buy: bool,
    }

    struct BondingCurveEndedEvent<phantom T0> has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sui_reserve: u64,
        coin_reserve: u64,
    }

    fun add_liquidity<T0, T1>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair_and_treasury<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::mint<T0, T1>(v0, v1, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::from_balance<T1>(arg2, arg3), arg3), @0x0);
        0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T0, T1>>(v0)
    }

    public(friend) fun buy_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25d4339ad8be1213fc035fc827e0cf5d200d523f2867572ebddcb6a7786cefaf::locked_coin::LockedCoin<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.ended, 3);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            let v0 = v3;
            let (v4, v5, v6) = quote_amount_out<T0>(arg0, arg4, v3, true);
            if (v5 < v3) {
                v0 = v5;
            };
            assert!(v4 >= arg3, 2);
            (v0, v4, v6)
        } else {
            let v1 = arg3;
            let (v7, v8, v9) = quote_amount_in<T0>(arg0, arg4, arg3, true);
            if (v8 < arg3) {
                v1 = v8;
            };
            assert!(v7 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 1);
            (v7, v1, v9)
        };
        let v10 = v0 - v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v10));
        let v11 = 0x2::balance::split<T0>(&mut arg0.coin_vault, v1);
        let v12 = 0;
        let v13 = arg0.bonding_curve_amount - 0x2::balance::value<T0>(&arg0.coin_vault);
        let v14 = if (v13 >= arg0.lock_amount) {
            0x25d4339ad8be1213fc035fc827e0cf5d200d523f2867572ebddcb6a7786cefaf::locked_coin::zero<T0>(arg6)
        } else {
            let v15 = if (arg0.lock_amount - v13 > v1) {
                v1
            } else {
                arg0.lock_amount - v13
            };
            v12 = v15;
            0x25d4339ad8be1213fc035fc827e0cf5d200d523f2867572ebddcb6a7786cefaf::locked_coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, v15), arg6)
        };
        let v16 = 0x2::coin::from_balance<T0>(v11, arg6);
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve + v10;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve - v1;
        let v17 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg6),
            amount_in            : v10,
            amount_out           : v1,
            locked_amount        : v12,
            fee                  : v2,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : true,
        };
        0x2::event::emit<SwapEvent>(v17);
        let v18 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v2);
        if (0x2::balance::value<T0>(&arg0.coin_vault) == 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v18, seed_to_dex<T0>(arg5, arg0, arg6));
        };
        (v16, v14, v18)
    }

    public(friend) fun create_<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        let v0 = arg1 - arg2;
        let v1 = 0x2::coin::mint_balance<T0>(&mut arg0, arg1);
        let v2 = arg4 + arg2;
        let v3 = 0;
        if (arg7 > 0) {
            let (v4, _) = quote_amount_in_(arg2, arg5, v2, arg8, true);
            let (v6, _) = quote_amount_out_((((v4 as u128) * (arg7 as u128) / (10000 as u128)) as u64), arg5, v2, arg8, true);
            v3 = v6;
        };
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        let v8 = BondingCurve<T0>{
            id                   : 0x2::object::new(arg10),
            sui_vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            coin_vault           : v1,
            to_dex_vault         : 0x2::balance::split<T0>(&mut v1, v0),
            virtual_sui_reserve  : arg5,
            virtual_coin_reserve : arg4 + arg2,
            bonding_curve_amount : arg2,
            lock_amount          : v3,
            unlock_timestamp     : 0x2::clock::timestamp_ms(arg9) + arg6,
            ended                : false,
            to_dex_liquidity_pbs : arg3,
        };
        let v9 = BondingCurveCreatedEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&v8.id),
            creator              : 0x2::tx_context::sender(arg10),
            virtual_sui_reserve  : arg5,
            virtual_coin_reserve : arg4 + arg2,
            total_supply         : arg1,
            bonding_curve_amount : arg2,
            to_dex_amount        : v0,
            lock_amount          : v8.lock_amount,
            unlock_timestamp     : 0x2::clock::timestamp_ms(arg9) + arg6,
        };
        0x2::event::emit<BondingCurveCreatedEvent>(v9);
        v8
    }

    public fun get_bonding_curve<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault), 0x2::balance::value<T0>(&arg0.coin_vault), 0x2::balance::value<T0>(&arg0.to_dex_vault), arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg0.bonding_curve_amount, arg0.lock_amount, arg0.unlock_timestamp, arg0.ended)
    }

    public fun is_claimable<T0>(arg0: &BondingCurve<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.unlock_timestamp < 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun quote_amount_in<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = arg2;
        let (v1, v2) = if (arg3) {
            let v3 = 0x2::balance::value<T0>(&arg0.coin_vault);
            if (v3 < arg2) {
                v0 = v3;
            };
            quote_amount_in_(v0, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3)
        } else {
            let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
            if (v4 < arg2 + (((arg2 as u128) * (arg1 as u128) / ((10000 - arg1) as u128)) as u64)) {
                v0 = (((v4 as u128) * ((10000 - arg1) as u128) / (10000 as u128)) as u64);
            };
            quote_amount_in_(v0, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3)
        };
        assert!(v1 != 0 && v2 != 0, 0);
        (v1, v0, v2)
    }

    public(friend) fun quote_amount_in_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        if (arg4) {
            let v2 = (((arg1 as u128) * (arg0 as u128) / ((arg2 - arg0) as u128)) as u64) + 1;
            let v3 = (((v2 as u128) * (arg3 as u128) / ((10000 - arg3) as u128)) as u64);
            (v2 + v3, v3)
        } else {
            let v4 = (((arg0 as u128) * (arg3 as u128) / ((10000 - arg3) as u128)) as u64);
            let v5 = arg0 + v4;
            ((((v5 as u128) * (arg1 as u128) / ((arg2 - v5) as u128)) as u64) + 1, v4)
        }
    }

    public(friend) fun quote_amount_out<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = arg2;
        let (v1, v2) = if (arg3) {
            let (v3, v4) = quote_amount_out_(arg2, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
            let v2 = v4;
            let v1 = v3;
            let v5 = 0x2::balance::value<T0>(&arg0.coin_vault);
            if (v5 < v3) {
                v1 = v5;
                let (v6, v7) = quote_amount_in_(v5, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
                v2 = v7;
                v0 = v6;
            };
            (v1, v2)
        } else {
            let (v8, v9) = quote_amount_out_(arg2, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
            let v2 = v9;
            let v1 = v8;
            let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
            if (v10 < v8 + v9) {
                let v11 = (((v10 as u128) * ((10000 - v9) as u128) / (10000 as u128)) as u64);
                v1 = v11;
                let (v12, v13) = quote_amount_in_(v11, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
                v2 = v13;
                v0 = v12;
            };
            (v1, v2)
        };
        assert!(v1 != 0 && v2 != 0, 0);
        (v1, v0, v2)
    }

    public(friend) fun quote_amount_out_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        if (arg4) {
            let v2 = (((arg0 as u128) * (arg3 as u128) / (10000 as u128)) as u64);
            let v3 = arg0 - v2;
            ((((v3 as u128) * (arg2 as u128) / ((arg1 + v3) as u128)) as u64), v2)
        } else {
            let v4 = (((arg0 as u128) * (arg2 as u128) / ((arg1 + arg0) as u128)) as u64);
            let v5 = (((v4 as u128) * (arg3 as u128) / (10000 as u128)) as u64) + 1;
            (v4 - v5, v5)
        }
    }

    fun seed_to_dex<T0>(arg0: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg1: &mut BondingCurve<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_vault);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_vault, v0);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut v1, (((v0 as u128) * ((10000 - arg1.to_dex_liquidity_pbs) as u128) / (10000 as u128)) as u64));
        let v3 = 0x2::balance::value<T0>(&arg1.to_dex_vault);
        if (!0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::pair_is_created<0x2::sui::SUI, T0>(arg0)) {
            0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::create_pair<0x2::sui::SUI, T0>(arg0, arg2);
        };
        let v4 = if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<0x2::sui::SUI, T0>()) {
            add_liquidity<0x2::sui::SUI, T0>(arg0, v1, 0x2::balance::split<T0>(&mut arg1.to_dex_vault, v3), arg2)
        } else {
            add_liquidity<T0, 0x2::sui::SUI>(arg0, 0x2::balance::split<T0>(&mut arg1.to_dex_vault, v3), v1, arg2)
        };
        let v5 = BondingCurveEndedEvent<T0>{
            coin_id          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg1),
            pool_id          : v4,
            sui_reserve      : v0 - 0x2::balance::value<0x2::sui::SUI>(&v2),
            coin_reserve     : v3,
        };
        0x2::event::emit<BondingCurveEndedEvent<T0>>(v5);
        v2
    }

    public(friend) fun sell_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.ended, 3);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x2::coin::value<T0>(arg1);
            let v0 = v3;
            let (v4, v5, v6) = quote_amount_out<T0>(arg0, arg4, v3, false);
            if (v5 < v3) {
                v0 = v5;
            };
            assert!(v4 >= arg3, 2);
            (v0, v4, v6)
        } else {
            let v1 = arg3;
            let (v7, v8, v9) = quote_amount_in<T0>(arg0, arg4, arg3, false);
            if (v8 < arg3) {
                v1 = v8;
            };
            assert!(v7 <= 0x2::coin::value<T0>(arg1), 1);
            (v7, v1, v9)
        };
        let v10 = v1 + v2;
        0x2::balance::join<T0>(&mut arg0.coin_vault, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), v0));
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve - v10;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve + v0;
        let v11 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg5),
            amount_in            : v0,
            amount_out           : v10,
            locked_amount        : 0,
            fee                  : v2,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : false,
        };
        0x2::event::emit<SwapEvent>(v11);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v1), arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v2))
    }

    // decompiled from Move bytecode v6
}

