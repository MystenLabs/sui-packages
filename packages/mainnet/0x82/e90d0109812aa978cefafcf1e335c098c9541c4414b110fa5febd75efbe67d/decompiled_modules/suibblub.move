module 0x82e90d0109812aa978cefafcf1e335c098c9541c4414b110fa5febd75efbe67d::suibblub {
    struct SUIBBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBBLUB>(arg0, 6, b"SuiBBLUB", b"BABY BLUB", x"f09f8dbce29ca82054686520637574657374206164646974696f6e20746f2074686520537569204e6574776f726b2c20696e737069726564206279207468652062657374206d656d65206f6e20746865206e6574776f726b2120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074280263.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBBLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBBLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

