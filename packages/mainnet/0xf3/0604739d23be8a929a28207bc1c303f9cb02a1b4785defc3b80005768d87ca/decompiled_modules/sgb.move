module 0xf30604739d23be8a929a28207bc1c303f9cb02a1b4785defc3b80005768d87ca::sgb {
    struct SGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGB>(arg0, 9, b"SGB", b"RG", b"CV ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9665572-1651-4692-9a3c-bff182e6d620.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

