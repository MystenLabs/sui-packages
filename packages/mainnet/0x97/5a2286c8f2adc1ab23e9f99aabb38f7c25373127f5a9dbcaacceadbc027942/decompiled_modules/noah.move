module 0x975a2286c8f2adc1ab23e9f99aabb38f7c25373127f5a9dbcaacceadbc027942::noah {
    struct NOAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOAH>(arg0, 6, b"NOAH", b"Noah on Sui", b"If you like Chailaxxing, then noah is guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091412_4cfb06646a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

