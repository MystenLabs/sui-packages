module 0x36c8443faf908f30ffda5d9ad1f4367f0eb2819b8dab4a2c9e5e124bc1cb33b0::sbr {
    struct SBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBR>(arg0, 9, b"SBR", b"Ssoberry ", b"I like ssoberry ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e3fb5c77-6b5d-4f05-bc67-4486e036e81b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

