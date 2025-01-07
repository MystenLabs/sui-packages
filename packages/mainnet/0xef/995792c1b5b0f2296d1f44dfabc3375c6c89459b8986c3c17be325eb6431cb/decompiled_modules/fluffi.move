module 0xef995792c1b5b0f2296d1f44dfabc3375c6c89459b8986c3c17be325eb6431cb::fluffi {
    struct FLUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFI>(arg0, 6, b"Fluffi", b"Fluffington", b"You will be experienced infinite meme, infinite fun here at FLUFFINGTON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/green_4f310aa8cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

