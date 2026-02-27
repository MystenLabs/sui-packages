module 0x469ed5b17c97b6a44ad36c5bb7f040404a5b92f700ece94f27818d89a86b7790::subgusd5 {
    struct SUBGUSD5 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<SUBGUSD5>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<SUBGUSD5>(arg0, arg1, arg2);
    }

    fun init(arg0: SUBGUSD5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUBGUSD5>(arg0, 9, 0x1::string::utf8(b"SUBGUSD5"), 0x1::string::utf8(b"Sub Generalized USD v5"), 0x1::string::utf8(b"Sub GUSD vault token v5"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBGUSD5>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUBGUSD5>>(0x2::coin_registry::finalize<SUBGUSD5>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

