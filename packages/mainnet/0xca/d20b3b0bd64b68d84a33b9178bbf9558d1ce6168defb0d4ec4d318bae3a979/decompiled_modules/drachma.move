module 0xcad20b3b0bd64b68d84a33b9178bbf9558d1ce6168defb0d4ec4d318bae3a979::drachma {
    struct DRACHMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACHMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DRACHMA>(arg0, 6, 0x1::string::utf8(b"DRX"), 0x1::string::utf8(b"Drachma"), 0x1::string::utf8(b"Drachma, the ancient greek currency"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.h2o-nodes.com/v1/blobs/DYlIcfM32ICsXfTJR69kQ6Vv4roYnQbOvoUbRiwsg6g"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACHMA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DRACHMA>>(0x2::coin_registry::finalize<DRACHMA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

