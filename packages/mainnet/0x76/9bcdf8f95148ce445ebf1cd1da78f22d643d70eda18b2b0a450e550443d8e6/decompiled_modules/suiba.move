module 0x769bcdf8f95148ce445ebf1cd1da78f22d643d70eda18b2b0a450e550443d8e6::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 6, b"SUIBA", b"Suiba", b"SUIBA INU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4929376069639843288_5d09a2d8e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

