module 0xe3859ad34c2f4fb8bfa14e66bf89b997768be21a8338085e148a04d6a3ec7a54::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCAT>(arg0, 6, 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"Popular Cat"), 0x1::string::utf8(b"the popular cat on sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/474123d1dfce0f597526a71d334a550cff794ec59dc6b8552d91d0e4380b8923.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCAT>>(0x2::coin_registry::finalize<POPCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

