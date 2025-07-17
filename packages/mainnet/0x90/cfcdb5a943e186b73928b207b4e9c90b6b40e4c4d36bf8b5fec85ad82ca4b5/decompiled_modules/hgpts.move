module 0x90cfcdb5a943e186b73928b207b4e9c90b6b40e4c4d36bf8b5fec85ad82ca4b5::hgpts {
    struct HGPTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGPTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGPTS>(arg0, 6, b"HGPTS", b"hatGPT on sui", b"hatGPT on Sui, only for  community fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieuz5nkcywnezk7tqcl2ulvpxdt5alr6kwy2cm5sosoegsbynojxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGPTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HGPTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

