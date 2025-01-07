module 0x23fbd541138d1392ea610b106a2a1f8d80028ab27fcd51ddafe820467681f60e::emoji {
    struct EMOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOJI>(arg0, 6, b"Emoji", b"Sui Emoji", x"496e207468652076696272616e7420776f726c64206f6620456d6f6a696c616e642c207468657265206c69766564206120636865657266756c20656d6f6a69206f6e2053756920636861696e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_211629_0db113b4d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

