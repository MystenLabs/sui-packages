module 0x181a86377de4bf25919e7b8c0faa1555d2ac8547d50d1381a589eb4ab5e7e56b::sxm {
    struct SXM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXM>(arg0, 6, b"SXM", b"SUIXMAS", b"The Sui santa token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733653301747.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SXM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

