module 0xae567959fd13da4a7469b881bb403a46cdc6de317b2ed95d52b46315624d69ec::rhensb {
    struct RHENSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHENSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHENSB>(arg0, 9, b"RHENSB", b"hajsn", b"jsnsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f935f081-1183-4c6d-b59b-7c2f70ca992e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHENSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHENSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

