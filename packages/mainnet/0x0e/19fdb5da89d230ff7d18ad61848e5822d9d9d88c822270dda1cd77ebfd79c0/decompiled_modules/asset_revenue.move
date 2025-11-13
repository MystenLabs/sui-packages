module 0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::DragonBallCollector, arg1: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::app::ProtocolApp, arg2: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_can_summon_shenron(arg0);
        0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::revenue_admin::take_revenue<T0, T1>(0xe19fdb5da89d230ff7d18ad61848e5822d9d9d88c822270dda1cd77ebfd79c0::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

