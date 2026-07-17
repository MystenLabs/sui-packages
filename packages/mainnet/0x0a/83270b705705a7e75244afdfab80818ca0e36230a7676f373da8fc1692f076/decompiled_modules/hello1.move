module 0xa83270b705705a7e75244afdfab80818ca0e36230a7676f373da8fc1692f076::hello1 {
    public entry fun send_sui_via_contract(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

