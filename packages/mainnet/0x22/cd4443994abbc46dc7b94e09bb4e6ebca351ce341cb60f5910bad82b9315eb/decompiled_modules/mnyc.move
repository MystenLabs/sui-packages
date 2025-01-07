module 0x22cd4443994abbc46dc7b94e09bb4e6ebca351ce341cb60f5910bad82b9315eb::mnyc {
    struct MNYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNYC>(arg0, 6, b"Mnyc", b"Mannycoin", b"Just a fan token of a good man. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_13_63a3edd479.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

