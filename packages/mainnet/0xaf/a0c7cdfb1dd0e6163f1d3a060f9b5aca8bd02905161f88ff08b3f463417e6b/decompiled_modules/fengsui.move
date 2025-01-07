module 0xafa0c7cdfb1dd0e6163f1d3a060f9b5aca8bd02905161f88ff08b3f463417e6b::fengsui {
    struct FENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENGSUI>(arg0, 6, b"FENGSUI", b"FENG SHUI", b"Feng Shui is an ancient Chinese practice that harmonizes energy flow in spaces for well-being.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000131309_864669f195.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

