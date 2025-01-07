module 0x996f04508b138aa0209b4ce5734e796cd78b76b5a1ba5e1d470982fc0056fb76::qqil {
    struct QQIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQIL>(arg0, 6, b"QQIL", b"QUICK QUAIL", b"Small, fast, and always ahead of the game. Quick Quail is all about rapid gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_035724847_4cc6771c7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

