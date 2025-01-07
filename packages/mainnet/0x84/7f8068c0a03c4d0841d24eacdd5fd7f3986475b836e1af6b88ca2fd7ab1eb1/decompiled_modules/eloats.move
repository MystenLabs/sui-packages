module 0x847f8068c0a03c4d0841d24eacdd5fd7f3986475b836e1af6b88ca2fd7ab1eb1::eloats {
    struct ELOATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELOATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELOATS>(arg0, 6, b"Eloats", b"EloatsAI", b"Eloats AI: Redefining intelligence with quantum logic, emotional depth, and self-evolving capabilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_041056974_6dc6d84244.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELOATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELOATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

