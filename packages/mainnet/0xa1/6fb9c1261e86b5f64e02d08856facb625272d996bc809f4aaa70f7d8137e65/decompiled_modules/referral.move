module 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::referral {
    public fun update_referral_claim_pause(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::referral_admin::update_referral_claim_pause(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4);
    }

    public fun update_referral_params(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg6));
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::referral_admin::update_referral_params(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

