module 0x2efc63ae044c4295895888be544b2ee8b98ea328f6873718cbddd5b7bb584708::ngaceng {
    struct NGACENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGACENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGACENG>(arg0, 6, b"NGACENG", b"NGACENGAN", b"NGACENGCOLINGACENGCOLI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6299_33c99dd4c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGACENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGACENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

