module 0xb485929c3521fe60aa98c6f48427d1b4ebe6bb20075ed3d46272b630f002514::curio {
    struct CURIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A7CBQGYvZ3JhBCrHEhVkSBpyyooCygw91tZbcV2gpump.png?claimId=tnw1fiGLWvjyUUxA                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CURIO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CURIO       ")))), trim_right(b"AI Kids Companion               "), trim_right(x"54686520576f726c6427732046697273742041692d506c757368696520546f79210a0a435552494f20496e74657261637469766520496e632e2069732061205374617274757020416920546f7920436f6d70616e792057686f277320436861726163746572732041726520566f69636564204279204772696d657320466561747572696e672022546865204f726967696e616c2047524f4b20506c7573686965222e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURIO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CURIO>>(v4);
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

