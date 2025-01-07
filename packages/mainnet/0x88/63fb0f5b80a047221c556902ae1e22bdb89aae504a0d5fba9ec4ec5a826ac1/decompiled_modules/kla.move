module 0x8863fb0f5b80a047221c556902ae1e22bdb89aae504a0d5fba9ec4ec5a826ac1::kla {
    struct KLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLA>(arg0, 6, b"KLA", b"Koala", b"KoalaCoin combines financial growth with wildlife conservation. Every transaction helps protect koala habitats. Join our community-driven mission to make a positive impact while enjoying a lovable, meme-friendly cryptocurrency. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731662093790.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

