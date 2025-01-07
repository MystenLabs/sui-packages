module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MarketCreatedEvent has copy, drop {
        market_id: 0x2::object::ID,
        fr_id: 0x2::object::ID,
        ch_id: 0x2::object::ID,
    }

    public fun withdraw_fees<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::withdraw_collateral<T0, T1, T2>(arg2, 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_fees<T0, T1>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::pool_owner_cap<T0, T1, T2>(arg2), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::pool_mut<T0, T1>(arg1), arg3))), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_market<T0, T1, T2>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: 0x2::coin::Coin<0x2::sui::SUI>, arg21: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg22: 0x2::balance::Supply<T0>, arg23: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg21);
        create_market_int<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg22, arg23);
    }

    fun create_market_int<T0, T1, T2>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: 0x2::balance::Supply<T0>, arg21: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::new<T0>(arg21);
        let v2 = v0;
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::set_config<T0>(&mut v2, arg0, arg3, arg1, arg2);
        let (v3, v4) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::new<T0, T1>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg21);
        0x2::transfer::public_share_object<0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>>(v2);
        let v5 = MarketCreatedEvent{
            market_id : v3,
            fr_id     : v1,
            ch_id     : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::new<T0, T1, T2>(arg20, v4, arg21),
        };
        0x2::event::emit<MarketCreatedEvent>(v5);
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<APP>(arg0, arg1);
    }

    public fun init_treasury<T0>(arg0: &AdminCap, arg1: 0x2::balance::Supply<T0>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg2);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::init_treasury<T0>(arg1, arg3);
    }

    public fun new_price_cap(arg0: &AdminCap, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg2: &mut 0x2::tx_context::TxContext) : 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceCap {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg1);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::new_price_cap(arg2)
    }

    entry fun prune_fr_history<T0>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg2: u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::prune_history<T0>(arg1, arg2);
    }

    entry fun topup_treasury<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::ClearingHouse<T0, T1, T2>, arg2: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::KusdTreasury<T1>, arg3: u64, arg4: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg4);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::clearing_house::topup_kusd_balance<T0, T1, T2>(arg1, arg2, arg3);
    }

    entry fun update_pool_configs<T0, T1>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_max_im_ratio<T0, T1>(arg1, arg3);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_max_mm_ratio<T0, T1>(arg1, arg2);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_oi_limit<T0, T1>(arg1, arg4);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_order_notional_limit<T0, T1>(arg1, arg5);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_position_notional_limit<T0, T1>(arg1, arg6);
    }

    entry fun update_pool_cooldown<T0, T1>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::Market<T0, T1>, arg2: bool, arg3: bool) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_is_long_cooldown<T0, T1>(arg1, arg2);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::market::set_is_short_cooldown<T0, T1>(arg1, arg3);
    }

    public fun update_wallet_mint_fee<T0>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::update_mint_fee<T0>(arg1, arg2);
    }

    public fun withdraw_wallet_mint_fee<T0>(arg0: &AdminCap, arg1: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::AccountStore<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::account_store::withdraw_mint_fee<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

