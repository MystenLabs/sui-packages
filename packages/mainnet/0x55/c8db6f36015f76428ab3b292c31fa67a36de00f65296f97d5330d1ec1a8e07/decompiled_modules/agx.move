module 0x55c8db6f36015f76428ab3b292c31fa67a36de00f65296f97d5330d1ec1a8e07::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGX>(arg0, 9, b"AGX", b"Agapeonx", b"community driven ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df1dc1b8-a5f7-47b4-a458-b358348a16a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

