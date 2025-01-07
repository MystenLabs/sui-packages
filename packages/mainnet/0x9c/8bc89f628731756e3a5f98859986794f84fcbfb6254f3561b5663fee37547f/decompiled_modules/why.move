module 0x9c8bc89f628731756e3a5f98859986794f84fcbfb6254f3561b5663fee37547f::why {
    struct WHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHY>(arg0, 9, b"WHY", b"Xz", b"Xz WhY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1c8a3de-66b1-47e5-ba57-425be868c107.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

