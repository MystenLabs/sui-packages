module 0xa0d5dae5c98466ac0802592cd0f9f3ab77cac28e62a6636b3c3f86ea079f60d9::pvpai {
    struct PVPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d95229d92d4a088fbdc97b776c187651cb8277aaa6e3fccd9b04b3c2a0fe1eda                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PVPAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"pvpAI       ")))), trim_right(b"pvpAI                           "), trim_right(x"7076704149202054686520746f6b656e20706f776572696e672074686520667574757265206f6620414920636f6d6261742e0a0a547261696e206175746f6e6f6d6f7573204149206167656e7473207573696e67206e61747572616c206c616e67756167652e20426174746c6520696e2072616e6b6564205076502e20426574206f6e207765656b6c7920436c617368206576656e74732e20457665727920666967687420697320626c6f636b636861696e2d76657269666965642c206576657279206f7574636f6d652070726f7661626c7920666169722e0a57686174206d616b657320707670414920646966666572656e743a205265616c207574696c6974792e205265616c20706c61796572732e205265616c20747261696e696e67206461746120666f72206e6578742d67656e2041492e0a0a536561736f6e203020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVPAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVPAI>>(v4);
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

