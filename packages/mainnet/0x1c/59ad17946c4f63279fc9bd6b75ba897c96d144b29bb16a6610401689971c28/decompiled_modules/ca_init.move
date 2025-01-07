module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::ca_init {
    public fun new<T0>(arg0: &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::CreditManager, arg1: &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::TierRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::tier_registry::tier_exists(arg1, arg2), 0);
        assert!(0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_manager::is_tier_whitelisted(arg0, v0, arg2), 1);
        let (v1, v2) = 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::new(arg2, v0, arg3);
        0x2::transfer::public_share_object<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::CreditAccount>(v1);
        0x2::transfer::public_transfer<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::credit_account::OwnerKey>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

