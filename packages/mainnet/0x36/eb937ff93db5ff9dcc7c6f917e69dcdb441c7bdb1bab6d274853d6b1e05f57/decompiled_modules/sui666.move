module 0x36eb937ff93db5ff9dcc7c6f917e69dcdb441c7bdb1bab6d274853d6b1e05f57::sui666 {
    struct SUI666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI666>(arg0, 6, b"SUI666", b"666", b"666 is a Chinese word, homonym for (ni ni ni) or (li li li), used to describe someone or something is very powerful, cool, impressive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_98b70bf0c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI666>>(v1);
    }

    // decompiled from Move bytecode v6
}

