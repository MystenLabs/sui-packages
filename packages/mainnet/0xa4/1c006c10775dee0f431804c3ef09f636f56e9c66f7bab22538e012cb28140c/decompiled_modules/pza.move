module 0xa41c006c10775dee0f431804c3ef09f636f56e9c66f7bab22538e012cb28140c::pza {
    struct PZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZA>(arg0, 9, b"PZA", b"PizzaCoin", x"5361746973667920796f75722063726176696e677320666f722070726f6669747320776974682e546865206f6e6c7920636f696e2074686174e280997320616c77617973206672657368206f7574206f6620746865206f76656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70145971-be9a-466b-b693-c8681e6884ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

