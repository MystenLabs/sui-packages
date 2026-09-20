module 0xa55fca39a63b3545f423e25e6c391f9641d09dca67423480acfaaa80c50f267c::fpt3 {
    struct FPT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FPT3>(arg0, 6, 0x1::string::utf8(b"FPT3"), 0x1::string::utf8(b"FartPad"), 0x1::string::utf8(b"Testing Fartpad"), 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6Dxpp6xGB3IeKNsldcON1S_6gvBAEv9-Xsh5flu9uKg&s=10"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPT3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FPT3>>(0x2::coin_registry::finalize<FPT3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

