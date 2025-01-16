module 0xd0337606569674159794516cd2e3f0bf55dff16d59339ea35349eb4a4af266db::koco {
    struct KOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOCO>(arg0, 9, b"KOCO", b"Huybim", b"Lam de biet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d405881-fab4-4f5a-accc-e4dcbdd8b064.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

