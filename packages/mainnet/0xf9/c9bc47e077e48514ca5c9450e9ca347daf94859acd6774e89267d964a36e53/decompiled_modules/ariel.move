module 0xf9c9bc47e077e48514ca5c9450e9ca347daf94859acd6774e89267d964a36e53::ariel {
    struct ARIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIEL>(arg0, 6, b"ARIEL", b"Ariel The Big Mermaido", b"Introducing $ARIEL, the token that brings the magic of the ocean to the world of cryptocurrency! Inspired by the enchanting spirit of the beloved mermaid, $ARIEL embodies freedom, exploration, and the wonders of the underwater realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_36_0cc23423b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

