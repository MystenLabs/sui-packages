module 0x833caf0857a4e2163cda66fdd72d202ba9de92ea35c44c97c78293a4a9d86328::grm {
    struct GRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRM>(arg0, 9, b"GRM", b"german", b"bringing a touch of German ingenuity and reliability to your portfolio's profits ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75e7ff6f-222c-41f7-aca3-ddcdd2d686f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

