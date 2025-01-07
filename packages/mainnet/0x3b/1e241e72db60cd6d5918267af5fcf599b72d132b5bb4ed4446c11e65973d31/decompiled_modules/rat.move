module 0x3b1e241e72db60cd6d5918267af5fcf599b72d132b5bb4ed4446c11e65973d31::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 6, b"RAT", b"SUIRAT", b"SUIRAT is a captivating memecoin making waves in the crypto world. With a vibrant community and growth potential, it's accessible and relatable. Join the SUIRAT revolution and be part of something special.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_13_47_10_37d17ab145.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

