module 0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::DragonBallCollector, arg1: &0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::app::ProtocolApp, arg2: &mut 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_can_summon_shenron(arg0);
        0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::revenue_admin::take_revenue<T0, T1>(0x4b9f96d51290896700919a5a708c81fea31e79fc4f553268aa1cc92a04889900::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

