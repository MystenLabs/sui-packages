module 0x916f3d96ac22d98b26179023dd26903eb2b9f8eeb3fe8cac3b960cda224e02f5::godl {
    struct GODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODL>(arg0, 9, b"GODL", b"Gold bum", b"Good ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f80a2236-e273-4381-b89f-6c963ac502b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODL>>(v1);
    }

    // decompiled from Move bytecode v6
}

