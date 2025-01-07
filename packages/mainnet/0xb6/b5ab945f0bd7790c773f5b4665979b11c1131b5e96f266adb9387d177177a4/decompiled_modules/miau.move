module 0xb6b5ab945f0bd7790c773f5b4665979b11c1131b5e96f266adb9387d177177a4::miau {
    struct MIAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAU>(arg0, 9, b"MIAU", b"Cats", b"Miau miau", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9fa2269-24a6-4d37-a00e-c9effdee4e75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

