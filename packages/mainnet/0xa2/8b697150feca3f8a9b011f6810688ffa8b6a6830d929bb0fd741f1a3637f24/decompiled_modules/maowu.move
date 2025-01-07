module 0xa28b697150feca3f8a9b011f6810688ffa8b6a6830d929bb0fd741f1a3637f24::maowu {
    struct MAOWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOWU>(arg0, 6, b"MAOWU", b"MAOWU SUI", b"reality was optional we chose cubes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_07_12_51_54_5170070e3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

