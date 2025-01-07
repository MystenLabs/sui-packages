module 0x27ee8d4eb3c20f931f561e4556e93f6e17c077da11b7f4d7b996c52803d3984d::milton {
    struct MILTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILTON>(arg0, 6, b"Milton", b"Hurricane Milton", x"546865204c617374205355492062656e646572204d696c746f6e2e0a0a2d2054656c656772616d202f2057656273697465202f2058200a2d2d3e2057696c6c2062652075702061742044455820746f2061766f69642062756c6c7368697420616e64206675642e0a0a4d696c746f6e69616972", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035566_7be9bb1d0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

