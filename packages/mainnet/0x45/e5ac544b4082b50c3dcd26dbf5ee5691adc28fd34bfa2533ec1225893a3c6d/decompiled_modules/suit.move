module 0x45e5ac544b4082b50c3dcd26dbf5ee5691adc28fd34bfa2533ec1225893a3c6d::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"Suit", b"Suit up", x"f09f9aa82053756974205570202d20546865204e65772042756c6c697368204d656d65206f6e205375692120f09f9aa80a0a4765742072656164792c20666f6c6b732120546865726527732061206e6577206d656d6520696e20746f776e206f6e207468652053756920626c6f636b636861696e2c20616e64206974277320616c6c2061626f75742074616b696e6720636f6e74726f6c206f6620746865206d61726b65742077697468207374796c652120496e74726f647563696e6720225375697420557022202d20776865726520796f7520646f6e2774206a75737420706c617920746865206d61726b65742c20796f7520646f6d696e61746520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736018356328.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

