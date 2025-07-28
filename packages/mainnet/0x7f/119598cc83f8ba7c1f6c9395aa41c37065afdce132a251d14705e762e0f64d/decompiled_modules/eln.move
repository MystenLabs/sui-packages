module 0x7f119598cc83f8ba7c1f6c9395aa41c37065afdce132a251d14705e762e0f64d::eln {
    struct ELN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELN>(arg0, 6, b"ELN", b"ELON COIN", b"leading the charge for something big!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaz5vicfjtg3zndjcs3ggbbiz2vd3oj6llxu2wapo33dchxpsxmge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

