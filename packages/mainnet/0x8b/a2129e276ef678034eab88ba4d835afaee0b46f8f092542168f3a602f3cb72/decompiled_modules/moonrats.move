module 0x8ba2129e276ef678034eab88ba4d835afaee0b46f8f092542168f3a602f3cb72::moonrats {
    struct MOONRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONRATS>(arg0, 6, b"Moonrats", b"moonrats", b"rats go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_16_55_22_7b16d84d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

