module 0x6155ba594c89435570e40e4749b473543c7dc3431ea4c80da68d36a28919fd3a::yesusdb {
    struct YESUSDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YESUSDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YESUSDB>(arg0, 6, 0x1::string::utf8(b"yesUSDB"), 0x1::string::utf8(b"Yield-Enhanced sUSDB"), 0x1::string::utf8(b"yesUSDB is the auto-compound yield-bearing token of SUSDB saving pool"), 0x1::string::utf8(b"https://www.bucketprotocol.io/icons/sUSDB.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YESUSDB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YESUSDB>>(0x2::coin_registry::finalize<YESUSDB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

