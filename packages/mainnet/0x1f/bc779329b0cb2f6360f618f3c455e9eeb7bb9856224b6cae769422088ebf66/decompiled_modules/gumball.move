module 0x1fbc779329b0cb2f6360f618f3c455e9eeb7bb9856224b6cae769422088ebf66::gumball {
    struct GUMBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBALL>(arg0, 6, b"GUMBALL", b"Gumball", b"The Amazing World Of Gumball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022849_4752ece546.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

