module 0x319f441fe101e1f4026243647b6090dda34f8c101f506811c1657f841d0d2b19::fssb {
    struct FSSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSSB>(arg0, 9, b"FSSB", b"Fasbir", b"it is meme created for sui blockchain users", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ef97dca-7181-4213-a6f6-1a8c9f80531a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

