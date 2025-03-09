module 0xdcc8ded22623a9de3b2f055068131bbcc7a0a87a061767caa0a20ceee40608f3::zard {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARD>(arg0, 6, b"ZARD", b"SUIZARD", b"SUI ZARD THE KING OF MEME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cattura_62e224cfb4.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

