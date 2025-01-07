module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::ca_init {
    public fun new<T0>(arg0: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_manager::CreditManager, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::tier_exists(arg1, arg2), 0);
        assert!(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_manager::is_tier_whitelisted(arg0, v0, arg2), 1);
        let (v1, v2) = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::new(arg2, v0, arg3);
        0x2::transfer::public_share_object<0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount>(v1);
        0x2::transfer::public_transfer<0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::OwnerKey>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

