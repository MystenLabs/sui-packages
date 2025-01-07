module 0xea321087679db44b3299217cfea4d41dafbbfe825f2e0fa80c2fbd0c6ec8fed6::bestober {
    struct BESTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BESTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESTOBER>(arg0, 6, b"BESTOBER", b"Bestober Pumping", b"Oktober bullish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000077112_1c45e89cd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BESTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

