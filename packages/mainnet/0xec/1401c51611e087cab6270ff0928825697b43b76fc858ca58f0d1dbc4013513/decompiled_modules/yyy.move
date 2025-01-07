module 0xec1401c51611e087cab6270ff0928825697b43b76fc858ca58f0d1dbc4013513::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 6, b"YYY", b"yyy", b"This is YYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_3f3d5146cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

