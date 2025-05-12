module 0x5fbc1ee67abdc54145cf46a80d8806ff9640698cba3515e28fd34f34b0b61d85::cereal {
    struct CEREAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEREAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EMBe4tZcRta5DU1uG7Loj5LENJKWJmJ4bL1rPqjG3Pye.png?claimId=IqqmI_p2z5OpBMVY                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CEREAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Cereal      ")))), trim_right(b"Cereal Guy                      "), trim_right(x"43657265616c20477579204d656d650a0a5468652043657265616c20477579206d656d65206973206120706f70756c6172207261676520636f6d696320636861726163746572207468617420666972737420617070656172656420696e20323030372e204974206f726967696e61746564206f6e20746865207765627369746520346368616e20616e6420717569636b6c7920737072656164206163726f73732074686520696e7465726e65742e2054686520636861726163746572206973206465706963746564206173206120737469636b206669677572652073697474696e672061742061207461626c652c20656174696e672063657265616c207768696c65206d616b696e6720736172636173746963206f7220626f6c6420636f6d6d656e74732e204f6674656e2c207468652070756e63686c696e6520696e636c75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEREAL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEREAL>>(v4);
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

