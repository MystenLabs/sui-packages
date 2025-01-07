module 0x87786254d5e681ec3a1e10ae7e5ffcdae7979c9b373080b6a5a244b259ae098e::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 9, b"PUPU", b"Pupu", b"Pupu To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff6f1df5-81c6-4f69-a181-25234702d018.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

