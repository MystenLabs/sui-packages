module 0x9291fd40c5f544b8655090c4da154625154a1a42b1aec8b322c38166208394f4::fps {
    struct FPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FPS>(arg0, 6, b"FPS", b"FuckPresales", b"@suilaunchcoin $FPS + FuckPresales https://t.co/PkuANqnM2L", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/fps-0lni5o.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FPS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

