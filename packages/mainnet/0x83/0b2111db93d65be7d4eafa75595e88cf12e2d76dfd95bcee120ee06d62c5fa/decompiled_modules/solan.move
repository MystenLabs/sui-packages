module 0x830b2111db93d65be7d4eafa75595e88cf12e2d76dfd95bcee120ee06d62c5fa::solan {
    struct SOLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAN>(arg0, 6, b"SOLAN", b"Sui Dolan", x"476f6f627920747269656420746f20737465657220746568207368697020616e642062652063707461696e206275742068657a206469656420756e646572206d7973746572696f75732063697263756d7374616e6365732e2020446f6c616e20697a2064652063707461696e206f6e202353554920616e6420234d6f766550756d7020206e6f772e0a0a54656c656772616d3a2068747470733a2f2f742e6d652f696d646f6c616e5f7375690a583a2068747470733a2f2f782e636f6d2f696d646f6c616e5f7375690a5765623a2068747470733a2f2f696d646f6c616e2e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dolan_logo_ea3fd28fff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

