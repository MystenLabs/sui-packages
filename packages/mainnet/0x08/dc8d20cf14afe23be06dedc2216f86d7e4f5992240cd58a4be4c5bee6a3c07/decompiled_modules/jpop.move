module 0x8dc8d20cf14afe23be06dedc2216f86d7e4f5992240cd58a4be4c5bee6a3c07::jpop {
    struct JPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPOP>(arg0, 6, b"JPOP", b"JOOZY POP", b"Dapps that has revolutionized the way people interact with the Web3. With its features, allows users to seamlessly interact. Launched on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_13_21_34_58_3f721b3498.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

