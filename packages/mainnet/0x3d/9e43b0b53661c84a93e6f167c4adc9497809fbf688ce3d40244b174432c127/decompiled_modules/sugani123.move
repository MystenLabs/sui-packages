module 0x3d9e43b0b53661c84a93e6f167c4adc9497809fbf688ce3d40244b174432c127::sugani123 {
    struct SUGANI123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGANI123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGANI123>(arg0, 9, b"SUGANI123", b"Sgani", b"Just a meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/475764fd-b8e1-4369-b0a7-7e2e97332497.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGANI123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUGANI123>>(v1);
    }

    // decompiled from Move bytecode v6
}

