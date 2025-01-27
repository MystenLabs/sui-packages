module 0x9afd78a9d7776e682ef773d610edc9e345fa59b27b7d17d751a8afdce1dc5727::SUI2025 {
    struct SUI2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI2025>(arg0, 9, b"SUI2025", b"SUI2025", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI2025>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI2025>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI2025>>(0x2::coin::mint<SUI2025>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

