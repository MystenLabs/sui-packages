module 0xf2267e898c96ada45f1df7a6b86032dbe216fb669b84ccd8d45f286c10125d64::CHAR {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHAR>(arg0, 9, 0x1::string::utf8(b"CHAR"), 0x1::string::utf8(b"Charmander"), 0x1::string::utf8(x"54686520666972652d74797065207374617274657220506f6bc3a96d6f6e2077697468206120666c616d65206f6e20697473207461696c2074686174206275726e7320627269676874657220776974682069747320656d6f74696f6e7321"), 0x1::string::utf8(b""), arg1);
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

