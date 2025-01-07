module 0x686a67a1902650c506d69347a94d4f276b4f8fc00b9a70f17fe55778611fd64d::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLE>(arg0, 6, b"Pickle", b"Pickle of Sui", b"The friendliest pickle of Sui is here to take everyone on MOON! #Pickle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_bright_green_pickle_with_a_cartooni_3_cc69c62ac3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

