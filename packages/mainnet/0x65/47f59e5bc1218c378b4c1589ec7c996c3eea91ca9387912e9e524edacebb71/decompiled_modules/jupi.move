module 0x6547f59e5bc1218c378b4c1589ec7c996c3eea91ca9387912e9e524edacebb71::jupi {
    struct JUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUPI>(arg0, 6, b"JUPI", b"Sui JupiMoon", b"Memecoin on sui --- Comunity-driven fun, and memes. Join us for laughs, rewards, and whole lot of good vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028489_4cc0222474.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

