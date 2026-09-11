module 0xccc233d6e4122c8e4503b7a9e1a231bede12871c0e9bad89ea7a656aaa257844::notary {
    struct Attestation has store, key {
        id: 0x2::object::UID,
        date: u64,
        hash: vector<u8>,
        schema: u8,
    }

    struct Attested has copy, drop {
        date: u64,
        hash: vector<u8>,
        schema: u8,
        attestation_id: 0x2::object::ID,
    }

    entry fun attest(arg0: u64, arg1: vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        assert!(arg0 >= 20170101 && arg0 <= 21001231, 1);
        let v0 = Attestation{
            id     : 0x2::object::new(arg3),
            date   : arg0,
            hash   : arg1,
            schema : arg2,
        };
        let v1 = Attested{
            date           : arg0,
            hash           : arg1,
            schema         : arg2,
            attestation_id : 0x2::object::id<Attestation>(&v0),
        };
        0x2::event::emit<Attested>(v1);
        0x2::transfer::freeze_object<Attestation>(v0);
    }

    // decompiled from Move bytecode v7
}

