module 0x86a1e4a301d0d0195aa2e3e0220ed7e45c1416e032c8c28acc8d776fe57bef06::fifa2025 {
    struct FIFA2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFA2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFA2025>(arg0, 6, b"Fifa2025", b"Fifa", b"Fifa is love to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731161349132.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIFA2025>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFA2025>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

