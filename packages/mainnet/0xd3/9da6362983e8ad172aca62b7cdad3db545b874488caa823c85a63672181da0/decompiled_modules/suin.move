module 0xd39da6362983e8ad172aca62b7cdad3db545b874488caa823c85a63672181da0::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"SUIn", b"HallowSUIn", x"49276d206a757374206120426c75652050756d706b696e200a0a57656c636f6d6520746f2048616c6c6f775355496e2074686520686f6d65206f662074686520426c75652050756d706b696e0a200a486f77206661722077696c6c2074686520426c75652050756d706b696e20676f206265666f72652048616c6c6f775355496e3f0a200a52656d656d6265722049276d206a757374206120426c75652050756d706b696e0a200a5768617420492063616e2070726f6d69736520697320796f752077696c6c2067657420545249434b204f522054524541540a200a547269636b20696620796f75204c4f5345205375690a200a547265617420696620796f75204741494e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HALLOWSUIN_3cfa7285c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

