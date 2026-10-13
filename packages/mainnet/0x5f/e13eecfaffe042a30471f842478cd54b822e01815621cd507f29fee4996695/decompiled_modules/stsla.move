module 0x5fe13eecfaffe042a30471f842478cd54b822e01815621cd507f29fee4996695::stsla {
    struct STSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STSLA>(arg0, 8, 0x1::string::utf8(b"sTSLA"), 0x1::string::utf8(b"Tesla xSpot"), 0x1::string::utf8(b"One coin per Tesla xStock (TSLAx) share held on Solana by the xSpot custody wallet."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSLA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STSLA>>(0x2::coin_registry::finalize<STSLA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

