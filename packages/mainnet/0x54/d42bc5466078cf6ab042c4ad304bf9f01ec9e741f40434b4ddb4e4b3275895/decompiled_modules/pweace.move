module 0x54d42bc5466078cf6ab042c4ad304bf9f01ec9e741f40434b4ddb4e4b3275895::pweace {
    struct PWEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWEACE>(arg0, 6, b"Pweace", b"Pweace Cat", b"Revolution in the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051432_41802c2498.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

