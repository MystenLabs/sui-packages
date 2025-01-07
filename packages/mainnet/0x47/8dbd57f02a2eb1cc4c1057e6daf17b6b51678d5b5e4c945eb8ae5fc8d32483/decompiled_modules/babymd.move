module 0x478dbd57f02a2eb1cc4c1057e6daf17b6b51678d5b5e4c945eb8ae5fc8d32483::babymd {
    struct BABYMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMD>(arg0, 6, b"BabyMD", b"BabyMooDeng", b"Baby Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4009_cdc57b5a0e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

