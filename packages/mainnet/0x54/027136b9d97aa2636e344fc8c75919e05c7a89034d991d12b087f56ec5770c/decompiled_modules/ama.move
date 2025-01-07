module 0x54027136b9d97aa2636e344fc8c75919e05c7a89034d991d12b087f56ec5770c::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Opa", x"c38a6a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5dc9ee0-0e7d-4c64-9f4d-a1ae14ba1ff5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

