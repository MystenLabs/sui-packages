module 0x383ece02713ae3a8ca0d2f3f1b4a87e83302fc654d4985d85783fb30515cd2a6::rfgf {
    struct RFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFGF>(arg0, 6, b"rfgf", b"fdcfvg", b"rfevg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RFGF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFGF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

