module 0x2db2c6de5e0d6b7beedd68905f5a25b11db7a45aaaa089086800555e1a4c984d::njw {
    struct NJW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJW>(arg0, 9, b"NJW", b"Najwas", b"Family token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce2d500f-eb40-44ed-8f67-d3fefe12e857.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJW>>(v1);
    }

    // decompiled from Move bytecode v6
}

