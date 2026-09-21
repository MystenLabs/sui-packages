module 0x44cce18d2447950bbfe1f71ad6fa891db0c346ef9ccbe0380080cb2181438cc0::pawpaw {
    struct PAWPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PAWPAW>(arg0, 6, 0x1::string::utf8(b"PAWPAW"), 0x1::string::utf8(b"Suipop"), 0x1::string::utf8(b"Just a meme, let's grind"), 0x1::string::utf8(b"https://popularsui.xyz/media/0c3b86155c9d4d197e19ccb4f5d72b6f3cc2b82c29b4de5269c0a00e88f01f8e.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWPAW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PAWPAW>>(0x2::coin_registry::finalize<PAWPAW>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

