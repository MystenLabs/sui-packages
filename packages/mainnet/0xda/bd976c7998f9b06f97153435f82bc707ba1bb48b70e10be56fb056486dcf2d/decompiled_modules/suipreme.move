module 0xdabd976c7998f9b06f97153435f82bc707ba1bb48b70e10be56fb056486dcf2d::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"SUIPREME", b"Suipreme", x"5355495052454d452069732061206d656d6520746f6b656e20636f6d62696e696e67207468652068797065206f662053757072656d6520776974682074686520706f776572206f66205355492e204578636c75736976652c2066756e2c20616e6420666f72207468652063756c747572657065726665637420666f72207374726565747765617220616e642063727970746f206c6f76657273210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/assd_31895daab9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

