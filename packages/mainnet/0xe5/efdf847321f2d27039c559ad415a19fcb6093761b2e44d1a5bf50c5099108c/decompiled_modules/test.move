module 0xe5efdf847321f2d27039c559ad415a19fcb6093761b2e44d1a5bf50c5099108c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x6226a27e0378a4b86af81f50a8728f2483a261e3125193f0e99004b8d00dedfe
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"Test Token"), 0x1::string::utf8(b"Test, don't buy"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeiaxv3zektkfambjxl26if33oxn4nqpvzji3svvr3ardqfflncwbre"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST>>(0x2::coin_registry::finalize<TEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

