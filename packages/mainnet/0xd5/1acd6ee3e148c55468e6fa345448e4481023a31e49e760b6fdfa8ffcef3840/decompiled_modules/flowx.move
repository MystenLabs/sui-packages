module 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::flowx {
    struct FlowXContext<phantom T0, phantom T1> {
        wrap_id: 0x2::object::ID,
        trade: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Trade<T0, T1>,
    }

    public fun finish_routing<T0, T1, T2>(arg0: &mut FlowXContext<T0, T1>, arg1: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route, arg2: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned) {
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::finish_routing<T0, T1, T2>(&mut arg0.trade, arg1, arg2);
    }

    public fun start_routing<T0, T1, T2>(arg0: &mut FlowXContext<T0, T1>, arg1: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg2: &mut 0x2::tx_context::TxContext) : 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Route {
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::start_routing<T0, T1, T2>(&mut arg0.trade, arg1, arg2)
    }

    public fun borrow_trade_mut<T0, T1>(arg0: &mut FlowXContext<T0, T1>) : &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::Trade<T0, T1> {
        &mut arg0.trade
    }

    public fun confirm_swap<T0, T1>(arg0: &mut 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::GlobalConfig, arg1: 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::WrapContext, arg2: FlowXContext<T0, T1>, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg4: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg5: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_package_version(arg0);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_pause(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::destroy_wrap_context(arg1);
        let FlowXContext {
            wrap_id : v6,
            trade   : v7,
        } = arg2;
        assert!(v0 == v6, 3);
        let v8 = 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::settle<T0, T1>(arg3, arg4, v7, arg5, arg6, arg7);
        let (v9, v10) = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::deduct_fee<T1>(arg0, v8, arg7);
        let v11 = v9;
        assert!(0x2::coin::value<T1>(&v11) >= v4, 2);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::emit_confirm_swap_event(0x2::tx_context::sender(arg7), v1, v2, v3, 0x2::coin::value<T1>(&v8), v4, v10, v5);
        v11
    }

    public fun new_context<T0, T1>(arg0: &mut 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::GlobalConfig, arg1: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury::Treasury, arg2: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::trade_id_tracker::TradeIdTracker, arg3: &mut 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::partner_manager::PartnerRegistry, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: 0x1::option::Option<0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission::Commission>, arg10: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg11: &mut 0x2::tx_context::TxContext) : (0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::WrapContext, FlowXContext<T0, T1>) {
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_package_version(arg0);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::new_wrap_context(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg5, b"FLOWX", arg11);
        let v2 = FlowXContext<T0, T1>{
            wrap_id : 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::get_wrap_context_id(&v1),
            trade   : 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::universal_router::build<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11),
        };
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

