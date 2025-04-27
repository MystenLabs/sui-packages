module 0x8197d0f2fa8d520f0748d3e152296aa62b6d55491d6c709b6231154e7e7bdfa9::grokster {
    struct GROKSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKSTER>(arg0, 6, b"GROKSTER", b"Grokster", b"Meet GROKSTER ($GROKSTER)  Born from the depths of meme culture and fueled by pure degen energy, Grokster brings a spirit thats smart, playful, and always ahead of the curve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063016_1be6083005.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROKSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

