module 0x72f3316cdb0bc54dbe1cf345508ca2dc5acfe272c47204f73346a50e9c372e9d::grap {
    struct GRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAP>(arg0, 6, b"GRAP", b"Graphfo", b"Magnetic forces are no match for Graphfo as he or she knowingly is destined to enter a world that loves meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_cf9ee79644.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

