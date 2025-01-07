module 0xfe43a478ce6fe758224e0563e75eadd9d764e62398b848649961f7036157ed69::she {
    struct SHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHE>(arg0, 9, b"SHE", b"Shehu", b"Shetoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47d55247-f378-41a8-a0aa-a39eaa8184c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

