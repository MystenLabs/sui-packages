module 0xd627abd2035024c31b5c199b197bc1ad8e7c03f2d4b01c4dff76e521d8b4e8fc::cdhzd {
    struct CDHZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDHZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDHZD>(arg0, 6, b"CDHZD", b"CHZD", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiapveju3fp4iw2brxhtdc26kfkk4kfeohd4zlovjfirvxwdcq2ufi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDHZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CDHZD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

