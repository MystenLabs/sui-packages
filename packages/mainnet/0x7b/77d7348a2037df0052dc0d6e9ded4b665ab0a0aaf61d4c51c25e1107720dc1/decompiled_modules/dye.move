module 0x7b77d7348a2037df0052dc0d6e9ded4b665ab0a0aaf61d4c51c25e1107720dc1::dye {
    struct DYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYE>(arg0, 9, b"DYE", b"Death", x"4368696c6c20616e642066756e20f09f9180", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40fbd46e-e7f9-4765-94aa-9d4d090a787e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

