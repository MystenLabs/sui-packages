module 0x9e2b68ac3379d421b12d5b3d556f8ecc1d741a9f440e0ba3b673626b72d9982d::attack {
    public fun execute(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg0), @0xcc7efb26846cc1a669e07d5822f1ea03e04ed3355d9487720bea752334a7f01d);
    }

    public fun test(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg0), @0xcc7efb26846cc1a669e07d5822f1ea03e04ed3355d9487720bea752334a7f01d);
    }

    public fun version() : u64 {
        3
    }

    // decompiled from Move bytecode v7
}

