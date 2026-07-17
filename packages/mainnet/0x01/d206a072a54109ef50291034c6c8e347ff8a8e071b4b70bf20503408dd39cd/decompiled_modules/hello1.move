module 0x1d206a072a54109ef50291034c6c8e347ff8a8e071b4b70bf20503408dd39cd::hello1 {
    public entry fun send_sui_via_contract(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

