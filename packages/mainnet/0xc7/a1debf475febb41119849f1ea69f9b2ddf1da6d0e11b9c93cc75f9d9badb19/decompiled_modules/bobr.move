module 0xc7a1debf475febb41119849f1ea69f9b2ddf1da6d0e11b9c93cc75f9d9badb19::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"Bobr", b"SuiBobr", x"24424f42522069732061206d656d65636f696e206f6e20405375692e0a204469766520696e746f2062656176657220776f726c6420612076696272616e742063727970746f63757272656e63792074686174206272696e67732066756e2c206a6f7920616e6420696e6e6f766174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcgwnq24kacyimfi7vcttwje6nuunvlfxljikfxtvdmzjjglrddi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOBR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

