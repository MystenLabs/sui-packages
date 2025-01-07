module 0xd307628cef4a882a87bcc7ff58674c490822259594e0e0e25eb5dba4cddebf45::send_gas {
    public fun send_gas(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, 10000000, arg3), @0x27644de364b82b301f28968dafd617b5d1da472d5686062cf271b7391d0be140);
    }

    public fun sub(arg0: u64, arg1: u64, arg2: u64) {
    }

    // decompiled from Move bytecode v6
}

