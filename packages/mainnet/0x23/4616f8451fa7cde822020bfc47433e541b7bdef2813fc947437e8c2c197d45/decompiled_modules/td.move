module 0x234616f8451fa7cde822020bfc47433e541b7bdef2813fc947437e8c2c197d45::td {
    struct TD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD>(arg0, 6, b"TD", b"Big Red", x"5468652042696720526564206973206865726520746f2073686f77206f757220617070726563696174696f6e20746f2074686f73652077686f20737570706f727420696e6e6f766174696f6e20696e207468652063727970746f20776f726c642e205768656e207468652053554920434f20666f756e64657273207765726520696e63756261746564206279204d797374656e204c6162732c20746865792063726561746564206f6e65206f6620746865206d6f7374207363616c61626c652c2072656c6961626c652c20616e64206661737420626c6f636b636861696e206e6574776f726b732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Lg_Uh_Zc_O_400x400_cb4c437cde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TD>>(v1);
    }

    // decompiled from Move bytecode v6
}

