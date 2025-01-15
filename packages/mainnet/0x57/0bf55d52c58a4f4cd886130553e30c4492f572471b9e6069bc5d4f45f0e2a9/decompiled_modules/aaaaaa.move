module 0x570bf55d52c58a4f4cd886130553e30c4492f572471b9e6069bc5d4f45f0e2a9::aaaaaa {
    struct AAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAAAAA>(arg0, 6, b"AAAAAA", b"aaaaaaaaaaaaa by SuiAI", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/u_4167002326_3556876529_and_fm_253_and_fmt_auto_and_app_138_and_f_JPEG_ba5903e93e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAAAAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

