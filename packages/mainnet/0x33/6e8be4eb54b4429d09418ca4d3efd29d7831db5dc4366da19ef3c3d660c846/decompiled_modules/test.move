module 0x336e8be4eb54b4429d09418ca4d3efd29d7831db5dc4366da19ef3c3d660c846::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x42eaac959228c63215060b7612a4c2a5b08e26c9f2790fec209ba3735c64b56a
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Test Token"), 0x1::string::utf8(b"Test, don't buy"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeiaxv3zektkfambjxl26if33oxn4nqpvzji3svvr3ardqfflncwbre"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

