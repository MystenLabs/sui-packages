module 0xe6f1afbd798b835492535f8995575f5dab3c8f3e4e7e20a1b314a0993e816ffe::mcla {
    struct MCLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCLA>(arg0, 6, b"MCLA", b"MINECRAFT LAVA", b"Minecraft Lava, that's about it..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/13914788_oldlava_l_3a8946c67a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

