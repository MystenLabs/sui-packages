module 0x848bfc63fd31ff6f473ca0ba5f9615c8d89c8c6b57952ac4f9f7f9fe264823cb::calm {
    struct CALM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALM>(arg0, 6, b"CALM", b"TRANQUILITY", x"42452e2043414c4d2e0a0a425245415448452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_000473095392_gx1j2g_t500x500_6396af177a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CALM>>(v1);
    }

    // decompiled from Move bytecode v6
}

