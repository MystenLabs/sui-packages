module 0xeb0d78d9888d46861559d16d6c0d2962b3ef62436192dd9789525ee9ed26ee54::article {
    public fun pay_for_article(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x9a5b0ad3a18964ab7c0dbf9ab4cdecfd6b3899423b47313ae6e78f4b801022a3);
    }

    entry fun pay_for_article_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        pay_for_article(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

