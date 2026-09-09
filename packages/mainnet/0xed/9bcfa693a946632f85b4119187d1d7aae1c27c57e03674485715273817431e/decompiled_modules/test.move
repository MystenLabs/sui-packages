module 0xed9bcfa693a946632f85b4119187d1d7aae1c27c57e03674485715273817431e::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x42eaac959228c63215060b7612a4c2a5b08e26c9f2790fec209ba3735c64b56a
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Don't buy"), 0x1::string::utf8(b"Another Test"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeienzemw5yufb73cs5dyu44iyvng3dlwzcxg7myz6d4ciip2ccyf6m"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

