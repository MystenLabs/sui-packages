module 0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::setup {
    public entry fun create_state(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::state::State>(0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::state::new(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

