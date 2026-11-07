module 0x60e644caaaff00b0510e02397d0b70032c476e3a0a3688178a113cb044e21e11::splitter {
    public fun split_and_forward(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 3000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 3000000000, arg1), @0x9ed8bcc54c816f45d08aa03412e3687ec4537568758b2f8d70a2e2ad37fcf28f);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x871a57bae2121907619c8023a2fb06d859e39610e5b89c6a7f93e68ae2606416);
    }

    public fun split_and_forward_custom(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
    }

    // decompiled from Move bytecode v7
}

