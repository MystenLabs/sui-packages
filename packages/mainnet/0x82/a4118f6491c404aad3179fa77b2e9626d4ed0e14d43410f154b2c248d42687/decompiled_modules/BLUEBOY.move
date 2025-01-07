module 0x82a4118f6491c404aad3179fa77b2e9626d4ed0e14d43410f154b2c248d42687::BLUEBOY {
    struct BLUEBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBOY>(arg0, 9, b"BLUEBOY", b"BLUEBOY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEBOY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLUEBOY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEBOY>>(0x2::coin::mint<BLUEBOY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

