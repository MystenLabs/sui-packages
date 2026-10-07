module 0x6d59deb9c76c5a999410d9d4c47416030149ddb2a04e1b30fb30ba201e0e1b47::popup {
    struct POPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPUP>(arg0, 6, 0x1::string::utf8(b"POPUP"), 0x1::string::utf8(b"POP UP"), 0x1::string::utf8(b"POP goes POPUP. A meme built on POP, powered by POP"), 0x1::string::utf8(b"https://popularsui.xyz/media/1a97e65f578606b6baecd998a86303e2192b4384354673fb3e3d4a501878f401.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPUP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPUP>>(0x2::coin_registry::finalize<POPUP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

