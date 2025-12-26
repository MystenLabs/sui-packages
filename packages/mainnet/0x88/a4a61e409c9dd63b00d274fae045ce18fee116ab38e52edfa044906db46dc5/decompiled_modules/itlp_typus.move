module 0x88a4a61e409c9dd63b00d274fae045ce18fee116ab38e52edfa044906db46dc5::itlp_typus {
    struct ITLP_TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITLP_TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ITLP_TYPUS>(arg0, 9, 0x1::string::utf8(b"iTLP-TYPUS"), 0x1::string::utf8(b"Isolated Typus Perp LP Token TYPUS"), 0x1::string::utf8(b"Isolated Typus Perp LP Token for TYPUS Token"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/TLP.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ITLP_TYPUS>>(0x2::coin_registry::finalize<ITLP_TYPUS>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITLP_TYPUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

