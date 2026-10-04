module 0xc47dad9dc98954ca63153a88a9be014d4e54187ada1b70b583e0c7fb0c8738c3::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 6, 0x1::string::utf8(untag(b"STEST")), 0x1::string::utf8(untag(b"NTEST e2e")), 0x1::string::utf8(untag(b"D")), 0x1::string::utf8(untag(b"I")), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEST>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun untag(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

