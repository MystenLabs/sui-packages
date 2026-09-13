module 0x4b9d66b3f06aba6e309d3ed2c0d8a12912b8e69ad5076385ee50768bc2dcabc6::llplp {
    struct LLPLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLPLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLPLP>(arg0, 9, b"LLPLP", b"LLPLP ", b"LLPLP  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmepVAVxZusWaKA7Ppc2KkCwyxDKmhcKt2iVJG3LCgfGvd"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLPLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLPLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

