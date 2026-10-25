module 0xfccb7ec3849eaa0766055a3df0bb52f3d7c30d99beb4474f668b4d0e3b4663cb::ylo {
    struct YLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YLO>(arg0, 9, 0x1::string::utf8(b"YLO"), 0x1::string::utf8(b"ylo"), 0x1::string::utf8(b"ylo (YLO)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YLO>>(0x2::coin_registry::finalize<YLO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

