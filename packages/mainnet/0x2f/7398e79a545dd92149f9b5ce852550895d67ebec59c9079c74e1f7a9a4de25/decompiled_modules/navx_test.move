module 0x2f7398e79a545dd92149f9b5ce852550895d67ebec59c9079c74e1f7a9a4de25::navx_test {
    struct NAVX_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVX_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVX_TEST>(arg0, 9, b"NAVX_TEST", b"NAVX Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAVX_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVX_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVX_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

