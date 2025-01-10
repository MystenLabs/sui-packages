module 0xdafd4ec6b92a2cf0989c1278b7a54f9c4f2079f690c11eb457af0052f451d5c6::special_purpose_vehicle {
    struct SPV has store, key {
        id: 0x2::object::UID,
        path: vector<u8>,
        owner: address,
    }

    // decompiled from Move bytecode v6
}

