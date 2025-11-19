module 0xb21873156560b2919f323a5cb9233f576fe0dd858b8fcaebc508acbad098faa0::ego {
    struct EGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d44f45a3abfc7b9486504ab0c8e6d777d4028c8741015be03359ef0c686427e8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EGO         ")))), trim_right(b"Superego                        "), trim_right(b"One Network to Rule Them All - At Superego Network, we make human oversight the default in an AI-driven world. We provide Proof of Humanity, agent IDs, and verifiable credentials so machines act transparently, safely, and only with your consent. Our goal: clear, auditable human-machine interactions and a global standar"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGO>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

