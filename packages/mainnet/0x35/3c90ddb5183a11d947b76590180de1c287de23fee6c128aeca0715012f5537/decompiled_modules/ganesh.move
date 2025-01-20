module 0x353c90ddb5183a11d947b76590180de1c287de23fee6c128aeca0715012f5537::ganesh {
    struct GANESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GANESH>(arg0, 6, b"GANESH", b"Ganesh by SuiAI", b"$GANESH is a divine meme coin that brings Lord Ganesha's blessing to the crypto realm. Known as the remover of obstacles and lord of new beginnings, this token aims to clear the path to crypto prosperity while maintaining a playful community spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004100_46a134b0c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GANESH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANESH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

