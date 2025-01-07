module 0x72745784d9f81b7d5c079caa889ce17762ef83e1deacbe65cb422b3d1a515c4e::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"Splash", b"Splo", b"Splo, the degenerate tadpole, is a reckless little creature with a love for gambling. Always swimming through chaos, he's obsessed with the thrill of betting and drinks the infamous sui water for fun. Splo lives for the rush, His tiny form might look harmless, but behind those wide eyes lies a wild heart ready to go all-in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Splo_25a94e5c44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

