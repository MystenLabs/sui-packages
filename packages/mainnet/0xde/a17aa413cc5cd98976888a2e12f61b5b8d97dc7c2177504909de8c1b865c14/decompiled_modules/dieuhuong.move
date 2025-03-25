module 0xdea17aa413cc5cd98976888a2e12f61b5b8d97dc7c2177504909de8c1b865c14::dieuhuong {
    struct DIEUHUONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIEUHUONG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742895490588.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<DIEUHUONG>(arg0, 6, b"dieuhuong", b"dieuhuong", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIEUHUONG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIEUHUONG>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<DIEUHUONG>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIEUHUONG>>(arg0);
    }

    // decompiled from Move bytecode v6
}

