module 0x47c000d8c20f5a07b9c38926221704bdf07db407e8317a3660b25d8d2c889d16::fomo2049 {
    struct FOMO2049 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO2049, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO2049>(arg0, 6, b"Fomo2049", b"2049 Fomo on Sui", x"417420544f4b454e323034392c2065766572796f6e6527732063686173696e6720616c7068613a2070616e656c732c20706172746965732c2056432077686973706572732e20427574206e6f206d617474657220776861742c20736f6d65626f647920616c77617973206d6973736573206f75742e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759231163484.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO2049>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO2049>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

