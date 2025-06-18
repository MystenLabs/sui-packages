module 0xd000091ce4582ee52da868923c99b57459af1de1d33f8f084ae2205922ee7e1b::send_sui {
    public entry fun send_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

