module 0x89719335c35daa43b24cb696fc08fc2c5b804f6471eb289945ee0163393bc272::masew {
    struct MASEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASEW>(arg0, 6, b"MaSew", b"Sew", b"Sew on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/98542cdf9f5242db2a65d8e275c1c205_4f50d7cc31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

