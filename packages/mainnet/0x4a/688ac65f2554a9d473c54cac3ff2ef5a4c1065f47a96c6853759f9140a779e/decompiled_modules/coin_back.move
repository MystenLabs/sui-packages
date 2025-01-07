module 0x4a688ac65f2554a9d473c54cac3ff2ef5a4c1065f47a96c6853759f9140a779e::coin_back {
    entry fun transfer_back(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

