module 0xca10b4c462df797c467d5e31c1df2513d9f6bfa06edf5677da491c66228de104::SCT {
    struct SCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCT>(arg0, 9, 0x1::string::utf8(b"SCT"), 0x1::string::utf8(b"Suichat Test Token"), 0x1::string::utf8(b"A flexible test token deployed via Suichat for demonstration purposes."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SCT>>(0x2::coin_registry::finalize<SCT>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SCT>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCT>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

