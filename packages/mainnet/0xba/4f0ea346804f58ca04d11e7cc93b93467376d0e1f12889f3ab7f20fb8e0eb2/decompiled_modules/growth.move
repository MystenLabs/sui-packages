module 0xba4f0ea346804f58ca04d11e7cc93b93467376d0e1f12889f3ab7f20fb8e0eb2::growth {
    struct GROWTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROWTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROWTH>(arg0, 6, b"GROWTH", b"GROWTH-U", b"Growth-U is a personal development company designed to help upgrade your human success operating system. With our powerful online programs and events, we provide support and accountability to help you become the person you need to be.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738106933887.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROWTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROWTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

