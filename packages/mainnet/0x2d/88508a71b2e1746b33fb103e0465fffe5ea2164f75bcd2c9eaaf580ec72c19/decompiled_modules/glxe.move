module 0x2d88508a71b2e1746b33fb103e0465fffe5ea2164f75bcd2c9eaaf580ec72c19::glxe {
    struct GLXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLXE>(arg0, 6, b"GLXE", b"Galxe", b"The leading web3 growth platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiabzitgytlmb766xcq7hacbsufkhon65tgpgdfxzi4rscny4j4kdy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLXE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

