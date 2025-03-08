module 0x14e662fe710d459e6e4a6e21daf877ed58a6a6ca529be32b3be7c7348ad5bd17::cllck {
    struct CLLCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLLCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLLCK>(arg0, 6, b"CLlCK", b"CLlCK ARTlFlClAl lNTELlGENCE", b"For $CLICK ARTIFICIAL INTELIGENCE Community, this is not the end, nor the beginning of the end, but perhaps, the end of the beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoclickai_dabf3b99cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLLCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLLCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

