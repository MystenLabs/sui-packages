module 0xc6c325479d922e6dc8940b299a989ecb342629995f395a4bb5f35a4194fba2b6::CHAR {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHAR>(arg0, 9, 0x1::string::utf8(b"CHAR"), 0x1::string::utf8(b"Charizard"), 0x1::string::utf8(x"54686520666c616d6520506f6bc3a96d6f6e2e205768656e20657870656c6c696e67206120626c617374206f66207375706572686f7420666972652c207468652072656420666c616d6520617420746970206f6620697473207461696c206275726e73206d6f726520696e74656e73656c792e20f09f94a5f09f9089"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHAR>>(0x2::coin_registry::finalize<CHAR>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHAR>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

