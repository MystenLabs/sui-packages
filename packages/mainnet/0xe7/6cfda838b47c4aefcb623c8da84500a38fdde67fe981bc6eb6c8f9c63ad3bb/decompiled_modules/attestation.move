module 0xe76cfda838b47c4aefcb623c8da84500a38fdde67fe981bc6eb6c8f9c63ad3bb::attestation {
    struct ATTESTATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTESTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTESTATION>(arg0, 9, b"ATTEST", b"Attestation Mark", b"Transaction validation attestation mark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://markers.protocol.io/attest.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATTESTATION>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ATTESTATION>>(v0);
    }

    public entry fun mark_attested(arg0: &mut 0x2::coin::TreasuryCap<ATTESTATION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ATTESTATION>>(0x2::coin::mint<ATTESTATION>(arg0, arg1, arg3), arg2);
    }

    public entry fun remove_mark(arg0: &mut 0x2::coin::TreasuryCap<ATTESTATION>, arg1: 0x2::coin::Coin<ATTESTATION>) {
        0x2::coin::burn<ATTESTATION>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

