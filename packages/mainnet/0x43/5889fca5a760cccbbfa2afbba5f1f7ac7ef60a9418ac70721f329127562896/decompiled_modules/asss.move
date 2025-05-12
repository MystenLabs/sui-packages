module 0x435889fca5a760cccbbfa2afbba5f1f7ac7ef60a9418ac70721f329127562896::asss {
    struct ASSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSS>(arg0, 9, b"ASSS", b"AS", b"ASSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/a80b1b28-2e80-4697-9235-fe72bd8f4368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

