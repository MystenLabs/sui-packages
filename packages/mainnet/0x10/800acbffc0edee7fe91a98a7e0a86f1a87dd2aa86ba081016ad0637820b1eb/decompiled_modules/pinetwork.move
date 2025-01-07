module 0x10800acbffc0edee7fe91a98a7e0a86f1a87dd2aa86ba081016ad0637820b1eb::pinetwork {
    struct PINETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINETWORK>(arg0, 9, b"PINETWORK", b"Pi Network", x"50692069732061206e6577206469676974616c2063757272656e63792e20546869732061707020616c6c6f777320796f7520746f2061636365737320616e642067726f7720796f757220506920686f6c64696e677320616e64207365727665732061732077616c6c657420746f20686f737420796f7572206469676974616c206173736574732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/966f55e6-14c7-48b2-923d-6b16069fc0cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINETWORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

