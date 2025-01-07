module 0x1f9ce898a5091833b7b216056b9dbd12f0c4e0779ad76cfade60c75238040c06::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"sui dog", b"the official SUI dog ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dog_in_me_c8bda9a09c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

