module 0xb6618debe65795bf0ecd5373eec3ab74d38e26742c1b0817c8b00896d2cb7150::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 6, b"LEMON", b"Lemon", x"54686520576f726c64e2809973204d6f73742052656672657368696e676c7920506f696e746c65737320535549204d656d6520436f696e210a4c6966652063616e20626520736f75722c207468726f77696e67207573206c656d6f6e732077652063616ee2809974206576656e207475726e20696e746f206d6172676172697461732e20427574206174204c454d4f4e2c207765e28099726520616c6c2061626f7574207475726e696e672074686f736520736f7572206d6f6d656e747320696e746f20736f6d657468696e6720676f6c64656e20746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731903121855.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

