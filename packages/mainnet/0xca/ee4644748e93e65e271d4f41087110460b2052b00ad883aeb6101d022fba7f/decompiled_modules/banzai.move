module 0xcaee4644748e93e65e271d4f41087110460b2052b00ad883aeb6101d022fba7f::banzai {
    struct BANZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreihhhftsavxpioaer5adlbrnyt6sux5afrvboebhajp7veogjyjmei                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<BANZAI>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"banzai  ")))), trim_right(b"Banzai Ai Coin                  "), trim_right(x"42616e7a616920416920436f696e206675656c7320636f6d6d756e69747920696e746572616374696f6e0a756e6c6f636b73207072656d69756d20696e7369676874730a7265776172647320656e676167656d656e740a616e6420706f776572732067616d6966696564205765623320657870657269656e636573206c656420627920746865204149204167656e74202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<BANZAI>>(0x2::coin::mint<BANZAI>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BANZAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANZAI>>(v3);
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

