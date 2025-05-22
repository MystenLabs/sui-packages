module 0x4edd982516d4315adab540a4f2f64400f75562d52c7a24bb33441eafa2e5c219::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"E Dog", b"EDOG on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747885487480.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

