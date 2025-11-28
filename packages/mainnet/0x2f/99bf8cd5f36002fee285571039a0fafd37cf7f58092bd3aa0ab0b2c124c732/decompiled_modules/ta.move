module 0x2f99bf8cd5f36002fee285571039a0fafd37cf7f58092bd3aa0ab0b2c124c732::ta {
    struct TA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TA>(arg0, 6, b"TA", b"English", b"tesst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764323969599.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

