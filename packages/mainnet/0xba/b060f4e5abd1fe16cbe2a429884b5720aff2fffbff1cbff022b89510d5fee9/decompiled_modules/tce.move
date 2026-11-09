module 0xbab060f4e5abd1fe16cbe2a429884b5720aff2fffbff1cbff022b89510d5fee9::tce {
    struct TCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TCE>(arg0, 6, 0x1::string::utf8(b"TCE"), 0x1::string::utf8(b"TCE bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TCE>>(0x2::coin_registry::finalize<TCE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

