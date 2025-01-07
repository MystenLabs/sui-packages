module 0x1b99c6c2a6aef5c58b1ebe7a93d39b0c19c1c2cbfd9757cb710b627901abfbc4::sswarm {
    struct SSWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWARM>(arg0, 6, b"SSWARM", b"SWARM ON SUI", b"The swarm is now live on sui, not socials. 100% Decentralized made by ppl for teh ppl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005582_9c68244289.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSWARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

