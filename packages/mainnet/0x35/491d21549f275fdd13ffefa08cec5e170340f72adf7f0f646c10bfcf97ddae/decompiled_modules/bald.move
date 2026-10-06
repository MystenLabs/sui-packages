module 0x35491d21549f275fdd13ffefa08cec5e170340f72adf7f0f646c10bfcf97ddae::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BALD>(arg0, 6, 0x1::string::utf8(b"BALD"), 0x1::string::utf8(b"BALD ADENIYI"), 0x1::string::utf8(b"Bald adeniyi on suicamp"), 0x1::string::utf8(b"https://popularsui.xyz/media/d938a3acd76904ac7f66247b703509d2a22fce92e449371bb563bb9b86b1e5fc.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BALD>>(0x2::coin_registry::finalize<BALD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

