module 0x9287324a48ccda44dbfede41a2c577d8fb737ba9380f812333c350bcafd6080d::bro_nvdax {
    struct BRO_NVDAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO_NVDAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRO_NVDAX>(arg0, 8, 0x1::string::utf8(b"broNVDAx"), 0x1::string::utf8(b"Broker NVDAx"), 0x1::string::utf8(b"Tokenized NVDA (broAsset), 1:1 backed and custodied in an Ika dWallet by Broker Finance."), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO_NVDAX>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRO_NVDAX>>(0x2::coin_registry::finalize<BRO_NVDAX>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

