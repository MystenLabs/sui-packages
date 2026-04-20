module 0xaec6f66bbe50f08b9e29028f99bb56e20a469a288179d5fdf764cb3bbe691ce1::verify {
    struct Attestation has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        attester: address,
        timestamp_ms: u64,
    }

    public entry fun attest(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Attestation{
            id           : 0x2::object::new(arg2),
            hash         : arg0,
            attester     : 0x2::tx_context::sender(arg2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::transfer::transfer<Attestation>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

