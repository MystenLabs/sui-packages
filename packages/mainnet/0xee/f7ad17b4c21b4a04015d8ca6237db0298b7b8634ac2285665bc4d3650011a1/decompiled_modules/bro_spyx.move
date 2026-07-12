module 0xeef7ad17b4c21b4a04015d8ca6237db0298b7b8634ac2285665bc4d3650011a1::bro_spyx {
    struct BRO_SPYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO_SPYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRO_SPYX>(arg0, 8, 0x1::string::utf8(b"broSPYx"), 0x1::string::utf8(b"Broker SPYx"), 0x1::string::utf8(b"Tokenized SP500 / SPY (broAsset), 1:1 backed and custodied in an Ika dWallet by Broker Finance."), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO_SPYX>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRO_SPYX>>(0x2::coin_registry::finalize<BRO_SPYX>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

