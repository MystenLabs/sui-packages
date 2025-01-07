module 0x68322509e8f45e629c3140a26526fd4ce829adb90f942d98b1516902e710b0c5::penny {
    struct PENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENNY>(arg0, 6, b"PENNY", b"SUI PENNY", b"FIRST SUI PENNY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8752_penny_1c4f5bfec3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

