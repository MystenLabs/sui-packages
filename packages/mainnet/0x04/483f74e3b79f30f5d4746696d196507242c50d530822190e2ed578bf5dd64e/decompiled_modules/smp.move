module 0x4483f74e3b79f30f5d4746696d196507242c50d530822190e2ed578bf5dd64e::smp {
    struct SMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/SMP1xiPwpMiLPpnJtdEmsDGSL9fR1rvat6NFGznKPor.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SMP         ")))), trim_right(b"Sempai                          "), trim_right(x"546865206f6666696369616c207574696c69747920746f6b656e20666f722053656d706169204851277320526561642d546f2d4561726e204461707020616e642074686520706172746e657220746f2068657220676f7665726e616e636520746f6b656e2c20416d6574687973742e200a0a534d502077696c6c206265207573656420666f72207265776172647320616e64206576656e747320696e2074686520446170702c2061732077656c6c206173206d696e74696e67204e4654732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMP>>(v4);
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

