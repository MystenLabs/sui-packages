module 0x8e95d98785b45ea918d1d5bcfd104d942ddf61c94fa2bfb5c901faf6a321c58::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Test Token"), 0x1::string::utf8(b"A flexible test token deployed via Suichat for demonstration"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

