module 0x5eb750ef083f9f4827275480d59b0f38660a625598db09fb3c7c3872a394d602::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"YodaToken", b"yoda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yoda_avarta_d6d18e1c43.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

