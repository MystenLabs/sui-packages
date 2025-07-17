module 0xde1e627f3497c4e535220af4ee0dfc41b03f1a86c6a14128e9d8af68d94733b4::hgpts {
    struct HGPTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGPTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGPTS>(arg0, 6, b"HGPTS", b"hatGPT on Sui", b"hatGPT on Sui only for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieuz5nkcywnezk7tqcl2ulvpxdt5alr6kwy2cm5sosoegsbynojxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGPTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HGPTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

