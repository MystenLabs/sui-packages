module 0x4452890d9efcce2ca3407cb250ee019f339884033dcd6aa3fc3926a0c9018ff6::pefu {
    struct PEFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFU>(arg0, 6, b"Pefu", b"Pepe Safu", b"Pepe Safu Your Fund For Guaranted Investment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732850263450.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

