module 0x149a73c77c7f3ffff9d5a40e3c22b0bdc9def4964d35e5e8e834e3e6636ab815::bro_sol {
    struct BRO_SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO_SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRO_SOL>(arg0, 9, 0x1::string::utf8(b"broSOL"), 0x1::string::utf8(b"Broker SOL"), 0x1::string::utf8(b"Tokenized SOL (broAsset), 1:1 backed and custodied in an Ika dWallet by Broker Finance."), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO_SOL>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRO_SOL>>(0x2::coin_registry::finalize<BRO_SOL>(v0, arg1), v2);
    }

    // decompiled from Move bytecode v7
}

