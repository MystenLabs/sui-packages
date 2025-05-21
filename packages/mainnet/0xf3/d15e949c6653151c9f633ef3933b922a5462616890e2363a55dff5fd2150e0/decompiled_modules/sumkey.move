module 0xf3d15e949c6653151c9f633ef3933b922a5462616890e2363a55dff5fd2150e0::sumkey {
    struct SUMKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMKEY>(arg0, 9, b"SUMKEY", b"SuiMonkey", b"Just Rainbow Monkey ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/976965aaae69350b4adcb6356bf97cbablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

