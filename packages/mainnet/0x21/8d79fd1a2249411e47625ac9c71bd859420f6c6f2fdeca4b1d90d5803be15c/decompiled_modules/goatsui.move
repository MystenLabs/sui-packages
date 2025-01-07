module 0x218d79fd1a2249411e47625ac9c71bd859420f6c6f2fdeca4b1d90d5803be15c::goatsui {
    struct GOATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATSUI>(arg0, 6, b"GOATSUI", b"GOATSEUS MAXISUI", b"https://t.me/goatseusmaxisui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_08_36_07_f3d08cdffa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

