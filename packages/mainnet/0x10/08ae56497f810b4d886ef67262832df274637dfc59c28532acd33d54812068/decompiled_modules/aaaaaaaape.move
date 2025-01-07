module 0x1008ae56497f810b4d886ef67262832df274637dfc59c28532acd33d54812068::aaaaaaaape {
    struct AAAAAAAAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAAPE>(arg0, 6, b"Aaaaaaaape", b"Aaaaaaaaape", b"Aaaaaaaaaape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaape_32e53802c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

