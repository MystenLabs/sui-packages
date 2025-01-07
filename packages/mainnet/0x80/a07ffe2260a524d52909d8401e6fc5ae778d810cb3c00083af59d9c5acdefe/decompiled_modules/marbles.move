module 0x80a07ffe2260a524d52909d8401e6fc5ae778d810cb3c00083af59d9c5acdefe::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"MABRLE SAGA", b"Marble Saga Game is a racing themed game. Players are only asked to compete with other players, communicate, and become winners and get token as rewards. Players compete with other players in marble races, communicate, and become winners & get rewarded on $MARBLES. Game developed by Saga. SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marblesui_4f2b384752.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

