module 0xbda2563c8eff47f37ae46eede9d971532515ff3758ee1363e2f2ecf3c7ce846e::retirea {
    struct RETIREA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETIREA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"658f0410c1c70648f837fb84b386ea2fa0744fd738835013eeb111cfaed65bcc                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RETIREA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RETIRE      ")))), trim_right(b"Retire on Sol                   "), trim_right(x"546865205265746972656d656e742043656e74657220796f752068617665206265656e2077616974696e6720666f722e200a57656c636f6d6520617065732c2063686164732c207368696c6c6572732c20636174732c20646f67732c206469616d6f6e642068616e64732c2070617065722068616e64732e2057652077696c6c20666163696c697461746520796f757220657665727920646567656e6572617465206e6565642e20476f2066726f6d20616368696e67207061696e7320746f2066696e616e6369616c206761696e732e2046726f6d20776f726b696e67206861726420746f20686172646c7920776f726b696e672e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETIREA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETIREA>>(v4);
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

