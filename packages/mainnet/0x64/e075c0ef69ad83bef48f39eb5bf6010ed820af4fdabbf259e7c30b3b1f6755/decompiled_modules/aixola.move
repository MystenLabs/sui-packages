module 0x64e075c0ef69ad83bef48f39eb5bf6010ed820af4fdabbf259e7c30b3b1f6755::aixola {
    struct AIXOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXOLA>(arg0, 6, b"AIXOLA", b"AIXOLA by SuiAI", b"Meet AIXOLA, the most lovable and futuristic amphibian on SUI. A unique blend of nature and AI magic that brings personality, charm, and endless creativity to your digital world. Imagine a multiverse teeming with life, called the Aixoluniverse, where amphibians like AIXOLA are not just cute but also pioneers of a new era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1735_cb11decc30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXOLA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXOLA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

