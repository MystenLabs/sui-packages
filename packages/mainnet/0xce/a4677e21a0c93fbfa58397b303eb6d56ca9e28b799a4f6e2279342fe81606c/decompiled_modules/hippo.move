module 0xcea4677e21a0c93fbfa58397b303eb6d56ca9e28b799a4f6e2279342fe81606c::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"Hippo", b"Hippo Hippo", b"Hippo Hippo is a transparent meme coin project that focuses first and foremost on building a long-term community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28828c23b2ea628d407fa5985cb837e1_63eadd8e2e_0737dfda72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

