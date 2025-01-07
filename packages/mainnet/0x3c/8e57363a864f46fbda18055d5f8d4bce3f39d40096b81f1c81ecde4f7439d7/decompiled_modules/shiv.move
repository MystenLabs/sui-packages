module 0x3c8e57363a864f46fbda18055d5f8d4bce3f39d40096b81f1c81ecde4f7439d7::shiv {
    struct SHIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIV>(arg0, 9, b"SHIV", b"Shiva", b"Utility and digital asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fde8edc-ed2e-4cef-a4b0-5e7e3d867531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

