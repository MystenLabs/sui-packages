module 0x6097948f98d0bf7ac73135be13dd6c4f1c605023a784eb58020d2c3d3f9b0cc1::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 6, b"Jj", b"Bj", b"Noooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968745613.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

