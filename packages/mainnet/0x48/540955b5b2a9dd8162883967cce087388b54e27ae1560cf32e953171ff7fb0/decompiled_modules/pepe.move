module 0x48540955b5b2a9dd8162883967cce087388b54e27ae1560cf32e953171ff7fb0::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795567242524-1a07cbb5773c147cef8ad36b8a9e8413.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795567242524-1a07cbb5773c147cef8ad36b8a9e8413.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE", b"PepeSui", b"pepeeeeeee", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<PEPE>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

