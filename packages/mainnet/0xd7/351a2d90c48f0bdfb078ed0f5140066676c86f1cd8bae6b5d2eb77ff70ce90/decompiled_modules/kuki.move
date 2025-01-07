module 0xd7351a2d90c48f0bdfb078ed0f5140066676c86f1cd8bae6b5d2eb77ff70ce90::kuki {
    struct KUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKI>(arg0, 6, b"KUKI", b"Kuki", b"I love nature, it's everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_05_T165214_210_1c5692286f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

