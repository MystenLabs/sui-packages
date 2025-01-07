module 0xb715bb03627f111e37c3a13aa5e21c2e6488b763ea0e888bad4bdcfcda77b386::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"DUCKY", b"Rubber Ducky Cult", x"527562626572204475636b792043756c742069732054484520424947474553542063756c7420696e2074686520736563746f722c206e6576657220666f72676574206974210a54686973204475636b7920465558", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008651_083b257e77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

