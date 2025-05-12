module 0x1b6f4b9ad1a684870d081c8d78962d9545b9090cd87b8a23cffc31ae71f39fc6::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 9, b"ASSS", b"ASS", b"ASSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/1c4460a9-6054-4b53-820d-c59c6e7fbebb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

