module 0xee087311959c7008391b2b231900b9cd82ec4847e138e7e91af5f42926640633::jarvis {
    struct JARVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JARVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JARVIS>(arg0, 9, b"JARVIS", b"Jarvis cat", b"Jarviscat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7649b9b-c9c1-4267-a85f-edcf6d2f25e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JARVIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JARVIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

