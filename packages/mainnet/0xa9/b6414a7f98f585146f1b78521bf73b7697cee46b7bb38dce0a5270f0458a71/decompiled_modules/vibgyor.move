module 0xa9b6414a7f98f585146f1b78521bf73b7697cee46b7bb38dce0a5270f0458a71::vibgyor {
    struct VIBGYOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBGYOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBGYOR>(arg0, 6, b"VIBGYOR", b"VIBGYOR on Sui", b"Blue on Base? Blue is Sui. Fuck it. VIBGYOR on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prism_vibgyor_5b7e17cfa6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBGYOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBGYOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

