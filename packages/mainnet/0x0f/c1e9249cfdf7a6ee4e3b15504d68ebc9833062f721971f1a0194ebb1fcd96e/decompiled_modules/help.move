module 0xfc1e9249cfdf7a6ee4e3b15504d68ebc9833062f721971f1a0194ebb1fcd96e::help {
    struct HELP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELP>(arg0, 9, b"HELP", b"Help me", b"This is meme coin created on sui network so we want to power sui network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be08f2b7-cae9-4c0b-b936-1cc7d5451a60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELP>>(v1);
    }

    // decompiled from Move bytecode v6
}

