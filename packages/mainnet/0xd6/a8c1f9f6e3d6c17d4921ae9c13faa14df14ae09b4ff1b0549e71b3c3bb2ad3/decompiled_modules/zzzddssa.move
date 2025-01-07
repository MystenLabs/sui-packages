module 0xd6a8c1f9f6e3d6c17d4921ae9c13faa14df14ae09b4ff1b0549e71b3c3bb2ad3::zzzddssa {
    struct ZZZDDSSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZDDSSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZDDSSA>(arg0, 9, b"ZZZDDSSA", b"erfabnnn", b"memefi coin this is a coin based on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b40f5a4-02d3-471f-ad60-40746a6963ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZDDSSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZDDSSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

