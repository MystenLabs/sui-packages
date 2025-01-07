module 0x40d4405e40a91219f8499104560ba993266f906a2635558f0d873a5d1ec81486::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"Suidog", b"Suidoge", b"sui On the dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/comment_0a5d1af17b7c19cd3081ee72e0f78265_edit_434213924849888_2a35b202bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

