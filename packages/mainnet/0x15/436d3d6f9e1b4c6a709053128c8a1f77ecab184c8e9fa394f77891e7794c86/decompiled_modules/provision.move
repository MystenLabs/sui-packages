module 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::provision {
    entry fun subscribe<T0>(arg0: &mut 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::admin::GlobalConfig, arg1: &0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::PlanRegistry, arg2: &mut 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::treasury::Treasury, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::subscribe<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::UserAccount>(v0, v3);
        0x2::transfer::public_transfer<0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::subscription::Subscription>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v3);
        0x15436d3d6f9e1b4c6a709053128c8a1f77ecab184c8e9fa394f77891e7794c86::storage::create_shared_blob_store(arg5);
    }

    // decompiled from Move bytecode v7
}

