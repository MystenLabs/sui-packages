module 0x40ac656a150239b68ff4d321fd5f3ee88f26c14274be327d67bdd6b36d386057::suiweed {
    struct SUIWEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEED>(arg0, 6, b"SUIWEED", b"WEED OF SUI IS CRAZY!", b"$SUIWEED is a laid-back, chill token on Sui, inspired by the vibes of weed culture. It represents growth, relaxation, and a smooth ride through the Sui space. With $SUIWEED, you can kick back, relax, and watch your investments grow naturally!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIWEED_d030f54e3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

