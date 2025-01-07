module 0x165d35cf7afabe0ca33f48972e9f097094f4d1e92ccb2eed8d2e06c258051d71::shibe {
    struct SHIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBE>(arg0, 9, b"SHIBE", b"Shibecoin", b"ShibeCoin (SHIBE) is the new meme coin for dog lovers and meme enthusiasts. With its adorable Shiba Inu mascot and community-driven approach, ShibeCoin is designed to spread joy and fun across the crypto space. HODL for pawsome rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e3e6c3a-e018-4f95-a7d2-65aab211a245.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

