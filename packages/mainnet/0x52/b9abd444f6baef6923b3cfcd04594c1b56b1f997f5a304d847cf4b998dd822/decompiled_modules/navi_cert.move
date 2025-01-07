module 0x52b9abd444f6baef6923b3cfcd04594c1b56b1f997f5a304d847cf4b998dd822::navi_cert {
    struct NAVI_CERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVI_CERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVI_CERT>(arg0, 9, b"NAVI_CERT", b"NAVI_CERT", b"NAVI Protocol Token Certificate", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAVI_CERT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVI_CERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAVI_CERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

