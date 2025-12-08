module 0xd98d746fd647fb3834dd3df8044476f8379e301b3a5c79d85b5a62a5c2051c99::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ABC>(arg0, 9, 0x1::string::utf8(b"ABC"), 0x1::string::utf8(b"ABC"), 0x1::string::utf8(b"Just a test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ABC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<ABC>>(0x2::coin_registry::finalize<ABC>(v0, arg1));
    }

    // decompiled from Move bytecode v6
}

