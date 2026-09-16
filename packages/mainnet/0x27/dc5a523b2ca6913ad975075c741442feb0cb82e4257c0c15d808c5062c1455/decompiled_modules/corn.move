module 0x27dc5a523b2ca6913ad975075c741442feb0cb82e4257c0c15d808c5062c1455::corn {
    struct CORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CORN>(arg0, 6, 0x1::string::utf8(b"CORN"), 0x1::string::utf8(b"POPCORN"), 0x1::string::utf8(b"The main sponsor of crypto circus."), 0x1::string::utf8(b"https://popularsui.xyz/media/75834635b64dd078ee3ca0689154570b406c1718ecef8aaf2ef27a107ff12eea.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CORN>>(0x2::coin_registry::finalize<CORN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

