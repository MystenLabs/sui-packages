module 0x1122e37a5adeffdcf340a9bbe46d2b2087d28f8e42a6d481888ae0f32b47b75e::MYN {
    struct MYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MYN>(arg0, 9, 0x1::string::utf8(b"MYN"), 0x1::string::utf8(b"mynntil"), 0x1::string::utf8(x"4d79204e74696c20546f6b656e20e28093206275726e2d6f6e6c7920737570706c79206d6f64656c"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MYN>>(0x2::coin_registry::finalize<MYN>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYN>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYN>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYN>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

