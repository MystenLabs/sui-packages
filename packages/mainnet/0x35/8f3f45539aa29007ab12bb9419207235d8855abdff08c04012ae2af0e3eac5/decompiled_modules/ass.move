module 0x358f3f45539aa29007ab12bb9419207235d8855abdff08c04012ae2af0e3eac5::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"Ass", b"Asscoin", b"The ass coin of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsxruayqtq3phwx7qwxxm2tck33sgikxcubcqew64qmpnjnaq4xm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

