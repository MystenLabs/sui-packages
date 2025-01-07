module 0x978bede94a37d12fe5f2243209355cb600e52fefaffd9bd16639a39bc5ee1678::perry {
    struct PERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERRY>(arg0, 6, b"PERRY", b"Perry the Platypus", b"Perry the Platypus, code-named Agent P, or just simply Perry is the tritagonist of the 2007-15 Disney Channel animated television series Phineas and Ferb. He is Phineas and Ferb's pet platypus, who, unbeknownst to his owners, lives a double life as a secret agent for the O.W.C.A. (a.k.a. \"The Organization Without a Cool Acronym\"), a secret government organization of animal spies tasked with foiling mad and evil scientists.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5883703143395_8a6e81968b9cd3f11074db5db2e75c95_af7f2b5b56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

