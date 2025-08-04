module 0x4b1c440b399cb4200e3f54f78ed59a22ac134757c9793b4cc43b5d3b47dce364::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 6, b"LOKI", b"Loki On Sui", b"LOKI is a historic Yeti and ready to become one of the biggest memes on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7fhzygah4jkwitgxyczqb2afe5mrntniognvw4xknlu6aivnpqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

