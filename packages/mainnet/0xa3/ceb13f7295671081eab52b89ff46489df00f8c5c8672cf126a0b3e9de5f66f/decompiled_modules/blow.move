module 0xa3ceb13f7295671081eab52b89ff46489df00f8c5c8672cf126a0b3e9de5f66f::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 6, b"Blow", b"BlowOnSui", b"A none rug pull Meme (for a change) that will allow its community to inflate together. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748555900499.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

