module 0x1506b536c5df59d87da5a824e3a7052a00ca20c126a6ee1f5f28f3df51c9b1a8::transfer {
    public entry fun send_sui(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3), arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

