module 0xea0e483421e469079fc8566b97534ffea38bac26ebab384b183c2b9801e55ee3::tatl {
    struct TATL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATL>(arg0, 6, b"TATL", b"Testing all tokens", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TATL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

