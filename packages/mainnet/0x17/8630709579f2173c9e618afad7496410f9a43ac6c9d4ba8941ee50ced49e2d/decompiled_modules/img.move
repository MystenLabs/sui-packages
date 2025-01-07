module 0x178630709579f2173c9e618afad7496410f9a43ac6c9d4ba8941ee50ced49e2d::img {
    struct IMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IMG>(arg0, 6, b"IMG", b"ImageCoin by SuiAI", b"The scalable decentralized digital currency shaping the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4890dcdc_2676_437a_afff_b02625f41262_f31f9cb3d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IMG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

