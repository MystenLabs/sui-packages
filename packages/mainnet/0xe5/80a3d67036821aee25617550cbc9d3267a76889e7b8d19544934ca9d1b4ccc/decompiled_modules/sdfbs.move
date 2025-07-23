module 0xe580a3d67036821aee25617550cbc9d3267a76889e7b8d19544934ca9d1b4ccc::sdfbs {
    struct SDFBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFBS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDFBS>(arg0, 6, b"SDFBS", b"HFOIHFWEF", b"@suilaunchcoin $SDFBS + HFOIHFWEF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sdfbs-k16ig1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDFBS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFBS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

