module 0x55fb88015d424435c102fe4fbace2095b1c72b6f4c254db9b003dd2647f0e846::mizuk {
    struct MIZUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUK>(arg0, 6, b"MIZUK", b"Mizuk AI", b"Revolutionize Creativity with MizukAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Urs_H_Uk_400x400_f716767677.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

