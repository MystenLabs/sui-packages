module 0xd96081e0ef1e41d9c1630be490af628705bd9eeb6cd967cd5e82d14642f13837::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BORED>(arg0, 6, 0x1::string::utf8(b"BORED"), 0x1::string::utf8(b"bored"), 0x1::string::utf8(b"bored "), 0x1::string::utf8(b"https://popularsui.xyz/media/34eca3c4579f55f9ca86f1d0b268e420b87a2fd54329cedeb99898e3395b96f9.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BORED>>(0x2::coin_registry::finalize<BORED>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

