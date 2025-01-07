module 0xff432735681afd177daf911556c067e088e0453243935209873c7b1701d6e339::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"SUITARD", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame | the ticker is $STD | A tribute to all retard(io)s on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitard_04031aebd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

