module 0xd44ff1f3f45173cf8e848f81f1af08e71bde748393a9b86679c3d989d04ecc4d::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"STOP BUY SHIT", b"Stop buying SHIT - You don't need", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/08d93023_92e3_4283_9440_69f1d1acb3e2_aff2d4fc89.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

