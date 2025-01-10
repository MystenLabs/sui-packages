module 0x415b2391b65598ce2f64ec9d6c02f5686e7f25865e2f82f9f692249659a5ac37::pikai {
    struct PIKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAI>(arg0, 6, b"PIKAI", b"PIKAI AGENT", b"PIKAI: The Ultimate Evolution.PIKAI is an AI Agent that grows with its market cap. Emerging from its Pokeball, the more it evolves, the higher its power soars, until it shakes the SUI blockchain. Try to catch it if you can and join the PIKAI legend !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pika_Agent_9115214e06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

