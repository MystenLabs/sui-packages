module 0x1ef6bd0528ff8f5beb4e03a070fed09cd2835a875d844200894b448224eb62c5::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPCAT>(arg0, 6, 0x1::string::utf8(b"POPCAT"), 0x1::string::utf8(b"Popular Cat"), 0x1::string::utf8(b"its the most popular cat on sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/fbf543e4523dd2d584d180176787a545e7a5528fc195ae588a5977e9a553dab3.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPCAT>>(0x2::coin_registry::finalize<POPCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

