module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::deepbook_adapter {
    public(friend) fun place_limit_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (bool, u64, vector<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>) {
        let (_, _, v2, v3, v4) = 0xdee9::clob_v2::place_limit_order_with_metadata<T0, T1>(arg0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::deepbook_client_order_id(), arg4, arg3, 0, arg2, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::timestamp_inf(), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::deepbook_no_restriction(), arg5, arg1, arg6);
        (v2, v3, v4)
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg1: &0xdee9::custodian_v2::AccountCap, arg2: bool, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, vector<0xdee9::clob_v2::MatchedOrderMetadata<T0, T1>>) {
        if (arg2) {
            0x2::coin::destroy_zero<T0>(arg4);
            0xdee9::clob_v2::swap_exact_quote_for_base_with_metadata<T0, T1>(arg0, 0, arg1, arg3, arg6, arg5, arg7)
        } else {
            0xdee9::clob_v2::swap_exact_base_for_quote_with_metadata<T0, T1>(arg0, 0, arg1, arg3, arg4, arg5, arg6, arg7)
        }
    }

    // decompiled from Move bytecode v6
}

