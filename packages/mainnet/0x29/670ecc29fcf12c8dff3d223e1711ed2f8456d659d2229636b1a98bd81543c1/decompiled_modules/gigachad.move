module 0x29670ecc29fcf12c8dff3d223e1711ed2f8456d659d2229636b1a98bd81543c1::gigachad {
    struct GIGACHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACHAD>(arg0, 6, b"GIGACHAD", b"GIGA CHAD", b"The ultimate alpha of the crypto gym. GIGA CHAD flexes hard, pumps harder, and leaves weak hands trembling. Join the CHAD squad and dominate the meme coin arena!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9898_3b938cf212.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

