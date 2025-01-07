module 0x92d20fd1d7d123dc9d41995a5abf41d135afe7074cef91131bdcf38289bd6080::ssa {
    struct SSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSA>(arg0, 9, b"SSA", b"ssa", b"SSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dab40c72-a4db-414e-a37b-ce0b64dcd14f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

