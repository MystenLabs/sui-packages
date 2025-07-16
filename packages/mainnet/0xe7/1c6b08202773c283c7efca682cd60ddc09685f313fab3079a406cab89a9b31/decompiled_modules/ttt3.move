module 0xe71c6b08202773c283c7efca682cd60ddc09685f313fab3079a406cab89a9b31::ttt3 {
    struct TTT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT3>(arg0, 6, b"TTT3", b"Test03", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

