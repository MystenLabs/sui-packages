module 0x304f189f0084bc47966c551b5ace828eaf0f1ec48cd9ee11f067d15be7bab503::suijt {
    struct SUIJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJT>(arg0, 6, b"SUIJT", b"Super Unusual Individual, Just Thriving", b"Super Unusual Individual, Just Thriving!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_02_56_51_245d9816cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

