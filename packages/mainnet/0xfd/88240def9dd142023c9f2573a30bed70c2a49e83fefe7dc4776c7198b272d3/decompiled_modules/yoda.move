module 0xfd88240def9dd142023c9f2573a30bed70c2a49e83fefe7dc4776c7198b272d3::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"YODA sui", b"Yoda's cuteness got me excited", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9fe70df4_df72_4c54_a0f3_fd0a915aa305_c8ff6c0d24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

