module 0xb069b29b9379892807045f65249cd98f4c0b90ecce2103e5a9525096f24f8c92::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RICH>(arg0, 6, 0x1::string::utf8(b"RICH"), 0x1::string::utf8(b"Popular Rich"), 0x1::string::utf8(b"Just hold tightly to be rich"), 0x1::string::utf8(b"https://popularsui.xyz/media/1b898299fe516fbf5d7cbf5986164b4356601a0e4bad644c7ce84a56c564b87f.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RICH>>(0x2::coin_registry::finalize<RICH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

