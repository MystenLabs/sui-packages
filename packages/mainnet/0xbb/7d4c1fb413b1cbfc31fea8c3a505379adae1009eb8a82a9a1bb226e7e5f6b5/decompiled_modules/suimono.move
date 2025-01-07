module 0xbb7d4c1fb413b1cbfc31fea8c3a505379adae1009eb8a82a9a1bb226e7e5f6b5::suimono {
    struct SUIMONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONO>(arg0, 6, b"SUIMONO", b"Sui Mono", b"\"Suimono\" is a clear Japanese fish soup. No meaning. Just a meme soup... or? Try it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimono_45c920a296.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

