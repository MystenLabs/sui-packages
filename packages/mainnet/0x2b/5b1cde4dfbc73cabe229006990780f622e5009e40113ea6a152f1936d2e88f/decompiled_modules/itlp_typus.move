module 0x2b5b1cde4dfbc73cabe229006990780f622e5009e40113ea6a152f1936d2e88f::itlp_typus {
    struct ITLP_TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITLP_TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ITLP_TYPUS>(arg0, 9, 0x1::string::utf8(b"iTLP-TYPUS"), 0x1::string::utf8(b"Isolated Typus Perps LP Token - TYPUS"), 0x1::string::utf8(b"Isolated Typus Perps LP Token for TYPUS Token"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/iTLP-TYPUS.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ITLP_TYPUS>>(0x2::coin_registry::finalize<ITLP_TYPUS>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITLP_TYPUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

