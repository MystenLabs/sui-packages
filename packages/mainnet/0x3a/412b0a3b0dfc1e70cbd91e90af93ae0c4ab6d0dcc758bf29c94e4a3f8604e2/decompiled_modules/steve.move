module 0x3a412b0a3b0dfc1e70cbd91e90af93ae0c4ab6d0dcc758bf29c94e4a3f8604e2::steve {
    struct STEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVE>(arg0, 6, b"STEVE", b"steve fish", x"5468652022566972616c204c6567656e6422200a4465736372697074696f6e3a2022537465766520746865204669736820282453544556452920697320746865206669727374206c65672d64726976656e206d656d65636f696e206f6e2074686520537569204e6574776f726b2e20496e7370697265642062792074686520766972616c2073656e736174696f6e206372656174656420627920407669677a7669677a20616e642040746f6d6f6d70332c205374657665206973206865726520746f206f7574706163652074686520626561727320776974682068697320756e6e61747572616c6c79206c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1766684876683.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

