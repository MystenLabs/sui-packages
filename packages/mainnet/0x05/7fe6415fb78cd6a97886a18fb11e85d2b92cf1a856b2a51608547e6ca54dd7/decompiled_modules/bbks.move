module 0x57fe6415fb78cd6a97886a18fb11e85d2b92cf1a856b2a51608547e6ca54dd7::bbks {
    struct BBKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBKS>(arg0, 6, b"BBKS", b"BlueBucks", b"Welcome to BlueBucks, where fun meets investment under the sea! BlueBucks isn't just another cryptocurrency; it's a movement driven by laughter and community. Our iconic blue crab symbolizes joy and resilience, navigating the currents of the crypto market on the innovative Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluebu_b658845b9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

