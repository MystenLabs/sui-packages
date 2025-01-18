module 0x3964546b9143657fd1c516614bc2b48b41ec138de0e66a60c179790a3818c340::donaild {
    struct DONAILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONAILD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DONAILD>(arg0, 6, b"DONAILD", b"Donald Trump AI by SuiAI", b"First leader of AI Agents on the free world of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8592_52a1d454ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONAILD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONAILD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

