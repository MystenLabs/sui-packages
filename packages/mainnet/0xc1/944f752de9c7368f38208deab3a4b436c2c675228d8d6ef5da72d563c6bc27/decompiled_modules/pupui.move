module 0xc1944f752de9c7368f38208deab3a4b436c2c675228d8d6ef5da72d563c6bc27::pupui {
    struct PUPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUI>(arg0, 6, b"PUPUI", b"The SUI of PUPUI", b"The sui of PUPUI. Same as sui, but PU-PUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipupu_a81ee7dbcb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

