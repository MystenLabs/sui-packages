module 0x42e1c80bae4686a1b25bd22f03b86562444716fe20547005318a9256d5c491ea::konke {
    struct KONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONKE>(arg0, 6, b"KONKE", b"KONKE SUI", b"Everyone wants to go to the Moon but the real treasure lies on the bottom of the Ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_02_18_46_4f5cf33a2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

