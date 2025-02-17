module 0xfae895c89f06ceb07944a64876d4bfc4d74f38bd840e6f00095e9568153b4f0f::trit {
    struct TRIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreibyxvvc7xe2uge2om3ebyubsxi4rdvd3aepynucie7hemfddj4d5u                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TRIT>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TRIT    ")))), trim_right(b"Triton                          "), trim_right(b"The chill keeper of the Sui ocean who helps to navigate you through the sea of DeFi and DeFAI                                                                                                                                                                                                                                   "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TRIT>>(0x2::coin::mint<TRIT>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRIT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIT>>(v3);
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

