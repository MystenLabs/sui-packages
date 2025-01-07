module 0xe85b6a702129c2829ff527006561f46b6898b51f1927e72e944a9dd785274287::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MG>(arg0, 6, b"MG", b"mario-go", b"Game mems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mario_2e142b11c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MG>>(v1);
    }

    // decompiled from Move bytecode v6
}

