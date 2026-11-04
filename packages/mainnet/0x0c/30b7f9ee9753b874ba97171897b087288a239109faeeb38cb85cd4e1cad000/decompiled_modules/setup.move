module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::CoinMetadata<T0> {
        let (v0, v1, v2) = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::new<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::roles::ContractAdmin>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::roles::setup_roles<T0>(&mut v3, arg6);
        let v5 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::borrow_caps<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::roles::ContractAdmin>(&mut v3, arg6);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::rules::add_default_rules<T0>(&v5, &mut v4, arg6);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::return_caps<T0>(&mut v3, v5);
        0x2::token::share_policy<T0>(v4);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::share<T0>(v3);
        v0
    }

    // decompiled from Move bytecode v7
}

