module 0x902a9b4ab691d8c7ba9c424342efbf09ee562e1e27202cab3337e714a4ebac71::iguana {
    struct IGUANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGUANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGUANA>(arg0, 6, b"IGUANA", b"Iguana Bull", b"The iguana's riding the bull, as he often shares stories about how this unique pet taught him resilience, adaptability, and the importance of thinking outside the box", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xq_Cm7_O_Xk_AAJ_Cep_67d21ce513.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGUANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGUANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

