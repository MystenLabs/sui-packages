module 0x1cd2abeda2a7b35ffeaf149af2d27dfae999f735b93d6d38bc94b3e7c7c139df::ttr {
    struct TTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TTR>(arg0, 6, 0x1::string::utf8(b"Ttr"), 0x1::string::utf8(b"Testy"), 0x1::string::utf8(b"Testsui"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TTR>>(0x2::coin_registry::finalize<TTR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

