module 0x9a33a36d93c463a6b3c7771891e4bd1f14f103a4c2cc958b745111bd65bcb5a0::bblub {
    struct BBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLUB>(arg0, 6, b"Bblub", b"Boss Blub", b"No meme does it like the BOSSBLUB. Hell show what makes a great meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4820a097_0e78_4c00_8b17_88dcee273cf3_344985265f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

