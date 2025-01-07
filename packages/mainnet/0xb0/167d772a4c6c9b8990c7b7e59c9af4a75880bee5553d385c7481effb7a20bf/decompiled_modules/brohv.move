module 0xb0167d772a4c6c9b8990c7b7e59c9af4a75880bee5553d385c7481effb7a20bf::brohv {
    struct BROHV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROHV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROHV>(arg0, 6, b"BROHV", b"Virtual BRO HUGS", b"$BROHV is a meme coin with no intrinsic value or expectation of financial return. The coin is completely useless and for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3_640b1452d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROHV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROHV>>(v1);
    }

    // decompiled from Move bytecode v6
}

