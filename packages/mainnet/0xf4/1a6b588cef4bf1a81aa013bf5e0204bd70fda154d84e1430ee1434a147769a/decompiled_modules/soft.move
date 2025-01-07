module 0xf41a6b588cef4bf1a81aa013bf5e0204bd70fda154d84e1430ee1434a147769a::soft {
    struct SOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFT>(arg0, 9, b"SOFT", b"Tissue", b"tissue is an object that can be used to clean various things such as face, hands and others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/601d35e5-b2c1-455d-bfb0-9af38b70a6aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

