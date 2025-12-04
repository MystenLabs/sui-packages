module 0x46d1bf2b32f98c2e30fb7554f527d3f235b3dbac8912b25a739145299405f831::BZMAN {
    struct BZMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BZMAN>(arg0, 9, 0x1::string::utf8(b"BZMAN"), 0x1::string::utf8(b"BizzarroMan"), 0x1::string::utf8(b"The twisted anti-hero from the Bizarro dimension - where everything is backwards and nothing makes sense!"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BZMAN>>(0x2::coin_registry::finalize<BZMAN>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BZMAN>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZMAN>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZMAN>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

