module 0xfd28e25e3e9f2845440851f8617080cd975ddaeb90ea45ba737cf34d75e42e70::imole {
    struct IMOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMOLE>(arg0, 6, b"IMOLE", b"imolesui", b"Imolesui project to enchance community love ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737185058461.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

