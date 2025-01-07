module 0x73c0c74ce4bf1fc8fee1ed751e908e70c8e0c25a9662eb3886d2c9d512a6b497::bears {
    struct BEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARS>(arg0, 6, b"BEARS", b"Sui Bears", b"#SuiBear Building the Bear World Metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9583_e804234b27.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

