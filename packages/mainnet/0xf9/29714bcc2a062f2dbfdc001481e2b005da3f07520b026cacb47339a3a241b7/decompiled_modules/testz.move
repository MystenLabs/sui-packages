module 0xf929714bcc2a062f2dbfdc001481e2b005da3f07520b026cacb47339a3a241b7::testz {
    struct TESTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTZ>(arg0, 6, b"TESTZ", b"testz by SuiAI", b"testz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Capture_7a059a9158.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

