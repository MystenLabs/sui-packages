module 0x837d58fdd6a433edbc615cc8fceed3191ac6a3b8e19e79979a6494f35cd17e68::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"Balls", b"Blue Balls", x"426c75652042616c6c7320282442414c4c53292069732074686520756c74696d61746520646567656e65726174652d617070726f766564206d656d6520636f696e206f6e20535549202c207475726e696e6720746865206d6f7374207061696e66756c6c792072656c617461626c65206d6f6d656e7420696e746f20746865206d6f73742062756c6c697368206d6f76656d656e7420696e207468652073706163652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9664_9f7f887f4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

