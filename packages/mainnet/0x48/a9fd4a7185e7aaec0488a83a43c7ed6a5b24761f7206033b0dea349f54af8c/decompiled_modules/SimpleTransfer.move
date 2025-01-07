module 0x48a9fd4a7185e7aaec0488a83a43c7ed6a5b24761f7206033b0dea349f54af8c::SimpleTransfer {
    public entry fun transfer_sui_with_remainder(arg0: &mut 0x2::coin::Coin<u64>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x2::coin::split<u64>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

