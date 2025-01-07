module 0x4256a65f74deb5f43e3a774d564e8330dcb75a4cbbe7001bad5006c10b777d56::flipper {
    struct FLIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPER>(arg0, 6, b"Flipper", b"Flipper on sui", b"There's a new meta in town \"flipper\", your friendly, intelligent dolphin .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29f178da_2db4_4512_a391_bfb7318e006b_1594b6b30a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

