module 0xdace33348a8397f7af1da701a3895d2deebc2130bf9d391a15c6eaef40e5e252::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"Cock", b"COCK", b"cockkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950345381.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

