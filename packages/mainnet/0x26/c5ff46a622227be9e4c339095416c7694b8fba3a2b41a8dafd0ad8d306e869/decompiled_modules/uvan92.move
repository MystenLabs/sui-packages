module 0x26c5ff46a622227be9e4c339095416c7694b8fba3a2b41a8dafd0ad8d306e869::uvan92 {
    struct UVAN92 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UVAN92, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UVAN92>(arg0, 9, b"UVAN92", b"UVwewe", b"Loading, up, rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9574e8e8-4f50-4a06-9ff1-a5d7e66da2ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UVAN92>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UVAN92>>(v1);
    }

    // decompiled from Move bytecode v6
}

