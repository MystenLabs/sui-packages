module 0x60af64899836e344a28364b2f04f495dcc2a774d945a2d1ac26aff9afd54716c::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"sui dog", b"the official SUI dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_in_me_ced0e580a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

