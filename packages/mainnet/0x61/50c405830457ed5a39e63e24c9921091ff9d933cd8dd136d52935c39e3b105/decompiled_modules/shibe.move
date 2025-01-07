module 0x6150c405830457ed5a39e63e24c9921091ff9d933cd8dd136d52935c39e3b105::shibe {
    struct SHIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBE>(arg0, 9, b"SHIBE", b"SHIBEcoin", b"ShibeCoin (SHIBE) is the new meme coin for dog lovers and meme enthusiasts. With its adorable Shiba Inu mascot and community-driven approach, ShibeCoin is designed to spread joy and fun across the crypto space. HODL for pawsome rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7a2571b-9587-405a-9884-3b7b45eed72b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

