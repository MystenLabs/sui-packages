module 0x5d091b6641a80a48422c646f47f953bd0902c898aa749e232cda8da1c536bd75::icy {
    struct ICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICY>(arg0, 6, b"ICY", b"IcyTower", x"436c696d6220746f2074686520746f70206f662074686520537569206e6574776f726b20776974682049637920546f77657220244943592c200a746865206d656d6520746f6b656e20696e7370697265642062792074686520636c6173736963206172636164652067616d65207768657265206576657279207374657020636f756e747321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icytower_1_ea48fb61da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

