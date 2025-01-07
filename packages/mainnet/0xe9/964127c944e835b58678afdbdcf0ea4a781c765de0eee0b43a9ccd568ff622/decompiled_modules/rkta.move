module 0xe9964127c944e835b58678afdbdcf0ea4a781c765de0eee0b43a9ccd568ff622::rkta {
    struct RKTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKTA>(arg0, 6, b"RKTA", b"Rocketa", b"Rocketa Token (RKTA) es una divertida memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/undefined_image_8_1058330397.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

