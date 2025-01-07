module 0xb5da6d307e8cdee1432c8ea0a56e410b28ecad150a341151b577f51c84dc75dd::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"Larry", b"Indo Official Cat", b"Indonesia Official Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732283032456.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

