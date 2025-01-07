module 0xc1ad277f37bb2864d694904552acabc51a820fb7795008f1bd157904a53a42c8::brettlost {
    struct BRETTLOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTLOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTLOST>(arg0, 6, b"BrettLost", b"Brett Lost", b"Brett trending ape lost on meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOST_432a3dc627.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTLOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTLOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

