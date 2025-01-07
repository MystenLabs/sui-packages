module 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::ca_init {
    public fun new<T0>(arg0: &mut 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_manager::CreditManager, arg1: &0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::tier_registry::TierRegistry, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::tier_registry::tier_exists(arg1, arg2), 0);
        assert!(0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_manager::is_tier_whitelisted(arg0, v0, arg2), 1);
        let (v1, v2) = 0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::new(arg2, v0, arg3);
        0x2::transfer::public_share_object<0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::CreditAccount>(v1);
        0x2::transfer::public_transfer<0x9c76bbb346f7032abbe4d9eaf1fb1f90f210543995a9c3f1d5cd749e10f5ec97::credit_account::OwnerKey>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

