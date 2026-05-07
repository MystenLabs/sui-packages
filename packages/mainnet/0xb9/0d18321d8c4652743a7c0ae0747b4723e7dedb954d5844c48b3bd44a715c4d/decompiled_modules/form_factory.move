module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form_factory {
    entry fun create_and_transfer(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form>(0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::new_form(v0, arg0, arg1, 0x1::option::none<u64>(), 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::default_tiers(), 0, arg2), v0);
    }

    public fun create_form_for_owner(arg0: address, arg1: vector<u8>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Tiers, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form {
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::new_form(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

