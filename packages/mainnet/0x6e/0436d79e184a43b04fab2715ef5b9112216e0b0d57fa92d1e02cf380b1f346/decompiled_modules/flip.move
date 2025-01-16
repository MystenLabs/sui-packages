module 0x6e0436d79e184a43b04fab2715ef5b9112216e0b0d57fa92d1e02cf380b1f346::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"Flip Frenzy", x"466c69702c20506c617920616e6420547572626f63686172676520796f75722046756e21204672656e7a7920466c697020697320612067616d6966696564206d656d65636f696e2065636f73797374656d2064657369676e656420666f7220666173742d706163656420636f6d6d756e69747920656e676167656d656e742c206c696768746865617274656420636f6d7065746974696f6e2c20616e642066756e207374616b696e67206d656368616e6963732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1737033911395_a3cd040103.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

