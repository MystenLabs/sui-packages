module 0x874d3ed3cefc419181c748e377681e04da903f1fca54b29125cbf12f4183b9c1::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"TERMINUS", b"First City in Mars", b"FirstCityinMars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LV_2_Egmm6_400x400_e5ce565d2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

