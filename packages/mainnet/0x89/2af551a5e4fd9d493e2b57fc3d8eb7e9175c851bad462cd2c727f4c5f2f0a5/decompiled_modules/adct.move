module 0x892af551a5e4fd9d493e2b57fc3d8eb7e9175c851bad462cd2c727f4c5f2f0a5::adct {
    struct ADCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADCT>(arg0, 6, b"ADCT", b"Adickted", b"Just a bored dick next to a withered tree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/a3b1fb53-64fe-4b6c-bc9e-654827b73f76.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

