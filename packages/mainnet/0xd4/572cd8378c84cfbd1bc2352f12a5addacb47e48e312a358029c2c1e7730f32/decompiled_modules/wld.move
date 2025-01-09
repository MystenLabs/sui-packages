module 0xd4572cd8378c84cfbd1bc2352f12a5addacb47e48e312a358029c2c1e7730f32::wld {
    struct WLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLD>(arg0, 9, b"WLD", b"Walidun ", b"To change the narrative of sui in sha Allah ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07af1f82-51d7-4920-be6e-d92d946480ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

