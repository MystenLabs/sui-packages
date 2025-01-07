module 0x1c14f6f7867b269113f37536528084dabfb90c5747393d5cf9f21f09d07c3004::dgtu {
    struct DGTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTU>(arg0, 6, b"DGTU", b"DogTongue Sui", b"let's stick out your tongue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000528_77b2af27be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGTU>>(v1);
    }

    // decompiled from Move bytecode v6
}

