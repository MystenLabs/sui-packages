module 0x72348f0270bdd9feaa3bde55351976dae74d9bee8503aa16dd2a291726ac32dc::crocodeng {
    struct CROCODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCODENG>(arg0, 6, b"CROCODENG", b"Crocodeng", b"Stay cute, stay confident, and make magic happen!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_1_d7c63d0c99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

