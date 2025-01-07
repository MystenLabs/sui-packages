module 0xde449739c3c811c62ba7138986d6e5e0ff9da4bd589d750c7665ff55b6d7fdeb::ld {
    struct LD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LD>(arg0, 9, b"LD", b"Lost dogs", x"4368c3ba206368c3b320c49169206ce1baa163", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b1e43f5-f5b0-4c6a-9a8d-f7cda527a8b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LD>>(v1);
    }

    // decompiled from Move bytecode v6
}

