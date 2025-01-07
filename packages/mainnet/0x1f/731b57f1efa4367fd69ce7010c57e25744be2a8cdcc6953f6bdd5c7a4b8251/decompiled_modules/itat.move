module 0x1f731b57f1efa4367fd69ce7010c57e25744be2a8cdcc6953f6bdd5c7a4b8251::itat {
    struct ITAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITAT>(arg0, 6, b"ITAT", b"Imaginator Touch And Tai", b"ITAT meme token the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076409_61784f5899.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

