module 0x9dadabe9b458f4a210ff5f707bd0c6638e1d9aea8694e483e81207567a7dff54::brocc {
    struct BROCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCC>(arg0, 6, b"BROCC", b"Broccoli surfing wave", b"Just a broccoli surfing a wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_cfc7da05f3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

