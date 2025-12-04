module 0xa6d63b4ac0460f10fe9d201db014eb07039930b2b18eef50087e81dc5d0ae6fa::CHRMST {
    struct CHRMST has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRMST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHRMST>(arg0, 9, 0x1::string::utf8(b"CHRMST"), 0x1::string::utf8(b"Charmastoise"), 0x1::string::utf8(x"54686520756c74696d6174652077617465722d666972652068796272696420506f6bc3a96d6f6e20746f6b656e202d207061727420436861726d616e6465722c207061727420426c6173746f6973652c20616c6c20617765736f6d6520f09f94a5f09f92a7"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHRMST>>(0x2::coin_registry::finalize<CHRMST>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHRMST>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRMST>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRMST>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

