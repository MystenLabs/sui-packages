module 0xd822420beacac6659713d0c11bcb78042709f65fc9f26a3ade2b7770026d7550::dpen {
    struct DPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPEN>(arg0, 6, b"DPEN", b"DIZZY PENGUIN", b"Spinning into the meme scene with unstoppable energy. Dizzy Penguin is dizzy for gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_043934324_9eb70a7d04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

