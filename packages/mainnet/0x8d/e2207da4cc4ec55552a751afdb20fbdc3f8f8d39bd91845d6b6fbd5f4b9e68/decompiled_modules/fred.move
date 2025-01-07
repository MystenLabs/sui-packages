module 0x8de2207da4cc4ec55552a751afdb20fbdc3f8f8d39bd91845d6b6fbd5f4b9e68::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"suifred", b"FRED ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blutty_0347345c3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

