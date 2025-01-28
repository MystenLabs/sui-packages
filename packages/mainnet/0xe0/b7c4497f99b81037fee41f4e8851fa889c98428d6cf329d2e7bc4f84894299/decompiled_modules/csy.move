module 0xe0b7c4497f99b81037fee41f4e8851fa889c98428d6cf329d2e7bc4f84894299::csy {
    struct CSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSY>(arg0, 6, b"CSY", b"Chinese Sui Year", b"A limited-edition Chinese Sui token designed to honor the vibrant traditions of Chinese New Year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738068951961.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

