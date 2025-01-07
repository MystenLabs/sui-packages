module 0x90c93364b6c2ba58cc512d98abb2321b278c509a5e0a4b4ca81cfe0c3f34d059::wormhole_adapter {
    entry fun test<T0>(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: &mut 0x2::tx_context::TxContext) {
        0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::verified_asset<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

