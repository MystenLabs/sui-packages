module 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::setup {
    public fun create_state(arg0: &0x2::package::Publisher, arg1: address, arg2: vector<u8>, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::token_bridge_ptb_resolver::TOKEN_BRIDGE_PTB_RESOLVER>(arg0), 0);
        0x2::transfer::public_share_object<0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::State>(0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::new(arg1, 0x1::string::utf8(arg2), arg3, arg4, arg5, arg6));
    }

    // decompiled from Move bytecode v6
}

