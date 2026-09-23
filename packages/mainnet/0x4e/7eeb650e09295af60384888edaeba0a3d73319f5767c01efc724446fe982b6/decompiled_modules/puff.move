module 0x4e7eeb650e09295af60384888edaeba0a3d73319f5767c01efc724446fe982b6::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PUFF>(arg0, 6, 0x1::string::utf8(b"PUFF"), 0x1::string::utf8(b"PUFFER FISH"), 0x1::string::utf8(x"5468617420726f756e642079656c6c6f7720707566666572206973206e6f74206a75737420637574652e204974206973207468652063686172742e0a49742073746172747320736d616c6c2e2050656f706c65206170652e2054686520626f6479207377656c6c732e205370696b657320636f6d65206f75742e20546865206772696e20676574732077696465722e"), 0x1::string::utf8(b"https://popularsui.xyz/media/1c6b2574cf2b308aa398b75636f71ba35e2fbe868a830efd70fc527c06ad3663.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PUFF>>(0x2::coin_registry::finalize<PUFF>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

