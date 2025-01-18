module 0xa396a44a067c2e785275246129c31ea3721e8621a9061d7df45ec269ec4eed54::mona {
    struct MONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONA>(arg0, 6, b"MONA", b"Mona AI by SuiAI", b"AI Image Generator Create with Mona AI Mona AI is an advanced AI platform designed to generate stunning visuals and assist with creative projects by merging technology with artistry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2191_db01aa23cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

