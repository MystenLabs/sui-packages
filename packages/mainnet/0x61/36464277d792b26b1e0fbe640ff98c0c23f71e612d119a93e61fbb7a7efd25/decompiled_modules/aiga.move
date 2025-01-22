module 0x6136464277d792b26b1e0fbe640ff98c0c23f71e612d119a93e61fbb7a7efd25::aiga {
    struct AIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIGA>(arg0, 6, b"Aiga", b"AIGA", b"AIGA is designed to replace you, the gamer. Lets face itif you were any good, you wouldnt need cheats. But here we are.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2229_37a1835d04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

