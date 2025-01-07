module 0x411fda9dd56ea8d6a77ad72757518e82f6d8a8126ee0e6028a7b0f2e1bd0ca30::dixie {
    struct DIXIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIXIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIXIE>(arg0, 6, b"DIXIE", b"Dixie The Dolphin", x"492070726573656e7420746f20796f753a205468652054616c65206f66204469786965210a0a5468697320616e696d6174696f6e2069732074686520657373656e6365206f6620776861742077652061726520747279696e6720746f206275696c6420696e20612066756e20616e64206372656174697665207761792120536f206d616e79206d6f7265207468696e677320696e2074686520706970656c696e652c20736f20737461792074756e65642120244449584945", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dixie_d1d0b80550.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIXIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIXIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

