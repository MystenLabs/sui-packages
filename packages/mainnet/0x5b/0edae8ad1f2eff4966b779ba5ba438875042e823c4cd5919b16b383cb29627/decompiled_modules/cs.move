module 0x5b0edae8ad1f2eff4966b779ba5ba438875042e823c4cd5919b16b383cb29627::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"Chang Peng SUI", x"4f75742066726f6d20707269736f6e20736f6f6e2e2e2e0a49276d20646f6e6520776974682042696e616e63652c206d6f766520746f20535549206e6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CS_54e1337eca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v1);
    }

    // decompiled from Move bytecode v6
}

