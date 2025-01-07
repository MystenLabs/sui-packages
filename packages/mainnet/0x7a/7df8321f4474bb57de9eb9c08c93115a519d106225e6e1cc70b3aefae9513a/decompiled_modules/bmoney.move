module 0x7a7df8321f4474bb57de9eb9c08c93115a519d106225e6e1cc70b3aefae9513a::bmoney {
    struct BMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMONEY>(arg0, 6, b"BMONEY", b"B-MONEY", b"B-money is a concept introduced by computer scientist Wei Dai, which laid foundational ideas for cryptocurrencies like Bitcoin, focusing on digital cash and decentralized systems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa5d366887c57a2791839286c3778d33a4b9b61d3_af08008494.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

