module 0x48ab25e4686ffaebd89b5143ad6645a57e999c83945590665cbc2c0794ee74f2::evf {
    struct EVF has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVF>(arg0, 6, b"EVF", b"EVOFROG", x"546869732069732069742021210a0a24455646206f6e2053554920697320746865204e6172726174697665200a0a4d6f73742066616d6f757320576174657220626173656420702d6d6f6e206f6e2074686520576174657220636861696e2e2045766f6c766520746f20746865204d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreien6yktr7oeoummaes4fvvz6ku3v4fecuvllkjdpxqbk35lsonn6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

