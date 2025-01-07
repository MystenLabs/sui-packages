module 0xa98c3d9765d0f3da324d1629ac8b97f9f9b958cd77611530dc6bc5a56c3c0623::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 9, b"KIKI", b"KikiFlaminki", x"f09fa6a9204b696b6920466c616d696e6b6920f09fa6a9e280942054686520686f7474657374206e6577206d656d6520636f696e2053554921212020f09f928e205374616b6520796f7572204b494b49206f6e204c6f636b79466920746f206561726e20757020746f203134252072657761726473212020f09f9a80204a6f696e2074686520466c616d696e6b69204672656e7a7920616e642074616b6520666c69676874207769746820757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xc849418f46a25d302f55d25c40a82c99404e5245.png?size=xl&key=36301c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIKI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

