module 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::policy {
    public entry fun seal_approve_owner_only(arg0: vector<u8>, arg1: &0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::Form, arg2: &0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::FormAdminCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::Form>(arg1) == 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::admin_cap_form(arg2), 1);
    }

    public entry fun seal_approve_timelock(arg0: vector<u8>, arg1: &0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::Form, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::close_at_ms(arg1), 2);
    }

    // decompiled from Move bytecode v7
}

