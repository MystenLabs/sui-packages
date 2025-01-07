module 0xe84843d998765e6b7c3f69a5d6e1b6ffaa63beec8647a2c074684e9646795b3e::shld {
    struct SHLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHLD>(arg0, 9, b"SHLD", b"Shield", b"Shielem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1eabe517-208a-4b04-8a36-f0136ebcb54b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

