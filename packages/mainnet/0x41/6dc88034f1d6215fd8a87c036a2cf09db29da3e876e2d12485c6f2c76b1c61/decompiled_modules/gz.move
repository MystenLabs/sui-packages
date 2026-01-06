module 0x416dc88034f1d6215fd8a87c036a2cf09db29da3e876e2d12485c6f2c76b1c61::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZ>(arg0, 6, b"GZ", b"General Zwe", b"General Zwe is an academic from multiple institutions majoring in Graphic design and motion graphics. During the covid he lost his job, but that did not settle him... he dedicated himself to finding knowledge in crypto. For 4 years full he trained.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1767687155897.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

