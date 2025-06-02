module 0x1c56597633d9c54873372dd1a16749e14e09181c16a65f64c8a2cf1199663098::article {
    public fun pay_for_article(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x9a5b0ad3a18964ab7c0dbf9ab4cdecfd6b3899423b47313ae6e78f4b801022a3);
    }

    entry fun pay_for_article_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        pay_for_article(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

