module 0x1e189c310407c681b8190bd41d122fdddd8863e1c35434c38e925e0a23afafde::qrt {
    struct QRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QRT>(arg0, 6, b"QRT", b"QRT by SuiAI", b"QRT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_14_3954e8bec6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QRT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

