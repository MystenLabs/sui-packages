module 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::flowx {
    public fun confirm_swap<T0, T1>(arg0: &mut 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::Config, arg1: 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::SwapRequest, arg2: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Trade<T0, T1>, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::checked_package_version(arg0);
        0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::checked_pause(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::destroy_swap_request(arg1);
        assert!(v2 == 0x1::type_name::get<T1>(), 3);
        let (v6, v7) = 0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::deduct_fee<T1>(arg0, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg3, arg4, arg2, arg5, arg6, arg7), arg7);
        let v8 = v6;
        assert!(0x2::coin::value<T1>(&v8) >= v4, 2);
        0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::emit_confirm_swap_event(v0, v1, v2, v3, 0x2::coin::value<T1>(&v8), v4, v7, v5);
        v8
    }

    public fun start_swap<T0, T1>(arg0: &0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::Config, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: 0x1::option::Option<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>, arg11: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg12: &mut 0x2::tx_context::TxContext) : (0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::SwapRequest, 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Trade<T0, T1>) {
        0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::checked_package_version(arg0);
        0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        (0x71fea46ff1d142c84f802c59f5b71168713ca305b5a06575971f1dc013e9bc99::config::new_wrap_context(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg5, b"FLOWX", arg12), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12))
    }

    // decompiled from Move bytecode v6
}

