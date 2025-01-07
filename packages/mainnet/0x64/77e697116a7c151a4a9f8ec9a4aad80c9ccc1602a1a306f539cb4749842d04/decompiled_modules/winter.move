module 0x6477e697116a7c151a4a9f8ec9a4aad80c9ccc1602a1a306f539cb4749842d04::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"WINTER", b"AGENT WINTER AI", b"Visit winter website to see the truth about blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_31_01_09_48_2cb726611f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

