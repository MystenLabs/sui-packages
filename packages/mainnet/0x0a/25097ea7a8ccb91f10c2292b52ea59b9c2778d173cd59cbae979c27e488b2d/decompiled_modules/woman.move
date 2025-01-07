module 0xa25097ea7a8ccb91f10c2292b52ea59b9c2778d173cd59cbae979c27e488b2d::woman {
    struct WOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMAN>(arg0, 6, b"WOMAN", b"SUI Woman", b"SUIWOMAN, the powerful SUIWOMAN, partners with SUI MAN, the legendary superhero. Together, they form an unstoppable duo, fighting against evil and inspiring hope in their community. With her unmatched strength and intelligence, SUIWOMAN complements SUI MAN's bravery and determination", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwoman_fa723dc7c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

