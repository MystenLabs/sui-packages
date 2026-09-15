module 0xf4c49f3c6e170c0414549802a3967591578fb1d94d1c4d520ef272f0e48124ca::pop2 {
    struct POP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POP2>(arg0, 6, 0x1::string::utf8(b"POP2"), 0x1::string::utf8(b"POPULAR V2"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://popularsui.xyz/media/093a6c312b54b08cd75ddc1adaf02c3587b64ae9d2472985da27aa506fee725d.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POP2>>(0x2::coin_registry::finalize<POP2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

