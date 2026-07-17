module 0x3bb2a074ce90b437464b8705c5a4ad5321aed8fc102dd7809b27beb2118f94eb::hello1 {
    public fun send_sui_via_contract(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

