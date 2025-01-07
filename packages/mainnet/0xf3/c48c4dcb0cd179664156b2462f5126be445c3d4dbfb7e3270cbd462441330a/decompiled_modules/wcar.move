module 0xf3c48c4dcb0cd179664156b2462f5126be445c3d4dbfb7e3270cbd462441330a::wcar {
    struct WCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAR>(arg0, 9, b"WCAR", b"white car", b"Fascinating stories about iconic cars and racing legends, and a passionate community of car enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b849c65-8c78-4064-af91-4cf26b9064af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

