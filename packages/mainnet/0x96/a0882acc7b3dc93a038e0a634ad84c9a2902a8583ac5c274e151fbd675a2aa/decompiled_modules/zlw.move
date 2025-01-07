module 0x96a0882acc7b3dc93a038e0a634ad84c9a2902a8583ac5c274e151fbd675a2aa::zlw {
    struct ZLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZLW>(arg0, 9, b"ZLW", b"Bash", b"To used memecoins for social interactions ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee1325df-f8b9-4a25-94e8-3c4f630eff97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

