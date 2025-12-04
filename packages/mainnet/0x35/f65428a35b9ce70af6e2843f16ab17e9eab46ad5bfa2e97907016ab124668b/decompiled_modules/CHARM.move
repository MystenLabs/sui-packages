module 0x35f65428a35b9ce70af6e2843f16ab17e9eab46ad5bfa2e97907016ab124668b::CHARM {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHARM>(arg0, 9, 0x1::string::utf8(b"CHARM"), 0x1::string::utf8(b"Charmandaaaa"), 0x1::string::utf8(x"54686520666972652d7479706520506f6bc3a96d6f6e20746f6b656e"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHARM>>(0x2::coin_registry::finalize<CHARM>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHARM>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

