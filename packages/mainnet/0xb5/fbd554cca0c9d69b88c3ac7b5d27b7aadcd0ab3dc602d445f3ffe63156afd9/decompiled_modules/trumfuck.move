module 0xb5fbd554cca0c9d69b88c3ac7b5d27b7aadcd0ab3dc602d445f3ffe63156afd9::trumfuck {
    struct TRUMFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMFUCK>(arg0, 6, b"TRUMFUCK", b"fuckmetrump", b"fuck fuck fuck fuck fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731150162005.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

