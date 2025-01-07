module 0xb4a1fd4a1b0bcf0e54edffaf8bc136c5b0381a233e0dcc5ceb88a968562d291c::ykcir {
    struct YKCIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YKCIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YKCIR>(arg0, 6, b"YKCIR", b"Never Gon Never Will", b"I won't, I promise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732784449151.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YKCIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YKCIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

