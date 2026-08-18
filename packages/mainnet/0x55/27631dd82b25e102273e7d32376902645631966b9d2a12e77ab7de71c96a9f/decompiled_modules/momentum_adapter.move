module 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::momentum_adapter {
    public fun buy_base_bq<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::VaultTradeCap<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg4));
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg4, false, true, arg6, arg8, arg9, arg5, arg10);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(v5 == arg6 && v4 == 0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg4, v3, 0x2::balance::zero<T0>(), 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::strategy_take_quote<T1>(arg0, arg6), arg5, arg10);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::finish_buy<T0, T1>(arg0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg4), arg6, arg7, v0, 0x2::clock::timestamp_ms(arg9));
    }

    public fun buy_base_qb<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::VaultTradeCap<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg4));
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg4, true, true, arg6, arg8, arg9, arg5, arg10);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(v4 == arg6 && v5 == 0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T1>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg4, v3, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::strategy_take_quote<T1>(arg0, arg6), 0x2::balance::zero<T0>(), arg5, arg10);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::finish_buy<T0, T1>(arg0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg4), arg6, arg7, v1, 0x2::clock::timestamp_ms(arg9));
    }

    public fun sell_base_bq<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::VaultTradeCap<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg4));
        sell_bq<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun sell_base_qb<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::VaultTradeCap<T1>, arg2: &0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::LotusConfig, arg3: u64, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::assert_swap_allowed<T1>(arg0, arg2, arg3, arg1, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg4));
        sell_qb<T0, T1>(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun sell_bq<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, arg3, arg5, arg6, arg2, arg7);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(v4 == arg3 && v5 == 0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v0);
        let (v6, v7) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, v6, 0x2::balance::zero<T1>(), arg2, arg7);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::finish_sell<T1>(arg0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), arg3, arg4, v7, v1);
    }

    fun sell_qb<T0, T1>(arg0: &mut 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::Vault<T1>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg1, false, true, arg3, arg5, arg6, arg2, arg7);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(v5 == arg3 && v4 == 0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::errors::swap_debt_mismatch());
        0x2::balance::destroy_zero<T0>(v1);
        let (v6, v7) = 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::vault::strategy_take_aux<T1, T0>(arg0, arg3);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg1, v3, 0x2::balance::zero<T1>(), v6, arg2, arg7);
        0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::dex_adapter::finish_sell<T1>(arg0, 0x5527631dd82b25e102273e7d32376902645631966b9d2a12e77ab7de71c96a9f::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg1), arg3, arg4, v7, v0);
    }

    // decompiled from Move bytecode v7
}

