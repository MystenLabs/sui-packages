module 0x8e3281cbdf7219e251d0b302526c8528495618843e6b7e84c37f40405e5c1765::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCAT>(arg0, 6, 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"POP CAT"), 0x1::string::utf8(x"5468652063617420746861742077617320626f726e20746f20504f502e0a53554920736561736f6e207374617274732077697468206120504f50"), 0x1::string::utf8(b"https://popularsui.xyz/media/771b428a9cb30b6042d4415a356eadcbfc754c398a00c4747ea80330706113ab.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCAT>>(0x2::coin_registry::finalize<POPCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

