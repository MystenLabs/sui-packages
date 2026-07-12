module 0x5b4635cb1896471225af7de073432f8bfac500d3f251cc4a055310bfa2be2338::bro_tslax {
    struct BRO_TSLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO_TSLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRO_TSLAX>(arg0, 8, 0x1::string::utf8(b"broTSLAx"), 0x1::string::utf8(b"Broker TSLAx"), 0x1::string::utf8(b"Tokenized TSLA (broAsset), 1:1 backed and custodied in an Ika dWallet by Broker Finance."), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO_TSLAX>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRO_TSLAX>>(0x2::coin_registry::finalize<BRO_TSLAX>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

