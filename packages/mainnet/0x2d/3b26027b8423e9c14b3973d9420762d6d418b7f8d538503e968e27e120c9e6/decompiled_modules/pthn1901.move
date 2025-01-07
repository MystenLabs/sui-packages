module 0x2d3b26027b8423e9c14b3973d9420762d6d418b7f8d538503e968e27e120c9e6::pthn1901 {
    struct PTHN1901 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTHN1901, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTHN1901>(arg0, 9, b"PTHN1901", b"Hng", b"Scam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ae295d5-b692-4089-9a78-8578ebf31f4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTHN1901>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTHN1901>>(v1);
    }

    // decompiled from Move bytecode v6
}

