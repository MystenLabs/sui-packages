module 0x3177d157452ed0b97a4f79c21cb657ec1ae67c35367c832dacef8b3e5a1ddea2::snoopfrog {
    struct SNOOPFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOPFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOPFROG>(arg0, 6, b"SNOOPFROG", b"SnoopFrog on SUI", b"$SNOOF Is the meme token inspired by #SnoopDogg a Legendary Rapper, Singer, Songwriter, Actor & Entrepreneur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H_Jg9cj_Em_400x400_9231bb8cdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOPFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOPFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

