module 0xe9938af1ced4d68a76daa0f9404fb3ff854204bb21e9ececb197e116cc73981d::qoka {
    struct QOKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QOKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QOKA>(arg0, 6, b"QOKA", b"QOKA", b"@suilaunchcoin @SuiAIFun What a time to be alive on SUI!  @suilaunchcoin $QOKA + QOKA https://t.co/SXZYl2nkSO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/qoka-az8n4x.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QOKA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QOKA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

