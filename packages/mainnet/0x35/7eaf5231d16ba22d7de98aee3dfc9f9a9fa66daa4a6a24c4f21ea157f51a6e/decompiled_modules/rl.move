module 0x357eaf5231d16ba22d7de98aee3dfc9f9a9fa66daa4a6a24c4f21ea157f51a6e::rl {
    struct RL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RL>(arg0, 9, b"RL", b"REL", b"Relapse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a09f9949-75ce-4598-8dc3-7b666023222b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RL>>(v1);
    }

    // decompiled from Move bytecode v6
}

