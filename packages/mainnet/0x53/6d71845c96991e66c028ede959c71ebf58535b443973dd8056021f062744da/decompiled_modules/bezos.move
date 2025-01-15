module 0x536d71845c96991e66c028ede959c71ebf58535b443973dd8056021f062744da::bezos {
    struct BEZOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEZOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEZOS>(arg0, 6, b"BEZOS", b"Playboy Bezos", b"Jeff Bezos: $36 billion divorce, 60 years old, still partying. Playboy $BEZOS is your chance to win big like the man himself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250115_171558_236_fd586b075a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEZOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEZOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

