module 0x8519b4a375b26db9f13da50e22455d59f70727c6ab8126a0aaaca84f7e2f99fb::testi {
    struct TESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTI>(arg0, 6, b"Testi", b"Test meme (dont buy)", b"Testing before we launch a great project without rugpull.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Landwolf_e4de9803f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

