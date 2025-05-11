module 0x6ea5c7ca5b609387cfa3d4f72a68c280f7eb6872495678675e87ff0da63043c3::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 9, b"Baby", b"Meme Token", b"A fun meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.memefi.club/landing/logo/memefi.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

