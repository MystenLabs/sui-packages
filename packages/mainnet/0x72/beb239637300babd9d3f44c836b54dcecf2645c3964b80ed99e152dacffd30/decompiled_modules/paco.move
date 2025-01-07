module 0x72beb239637300babd9d3f44c836b54dcecf2645c3964b80ed99e152dacffd30::paco {
    struct PACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACO>(arg0, 6, b"PACO", b"PACO ON SUI", b"A penguin without limits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/paco_1fa21d34ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

