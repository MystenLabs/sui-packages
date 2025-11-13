module 0x7f278df8fc02b0a0237fc9936bf91713d022f73b97e700d4a626a07d55043fb8::RCT {
    struct RCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RCT>(arg0, 9, 0x1::string::utf8(b"RCT"), 0x1::string::utf8(b"Random Color Token"), 0x1::string::utf8(b"A flexible token representing a random color, with 1 million initial supply minted to your wallet."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RCT>>(0x2::coin_registry::finalize<RCT>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RCT>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

