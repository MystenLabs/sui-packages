module 0x66a59635442c2796ff828009cae334f01df13cb5feaf4af2bd5c0ec1440f9e11::blobo {
    struct BLOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOBO>(arg0, 6, b"BLOBO", b"Blobo on sui", b"https://x.com/suiblobo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5p_Nd_T9x_400x400_8919350c01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

