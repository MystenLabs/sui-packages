module 0xc806090845c7dccf7658c7f170c7c618ccc2cb721478cc31df25c1cbcd1afc46::jank {
    struct JANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JANK>(arg0, 6, b"JANK", b"JANKEN GAME", b"The Game is Live. Janken is a Japanese simple fun game in which both the players have to make a rock, paper, or scissor. It has only two possible outcomes a draw or win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_19_70ca07f150.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

