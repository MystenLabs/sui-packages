module 0x208ee94b73c1b2c1927a844222d8450f323695b2e3cb5d61720cf4dd953617bf::lollo {
    struct LOLLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLLO>(arg0, 6, b"LOLLO", b"lollopop", b"lollopopping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidddfuli3ndmtijdyc4bfjru2ge6jjjtwzyizvtrqn7gvxs4mcf5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

