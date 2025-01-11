module 0xf47ebea1a51fe9802d530979a92d8fd4837cbbf159fdcc9b01fde4b08c6de6db::secondv {
    struct SECONDV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECONDV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECONDV>(arg0, 6, b"SecondV", b"Second Victory", x"4a6f696e20746865207265766f6c7574696f6e2077697468205472756d70205365636f6e6420566963746f7279210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736600190710.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECONDV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECONDV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

