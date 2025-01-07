module 0x342e807843cef32598e09ffda15a89d069d73e80cc31ddb6635498dca7c7382d::boysui {
    struct BOYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYSUI>(arg0, 6, b"Boysui", b"Boy sui", x"46726f6d206120426f79204b696e67206f66207468652073656120746f206b696e67206f72207375692e20636f6d652072696465207468652077617665732077697468206d652e2e2e2e0a416c6c20736f6369616c732077696c6c20626520637265617465206279204d6f6e6461792c20544720746f646179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_57229e5d4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

