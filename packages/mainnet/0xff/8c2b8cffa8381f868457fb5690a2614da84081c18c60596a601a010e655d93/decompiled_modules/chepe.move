module 0xff8c2b8cffa8381f868457fb5690a2614da84081c18c60596a601a010e655d93::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"CHEPE", b"Chad Pepe", b"When you combine Chad and Pepe, you get CHEPEthe ultimate meme chad on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004825_8a8256ce24.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

