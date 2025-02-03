module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding {
    struct FundingDeductedEvent<phantom T0> has copy, drop, store {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    struct FundingCreditedEvent<phantom T0> has copy, drop, store {
        account_id: 0x2::object::ID,
        amount: u64,
    }

    public fun batch_deduct_funding<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg7);
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::batch_get_ids<T2>(arg1, arg4, arg5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            deduct_funding_int<T0, T1, T2>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&v0, v1), arg2, arg3, arg6, arg8);
            v1 = v1 + 1;
        };
    }

    public fun deduct_funding<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: 0x2::object::ID, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg6);
        deduct_funding_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    fun deduct_funding_int<T0, T1, T2>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T2>, arg2: 0x2::object::ID, arg3: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg4: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::friend_borrow<T2>(arg1, arg2);
        let v1 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::get_funding_data_since_timestamp<T0>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::last_funding_deduction_timestamp<T0, T2>(v0), arg3);
        let v2 = 0x1::vector::length<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRateInfo>(&v1);
        let v3 = 0;
        while (v3 < v2) {
            let (v4, v5, v6, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::helper::account_balance<T0, T1, T2>(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0));
            let (v8, v9) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::calc_position(v4, v5, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::liability<T0, T2>(v0, false));
            let (v10, v11, v12, _) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::get_funding_info_data(0x1::vector::borrow<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRateInfo>(&v1, v3));
            let v14 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils::iou_usd_val(v8, v12, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0));
            if (v14 == 0) {
                break
            };
            let v15 = ((v14 * (v10 as u128) / (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_scaling() as u128)) as u64);
            if (v11 == v9) {
                if (v6 > v15) {
                    0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::repay_debt_kusd<T0, T1, T2>(arg4, 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), v15, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0), arg6)));
                } else {
                    0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::inc_liability<T0, T2>(v0, v15, true, arg6);
                };
                let v16 = FundingDeductedEvent<T0>{
                    account_id : arg2,
                    amount     : v15,
                };
                0x2::event::emit<FundingDeductedEvent<T0>>(v16);
            } else {
                0xdee9::clob_v2::deposit_quote<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg0), 0x2::coin::from_balance<T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::take_debt_kusd<T0, T1, T2>(arg4, v15), arg6), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::account_cap<T2>(v0));
                let v17 = FundingCreditedEvent<T0>{
                    account_id : arg2,
                    amount     : v15,
                };
                0x2::event::emit<FundingCreditedEvent<T0>>(v17);
            };
            v3 = v3 + 1;
        };
        let (_, _, _, v21) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::get_funding_info_data(0x1::vector::borrow<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRateInfo>(&v1, v2 - 1));
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account::set_last_funding_deduction_timestamp<T0, T2>(v0, v21);
    }

    public fun set_dynamic_rate<T0, T1>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg3: &0x2::clock::Clock, arg4: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg4);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::set_dynamic_rate<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool<T0, T1>(arg0), arg1, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(arg2), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::iou_scaling<T0, T1>(arg0), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::tick_size<T0, T1>(arg0), arg3);
    }

    public fun set_funding_rate<T0>(arg0: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg1: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequestLock, arg3: &0x2::clock::Clock, arg4: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg4);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::verify<T0>(&arg1);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::set_funding_rate<T0>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::mark_price<T0>(&arg1), arg3);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::burn<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

