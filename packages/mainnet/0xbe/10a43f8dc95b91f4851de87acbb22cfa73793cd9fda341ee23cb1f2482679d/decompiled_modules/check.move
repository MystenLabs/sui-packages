module 0xbe10a43f8dc95b91f4851de87acbb22cfa73793cd9fda341ee23cb1f2482679d::check {
    struct CheckResult has store, key {
        id: 0x2::object::UID,
        correct: u8,
        value: u8,
    }

    public entry fun check_word(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg2, &v0), 0);
        let v1 = 0x2::hash::blake2b256(&arg3);
        let v2 = CheckResult{
            id      : 0x2::object::new(arg4),
            correct : 9,
            value   : *0x1::vector::borrow<u8>(&v1, 0) % 2,
        };
        0x2::transfer::public_transfer<CheckResult>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun check_word_compare(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = CheckResult{
            id      : 0x2::object::new(arg4),
            correct : 8,
            value   : 100,
        };
        0x2::transfer::public_transfer<CheckResult>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

