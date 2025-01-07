module 0x3a352d81aafbfe85b6964812dc4ed8c40c295ded26485afb69d1a261870bf162::std {
    struct STD has drop {
        dummy_field: bool,
    }

    fun init(arg0: STD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STD>(arg0, 6, b"STD", b"retardSuitizen", b"tweet 'get me in lil turd' to get featured in the suitardio hall of fame | the ticker is $STD | A tribute to all retard(io)s on Su", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitard_3ed2f5b326.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STD>>(v1);
    }

    // decompiled from Move bytecode v6
}

