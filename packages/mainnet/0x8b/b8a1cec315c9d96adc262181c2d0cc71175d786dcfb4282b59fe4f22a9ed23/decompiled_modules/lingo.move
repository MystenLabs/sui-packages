module 0x8bb8a1cec315c9d96adc262181c2d0cc71175d786dcfb4282b59fe4f22a9ed23::lingo {
    struct LINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINGO>(arg0, 6, b"LINGO", b"SUI LINGO", b"A Web3 Language Edustyle App", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_ff304a691d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

