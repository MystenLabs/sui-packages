module 0xb7ac87bb6964b34a1c75039293afc9ab3104a7600035d7bd25f08e5af4cb556a::aaacr7 {
    struct AAACR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAACR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAACR7>(arg0, 6, b"AAACR7", b"aaaCR7", x"24414141435237206f6e2053554920636861696e0a0a22535555554922202d20437269737469616e6f20526f6e616c646f204f6666696369616c2043656c6562726174696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2ea9086453.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAACR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAACR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

